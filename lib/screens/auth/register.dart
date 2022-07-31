import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:polls_app/screens/auth/login.dart';
import 'package:polls_app/utils/pallete.dart';

import '../../widgets/background_image.dart';
import '../../widgets/rounded_button.dart';
import '../../widgets/text_input_field.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const BackgroundImage(image: 'assets/images/register_bg.jpg'),
        Scaffold(
            backgroundColor: Colors.transparent,
            body: Column(
              children: [
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 25.0),
                  child: Center(
                    child: CircleAvatar(
                      backgroundColor: Colors.grey.withOpacity(0.5),
                      radius: 54,
                      child: const Icon(
                        FontAwesomeIcons.user,
                        color: kWhite,
                        size: 28,
                      ),
                    ),
                  ),
                ),
                const TextInputField(
                  icon: FontAwesomeIcons.user,
                  hint: "Username",
                  inputType: TextInputType.text,
                  inputAction: TextInputAction.next,
                ),
                const TextInputField(
                  icon: FontAwesomeIcons.envelope,
                  hint: "Email",
                  inputType: TextInputType.emailAddress,
                  inputAction: TextInputAction.next,
                ),
                const TextInputField(
                    icon: FontAwesomeIcons.lock,
                    hint: "Password",
                    inputType: TextInputType.text,
                    inputAction: TextInputAction.next,
                    hideInput: true),
                const TextInputField(
                    icon: FontAwesomeIcons.lock,
                    hint: "Confirm Password",
                    inputType: TextInputType.text,
                    inputAction: TextInputAction.done,
                    hideInput: true),
                const SizedBox(
                  height: 20,
                ),
                RoundedButton(content: "Register", onPressed: () => {}),
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
