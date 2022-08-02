import 'package:flutter/material.dart';
import 'package:polls_app/utils/pallete.dart';

class Poll extends StatelessWidget {
  const Poll({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            /* First Choice */ Flexible(
              child: Container(
                width: MediaQuery.of(context).size.width,
                color: Colors.red,
                child: const Center(
                  child: Text(
                    '1st Option',
                    style: kBodyText,
                  ),
                ),
              ),
            ),
            /* Second Choice */ Flexible(
              child: Container(
                width: MediaQuery.of(context).size.width,
                color: Colors.blue,
                child: const Center(
                  child: Text(
                    '2nd Option',
                    style: kBodyText,
                  ),
                ),
              ),
            ),
          ],
        ),
        Container(
            width: MediaQuery.of(context).size.width,
            height: 10,
            decoration: const BoxDecoration(
              color: Color(0xFF014666),
            )),
        Container(
          height: 40,
          width: MediaQuery.of(context).size.width / 5,
          decoration: BoxDecoration(
            color: const Color(0xFF014666),
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Center(
            child: Text(
              'OR',
              style: kBodyText,
            ),
          ),
        ),
      ],
    );
  }
}
