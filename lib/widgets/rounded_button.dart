import 'package:flutter/material.dart';

import '../utils/pallete.dart';

class RoundedButton extends StatelessWidget {
  const RoundedButton(
      {Key? key, required this.content, required this.onPressed})
      : super(key: key);
  final String content;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: MediaQuery.of(context).size.width * 0.8,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: kBlue,
      ),
      child: TextButton(
        onPressed: () {
          onPressed();
        },
        child: Text(
          content,
          style: kBodyText,
        ),
      ),
    );
  }
}
