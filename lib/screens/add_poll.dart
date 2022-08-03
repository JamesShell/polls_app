import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:polls_app/widgets/imager.dart';

import '../utils/pallete.dart';
import '../widgets/rounded_button.dart';

class AddPollScreen extends StatefulWidget {
  const AddPollScreen({Key? key}) : super(key: key);

  @override
  State<AddPollScreen> createState() => _AddPollScreenState();
}

class _AddPollScreenState extends State<AddPollScreen> {
  final TextEditingController firstInputController = TextEditingController();
  final TextEditingController secondInputController = TextEditingController();
  Uint8List? firstImage;
  Uint8List? secondImage;

  @override
  void dispose() {
    firstInputController.dispose();
    secondInputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create New'),
        centerTitle: true,
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              /* First Choice */ Flexible(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: firstImage != null ? Colors.transparent : Colors.red,
                    image: firstImage != null
                        ? DecorationImage(
                            image: MemoryImage(firstImage!), fit: BoxFit.cover)
                        : null,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 28.0, vertical: 10),
                        child: TextField(
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "1st Option",
                            hintStyle: kBodyText,
                          ),
                          style: kBodyText,
                          controller: firstInputController,
                          maxLines: 3,
                        ),
                      ),
                      GestureDetector(
                        onTap: () async {
                          if (firstImage == null) {
                            Uint8List? file =
                                await pickImage(ImageSource.gallery);
                            setState(() {
                              firstImage = file;
                            });
                          } else {
                            setState(() {
                              firstImage = null;
                            });
                          }
                        },
                        child: Icon(
                          firstImage == null ? Icons.add_a_photo : Icons.cancel,
                          color: kWhite,
                          size: 25,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              /* Second Choice */ Flexible(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color:
                        secondImage != null ? Colors.transparent : Colors.blue,
                    image: secondImage != null
                        ? DecorationImage(
                            image: MemoryImage(secondImage!), fit: BoxFit.cover)
                        : null,
                    backgroundBlendMode: BlendMode.dstOver,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 28.0, vertical: 10),
                        child: TextField(
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "2st Option",
                            hintStyle: kBodyText,
                          ),
                          style: kBodyText,
                          controller: secondInputController,
                          maxLines: 3,
                        ),
                      ),
                      GestureDetector(
                        onTap: () async {
                          if (secondImage == null) {
                            Uint8List? file =
                                await pickImage(ImageSource.gallery);
                            setState(() {
                              secondImage = file;
                            });
                          } else {
                            setState(() {
                              secondImage = null;
                            });
                          }
                        },
                        child: Icon(
                          secondImage == null
                              ? Icons.add_a_photo
                              : Icons.cancel,
                          color: kWhite,
                          size: 25,
                        ),
                      )
                    ],
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
            ),
          ),
          RoundedButton(
            content: 'Post',
            onPressed: () {},
          )
        ],
      ),
    );
  }
}
