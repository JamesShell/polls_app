import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../utils/pallete.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child:
            CircularProgressIndicator(color: kBlue, backgroundColor: kWhite));
  }
}
