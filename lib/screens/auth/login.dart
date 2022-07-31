import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:polls_app/screens/auth/register.dart';
import 'package:polls_app/widgets/background_image.dart';
import 'package:polls_app/widgets/rounded_button.dart';
import 'package:polls_app/widgets/text_input_field.dart';

import '../../utils/pallete.dart';
import '../forgot_password_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const BackgroundImage(image: 'assets/images/login_bg.jpg'),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: Column(children: [
            const Flexible(
              child: Center(
                child: Text(
                  'Poll up',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 40,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
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
                  inputAction: TextInputAction.done,
                  hideInput: true,
                ),
                GestureDetector(
                  onTap: () => {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ForgotPasswordScreen()))
                  },
                  child: const Text(
                    'Forgot Password',
                    style: kBodyText,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                RoundedButton(content: "Login", onPressed: () => {})
              ],
            ),
            GestureDetector(
              onTap: () => {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const RegisterScreen()))
              },
              child: Container(
                padding: const EdgeInsets.only(top: 10),
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(width: 1, color: kWhite),
                  ),
                ),
                child: const Text(
                  'Create New Account',
                  style: kBodyText,
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
          ]),
        ),
      ],
    );
  }
}
