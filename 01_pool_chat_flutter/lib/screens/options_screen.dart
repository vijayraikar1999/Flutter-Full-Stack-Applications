import 'package:flutter/material.dart';
import 'package:pool_chat_flutter/screens/login_screen.dart';
import 'package:pool_chat_flutter/screens/registration_screen.dart';

class OptionsScreen extends StatelessWidget {
  const OptionsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      // backgroundColor: const Color(0xFF544F55),
      // backgroundColor: const Color(0xFF595260),
      // backgroundColor: const Color(0xFF4d4653),
      backgroundColor: const Color(0xFF4d4653),
      // backgroundColor: const Color(0xFF403b45),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              SizedBox(
                height: 40.0,
                child: Image.asset('assets/images/Deadpool-Logo.png'),
              ),
              const Text(
                'Pool Chat',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 40.0,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
          const SizedBox(height: 48.0),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Material(
              elevation: 5.0,
              color: Colors.lightBlueAccent,
              borderRadius: BorderRadius.circular(30.0),
              child: MaterialButton(
                onPressed: () => Navigator.pushNamed(context, LoginScreen.id),
                minWidth: size.width * 0.9,
                height: 42.0,
                child: const Text('Log In'),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Material(
              elevation: 5.0,
              color: Colors.blueAccent,
              borderRadius: BorderRadius.circular(30.0),
              child: MaterialButton(
                onPressed: () =>
                    Navigator.pushNamed(context, RegistrationScreen.id),
                minWidth: size.width * 0.9,
                height: 42.0,
                child: const Text('Register'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// import 'package:flutter/material.dart';
//
// class OptionsScreen extends StatelessWidget {
//   const OptionsScreen({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // backgroundColor: const Color(0xFF4A5A6D),
//       body: Stack(
//         children: [
//           Image.asset(
//             'assets/images/pool_chat_pic4.jpg',
//             height: double.infinity,
//             width: double.infinity,
//             fit: BoxFit.cover,
//           ),
//           Column(
//             children: const [
//               Positioned(
//                 left: 1,
//                 right: 2,
//                 child: Text(
//                   'Log in',
//                   style: TextStyle(color: Colors.white),
//                 ),
//               ),
//               Text(
//                 'Register',
//                 style: TextStyle(color: Colors.white),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
//
