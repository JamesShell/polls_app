import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:polls_app/resources/auth_methods.dart';
import 'package:polls_app/screens/auth/register.dart';
import 'package:polls_app/widgets/background_image.dart';
import 'package:polls_app/widgets/loading.dart';
import 'package:polls_app/widgets/rounded_button.dart';
import 'package:polls_app/widgets/text_input_field.dart';

import '../../responsive/mobile_screen_layout.dart';
import '../../responsive/responsive_layout_screen.dart';
import '../../responsive/web_screen_layout.dart';
import '../../utils/pallete.dart';
import '../../widgets/snackbar.dart';
import '../forgot_password_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void submit() async {
    setState(() {
      isLoading = true;
    });

    await AuthMethods()
        .loginUser(
            email: _emailController.text, password: _passwordController.text)
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

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const BackgroundImage(image: 'assets/images/login_bg.jpg'),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: isLoading
              ? const LoadingScreen()
              : Column(children: [
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
                      TextInputField(
                        icon: FontAwesomeIcons.envelope,
                        hint: "Email",
                        inputType: TextInputType.emailAddress,
                        inputAction: TextInputAction.next,
                        inputController: _emailController,
                      ),
                      TextInputField(
                        icon: FontAwesomeIcons.lock,
                        hint: "Password",
                        inputType: TextInputType.text,
                        inputAction: TextInputAction.done,
                        inputController: _passwordController,
                        hideInput: true,
                      ),
                      GestureDetector(
                        onTap: () => {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const ForgotPasswordScreen()))
                        },
                        child: const Text(
                          'Forgot Password',
                          style: kBodyText,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      RoundedButton(content: "Login", onPressed: () => submit())
                    ],
                  ),
                  GestureDetector(
                    onTap: () => {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const RegisterScreen(),
                        ),
                      )
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
