import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:polls_app/utils/pallete.dart';
import 'package:polls_app/widgets/background_image.dart';
import 'package:polls_app/widgets/rounded_button.dart';
import 'package:polls_app/widgets/text_input_field.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const BackgroundImage(image: 'assets/images/login_bg.jpg'),
        Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            title: const Text(
              'Forgot Password',
              style: kBodyText,
            ),
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios,
                color: kWhite,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            elevation: 0,
            centerTitle: true,
          ),
          backgroundColor: Colors.transparent,
          body: Center(
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: const Text(
                    'Please enter your email adress to recive a 4 digit verification code.',
                    style: kBodyText,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const TextInputField(
                  icon: FontAwesomeIcons.envelope,
                  hint: "Email",
                  inputType: TextInputType.emailAddress,
                  inputAction: TextInputAction.done,
                ),
                RoundedButton(content: "Send Code", onPressed: () => {})
              ],
            ),
          ),
        )
      ],
    );
  }
}
