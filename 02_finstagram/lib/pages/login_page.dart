import 'package:finstagram/pages/home_page.dart';
import 'package:finstagram/pages/register_page.dart';
import 'package:finstagram/services/firebase_service.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  static String id = 'login';

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  Size? size;

  FirebaseService? _firebaseService;

  final GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();

  String? _email;
  String? _password;

  @override
  void initState() {
    super.initState();
    _firebaseService = GetIt.instance.get<FirebaseService>();
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _titleWidget(),
                _loginForm(),
                _loginButton(),
                _registerPageLink(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _titleWidget() {
    return const Text(
      'Finstagram',
      style: TextStyle(
        color: Colors.black,
        fontSize: 25.0,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Widget _loginButton() {
    return MaterialButton(
      onPressed: _loginUser,
      minWidth: size!.width * 0.70,
      height: size!.height * 0.06,
      color: Colors.red,
      child: const Text(
        'Login',
        style: TextStyle(
          color: Colors.white,
          fontSize: 25.0,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _loginForm() {
    return Container(
      height: size!.height * 0.20,
      child: Form(
        key: _loginFormKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _emailTextField(),
            _passwordTextField(),
          ],
        ),
      ),
    );
  }

  Widget _emailTextField() {
    return TextFormField(
      decoration: const InputDecoration(
        hintText: 'Email...',
      ),
      onSaved: (_value) {
        setState(() {
          _email = _value;
        });
      },
      validator: (_value) {
        bool _result = _value!.contains(
          RegExp(
              r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$"),
        );
        return _result ? null : "Please enter a valid email";
      },
    );
  }

  Widget _passwordTextField() {
    return TextFormField(
      obscureText: true,
      decoration: const InputDecoration(
        hintText: 'Password...',
      ),
      onSaved: (_value) {
        setState(() {
          _password = _value;
        });
      },
      validator: (_value) => _value!.length > 6
          ? null
          : 'Please enter a value greater than 6 characters.',
    );
  }

  Widget _registerPageLink() {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, RegisterPage.id),
      child: const Text(
        "Don't have an account?",
        style: TextStyle(
          color: Colors.blue,
          fontSize: 15.0,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  void _loginUser() async {
    if (_loginFormKey.currentState!.validate()) {
      _loginFormKey.currentState!.save();
      bool _result = await _firebaseService!.loginUser(
        email: _email!,
        password: _password!,
      );
      if (_result) {
        Navigator.popAndPushNamed(
          context,
          HomePage.id,
        );
      }
    }
  }
}
