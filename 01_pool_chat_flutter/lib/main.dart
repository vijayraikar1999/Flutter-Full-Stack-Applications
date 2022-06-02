import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pool_chat_flutter/screens/chat_screen.dart';
import 'package:pool_chat_flutter/screens/login_screen.dart';
import 'package:pool_chat_flutter/screens/registration_screen.dart';

import '/screens/welcome_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pool Chat',
      initialRoute: 'welcome_screen',
      routes: {
        WelcomeScreen.id: (context) => const WelcomeScreen(),
        LoginScreen.id: (context) => const LoginScreen(),
        RegistrationScreen.id: (context) => const RegistrationScreen(),
        ChatScreen.id: (context) => const ChatScreen(),
      },
    );
  }
}
