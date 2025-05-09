import 'dart:convert';

import 'package:ai_test_app/common/functions.dart';
import 'package:ai_test_app/common/style.dart';
import 'package:ai_test_app/screen/info.dart';
import 'package:ai_test_app/services/ad.dart';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  BannerAd bannerAd = AdService.createBannerAd();
  Gemini gemini = Gemini.instance;
  ChatUser currentUser = ChatUser(
    id: '0',
    firstName: 'user',
  );
  ChatUser geminiUser = ChatUser(
    id: '1',
    firstName: 'お母さん',
    profileImage: 'https://agora-c.com/tmp/mother.png',
  );
  List<ChatMessage> messages = [];

  void _initBannerAd() async {
    await bannerAd.load();
  }

  Future _savePrefs(List<ChatMessage> messages) async {
    await allRemovePrefs();
    List<Map<String, dynamic>> dataList = [];
    for (final message in messages) {
      dataList.add(message.toJson());
    }
    final jsonString = jsonEncode(dataList);
    await setPrefsString('chatList', jsonString);
  }

  Future _loadPrefs() async {
    List<ChatMessage> tmpMessages = [];
    final jsonString = await getPrefsString('chatList');
    if (jsonString != null) {
      List<dynamic> decodedList = jsonDecode(jsonString);
      for (final data in decodedList) {
        ChatMessage tmpMessage = ChatMessage.fromJson(data);
        tmpMessages.add(tmpMessage);
      }
    }
    setState(() {
      messages = tmpMessages;
    });
  }

  void _sendMessage(ChatMessage chatMessage) async {
    setState(() {
      messages = [chatMessage, ...messages];
    });
    try {
      String question = '一文で簡潔に、田舎のお母さんのような言葉で答えてください：${chatMessage.text}';
      gemini.promptStream(
        parts: [Part.text(question)],
        generationConfig: GenerationConfig(
          maxOutputTokens: 30,
        ),
      ).listen((value) {
        ChatMessage? lastMessage = messages.firstOrNull;
        if (lastMessage != null && lastMessage.user == geminiUser) {
          lastMessage = messages.removeAt(0);
          String response = value?.output ?? '';
          lastMessage.text += response.trim();
          setState(() {
            messages = [lastMessage!, ...messages];
          });
        } else {
          String response = value?.output ?? '';
          ChatMessage message = ChatMessage(
            user: geminiUser,
            createdAt: DateTime.now(),
            text: response.trim(),
          );
          setState(() {
            messages = [message, ...messages];
          });
        }
      });
    } catch (e) {
      print(e);
    }
    await _savePrefs(messages);
  }

  void _init() async {
    await _loadPrefs();
  }

  @override
  void initState() {
    _initBannerAd();
    _init();
    super.initState();
  }

  @override
  void dispose() {
    bannerAd.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('お母さん'),
        actions: [
          IconButton(
            onPressed: () => showBottomUpScreen(
              context,
              InfoScreen(),
            ),
            icon: const FaIcon(FontAwesomeIcons.ellipsisVertical),
          ),
        ],
      ),
      body: Column(
        children: [
          bannerAd.responseInfo != null
              ? SizedBox(
                  width: bannerAd.size.width.toDouble(),
                  height: bannerAd.size.height.toDouble(),
                  child: AdWidget(ad: bannerAd),
                )
              : Container(),
          Expanded(
            child: DashChat(
              currentUser: currentUser,
              onSend: _sendMessage,
              messages: messages,
              inputOptions: InputOptions(
                inputDecoration: InputDecoration(
                  hintText: 'メッセージを入力できます...',
                  border: InputBorder.none,
                  filled: true,
                  fillColor: kBackgroundColor,
                ),
                sendButtonBuilder: (onSend) {
                  return IconButton(
                    onPressed: onSend,
                    icon: FaIcon(
                      FontAwesomeIcons.solidPaperPlane,
                      size: 20,
                      color: kMainColor,
                    ),
                  );
                },
              ),
              messageOptions: MessageOptions(
                showOtherUsersName: false,
                currentUserContainerColor: kMainColor,
                borderRadius: 16,
                messageTextBuilder: (current, prev, next) {
                  return Text(
                    current.text,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'TekitouPoem_Bold',
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
