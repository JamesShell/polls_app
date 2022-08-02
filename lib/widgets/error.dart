import 'package:flutter/material.dart';

class ErrorScreen extends StatelessWidget {
  final String errorString;
  const ErrorScreen({Key? key, required this.errorString}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SelectableText(errorString),
    );
  }
}
