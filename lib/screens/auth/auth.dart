import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:polls_app/screens/auth/login.dart';

import '../../responsive/mobile_screen_layout.dart';
import '../../responsive/responsive_layout_screen.dart';
import '../../responsive/web_screen_layout.dart';
import '../../widgets/error.dart';
import '../../widgets/loading.dart';

class Auth extends StatelessWidget {
  const Auth({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: ((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            if (snapshot.hasData) {
              return ResponsiveLayout(
                mobileScreenLayout: MobileScreenLayout(),
                webScreenLayout: WebScreenLayout(),
              );
            } else if (snapshot.hasError) {
              return ErrorScreen(errorString: snapshot.error.toString());
            }
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return LoadingScreen();
          }

          return LoginScreen();
        }));
  }
}
