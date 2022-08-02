import 'package:flutter/material.dart';
import 'package:polls_app/utils/pallete.dart';

showSnackBar(String content, BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        content,
        style: TextStyle(fontFamily: 'Nokia', fontSize: 11, color: kWhite),
      ),
      backgroundColor: kBlue,
    ),
  );
}
