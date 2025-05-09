import 'package:ai_test_app/common/style.dart';
import 'package:flutter/material.dart';

class InfoList extends StatelessWidget {
  final String label;
  final Widget? trailing;
  final Function()? onTap;

  const InfoList({
    required this.label,
    this.trailing,
    this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: kBlackColor.withOpacity(0.5),
          ),
        ),
      ),
      child: ListTile(
        title: Text(
          label,
          style: TextStyle(fontSize: 18),
        ),
        trailing: trailing,
        onTap: onTap,
      ),
    );
  }
}
