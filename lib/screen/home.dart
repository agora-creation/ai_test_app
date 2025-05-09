import 'package:ai_test_app/common/style.dart';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final Gemini gemini = Gemini.instance;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('お母さん'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.menu),
          ),
        ],
      ),
      body: DashChat(
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
              icon: Icon(
                Icons.send,
                color: kMainColor,
              ),
            );
          },
        ),
        messageOptions: MessageOptions(
          showOtherUsersName: false,
          currentUserContainerColor: kMainColor,
          borderRadius: 16,
        ),
      ),
    );
  }

  void _sendMessage(ChatMessage chatMessage) {
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
          lastMessage.text += response;
          setState(() {
            messages = [lastMessage!, ...messages];
          });
        } else {
          String response = value?.output ?? '';
          ChatMessage message = ChatMessage(
            user: geminiUser,
            createdAt: DateTime.now(),
            text: response,
          );
          setState(() {
            messages = [message, ...messages];
          });
        }
      });
    } catch (e) {
      print(e);
    }
  }
}
