import 'package:ai_test_app/common/functions.dart';
import 'package:ai_test_app/common/style.dart';
import 'package:ai_test_app/widgets/info_list.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class InfoScreen extends StatelessWidget {
  const InfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhiteColor,
      appBar: AppBar(
        backgroundColor: kWhiteColor,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const FaIcon(FontAwesomeIcons.xmark),
            onPressed: () => Navigator.of(context, rootNavigator: true).pop(),
          ),
        ],
      ),
      body: Column(
        children: [
          InfoList(
            label: '利用規約',
            trailing: const FaIcon(
              FontAwesomeIcons.chevronRight,
              size: 16,
            ),
            onTap: () async {
              if (!await launchUrl(Uri.parse(
                'https://docs.google.com/document/d/1rOBchZBHvgOAnGB6Q69kUeeCDX3JhX0XRNiH7vk7IuQ/edit?usp=sharing',
              ))) {
                throw Exception('Could not launch');
              }
            },
          ),
          InfoList(
            label: 'アプリについての意見・要望',
            trailing: const FaIcon(
              FontAwesomeIcons.chevronRight,
              size: 16,
            ),
            onTap: () async {
              if (!await launchUrl(Uri.parse(
                'https://docs.google.com/forms/d/e/1FAIpQLScgJUGQRzNbzC4UKTmz30FLTZQZpGyDRl2p1W4ijAQGO2WbZQ/viewform?usp=dialog',
              ))) {
                throw Exception('Could not launch');
              }
            },
          ),
          InfoList(
            label: 'アプリのバージョン',
            trailing: FutureBuilder<String>(
              future: getVersionInfo(),
              builder: (context, snapshot) {
                return Text(
                  snapshot.data ?? '',
                  style: TextStyle(
                    color: kBlackColor,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
