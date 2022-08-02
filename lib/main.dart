import 'package:firebase_core/firebase_core.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:polls_app/utils/pallete.dart';
import 'firebase_options.dart';

import '../providers/user_provider.dart';
import '../widgets/error.dart';
import '../widgets/loading.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'responsive/mobile_screen_layout.dart';
import 'responsive/responsive_layout_screen.dart';
import 'responsive/web_screen_layout.dart';
import 'screens/auth/login.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _fbApp = Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _fbApp,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          // ignore: avoid_print
          print('Error found: ${snapshot.error.toString()}');
          return ErrorScreen(errorString: snapshot.error.toString());
        } else if (snapshot.hasData) {
          return MultiProvider(
            providers: [
              ChangeNotifierProvider(
                create: (_) => UserProvider(),
              ),
            ],
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                appBarTheme: AppBarTheme(
                  color: kBlue,
                  titleTextStyle:
                      GoogleFonts.signika(fontSize: 16, color: Colors.white),
                  toolbarTextStyle:
                      GoogleFonts.signika(fontSize: 16, color: Colors.white),
                ),
                textTheme: GoogleFonts.signikaTextTheme(
                    Theme.of(context).textTheme.apply(
                          bodyColor: Colors.white,
                          displayColor: Colors.white,
                        )),
                scaffoldBackgroundColor: kWhite,
              ),
              title: 'Polls Up',
              home: StreamBuilder(
                  stream: FirebaseAuth.instance.authStateChanges(),
                  builder: ((context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.active) {
                      if (snapshot.hasData) {
                        return const ResponsiveLayout(
                          mobileScreenLayout: MobileScreenLayout(),
                          webScreenLayout: WebScreenLayout(),
                        );
                      } else if (snapshot.hasError) {
                        return ErrorScreen(
                            errorString: snapshot.error.toString());
                      }
                    } else if (snapshot.connectionState ==
                        ConnectionState.waiting) {
                      return const LoadingScreen();
                    }

                    return const LoginScreen();
                  })),
            ),
          );
        } else {
          return const LoadingScreen();
        }
      },
    );
  }
}
