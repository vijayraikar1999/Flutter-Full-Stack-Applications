import 'package:flutter/material.dart';
import 'package:pool_chat_flutter/screens/options_screen.dart';

class WelcomeScreen extends StatefulWidget {
  static const String id = 'welcome_screen';

  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF191919),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/pool_chat1.jpg',
            ),
            GestureDetector(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const OptionsScreen(),
                ),
              ),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
                decoration: BoxDecoration(
                  color: const Color(0xFFa20000),
                  borderRadius: BorderRadius.circular(25.0),
                ),
                child: const Text(
                  'Let\'s go to the Pool Chat',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                    fontFamily: 'DancingScript',
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
