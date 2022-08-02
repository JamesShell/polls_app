import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:polls_app/resources/auth_methods.dart';
import 'package:polls_app/screens/auth/login.dart';
import 'package:polls_app/utils/pallete.dart';
import 'package:polls_app/widgets/imager.dart';
import 'package:polls_app/widgets/snackbar.dart';

import '../../responsive/mobile_screen_layout.dart';
import '../../responsive/responsive_layout_screen.dart';
import '../../responsive/web_screen_layout.dart';
import '../../widgets/background_image.dart';
import '../../widgets/loading.dart';
import '../../widgets/rounded_button.dart';
import '../../widgets/text_input_field.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _usernameController = TextEditingController();

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  final TextEditingController _passwordConfirmController =
      TextEditingController();
  bool isLoading = false;
  Uint8List? _file;

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _passwordConfirmController.dispose();
    super.dispose();
  }

  void submit() async {
    if (_passwordController.text == _passwordConfirmController.text) {
      setState(() {
        isLoading = true;
      });

      await AuthMethods()
          .signUpUser(
            email: _emailController.text,
            password: _passwordController.text,
            username: _usernameController.text,
            bio: "",
            file: _file,
          )
          .then((value) => value != 'success'
              ? showSnackBar(value, context)
              : Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => const ResponsiveLayout(
                      mobileScreenLayout: MobileScreenLayout(),
                      webScreenLayout: WebScreenLayout(),
                    ),
                  ),
                ));
    } else {
      showSnackBar("Please confirm your password", context);
    }

    setState(() {
      isLoading = false;
    });
  }

  _selectImage(BuildContext parentContext) async {
    return showDialog(
      context: parentContext,
      builder: (BuildContext context) {
        return SimpleDialog(
          children: [
            SimpleDialogOption(
              padding: const EdgeInsets.all(10),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.fromLTRB(0, 0, 5, 0),
                    child: const Icon(
                      Icons.camera,
                      size: 18,
                    ),
                  ),
                  const Text('Take a photo'),
                ],
              ),
              onPressed: () async {
                Navigator.pop(context);
                Uint8List? file = await pickImage(ImageSource.camera);
                setState(() {
                  _file = file;
                });
              },
            ),
            SimpleDialogOption(
              padding: const EdgeInsets.all(10),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.fromLTRB(0, 0, 5, 0),
                    child: const Icon(Icons.image, size: 18),
                  ),
                  const Text('Chose from gallery'),
                ],
              ),
              onPressed: () async {
                Navigator.of(context).pop();
                Uint8List? file = await pickImage(ImageSource.gallery);
                setState(() {
                  _file = file;
                });
              },
            ),
            SimpleDialogOption(
              padding: const EdgeInsets.all(10),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.fromLTRB(0, 0, 5, 0),
                    child: const Icon(Icons.cancel, size: 18),
                  ),
                  const Text('Cancel'),
                ],
              ),
              onPressed: () async {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const BackgroundImage(image: 'assets/images/register_bg.jpg'),
        Scaffold(
            backgroundColor: Colors.transparent,
            body: isLoading
                ? const LoadingScreen()
                : Column(
                    children: [
                      const Spacer(),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 25.0),
                        child: Center(
                          child: GestureDetector(
                            onTap: () => {
                              setState(() {
                                _selectImage(context);
                              })
                            },
                            child: CircleAvatar(
                              backgroundColor: Colors.grey.withOpacity(0.5),
                              radius: 54,
                              child: _file != null
                                  ? Container(
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          image: DecorationImage(
                                              fit: BoxFit.fill,
                                              alignment:
                                                  FractionalOffset.topCenter,
                                              image: MemoryImage(_file!))),
                                    )
                                  : const Icon(
                                      FontAwesomeIcons.user,
                                      color: kWhite,
                                      size: 28,
                                    ),
                            ),
                          ),
                        ),
                      ),
                      TextInputField(
                          icon: FontAwesomeIcons.user,
                          hint: "Username",
                          inputType: TextInputType.text,
                          inputAction: TextInputAction.next,
                          inputController: _usernameController),
                      TextInputField(
                          icon: FontAwesomeIcons.envelope,
                          hint: "Email",
                          inputType: TextInputType.emailAddress,
                          inputAction: TextInputAction.next,
                          inputController: _emailController),
                      TextInputField(
                          icon: FontAwesomeIcons.lock,
                          hint: "Password",
                          inputType: TextInputType.text,
                          inputAction: TextInputAction.next,
                          inputController: _passwordController,
                          hideInput: true),
                      TextInputField(
                          icon: FontAwesomeIcons.lock,
                          hint: "Confirm Password",
                          inputType: TextInputType.text,
                          inputAction: TextInputAction.done,
                          inputController: _passwordConfirmController,
                          hideInput: true),
                      const SizedBox(
                        height: 20,
                      ),
                      RoundedButton(
                          content: "Register", onPressed: () => submit()),
                      GestureDetector(
                        onTap: () => {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const LoginScreen()))
                        },
                        child: Container(
                          padding: const EdgeInsets.only(top: 10),
                          decoration: const BoxDecoration(
                            border: Border(
                              bottom: BorderSide(width: 1, color: kWhite),
                            ),
                          ),
                          child: const Text(
                            'Aleady Have an Account?',
                            style: kBodyText,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                    ],
                  )),
      ],
    );
  }
}
