import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:swallow/auth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String? errorMessage = '';
  bool isLogin = true;

  final TextEditingController controllerEmail = TextEditingController();
  final TextEditingController controllerPassword = TextEditingController();

  Future<void> signInWithEmailAndPassword() async {
    try{
      await Auth().signInWithEmailAndPassword(
          email: controllerEmail.text,
          password: controllerPassword.text);
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
    }
  }

  Future<void> createUserWithEmailAndPassword() async {
    try{
      await Auth().createUserWithEmailAndPassword(
          email: controllerEmail.text,
          password: controllerPassword.text);
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
    }
  }

  Widget _title() {
    return const Text("Swallow - Bejelentkezés/Regisztráció");
  }

  Widget _entryField(
      String title,
      TextEditingController controller,
      ) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: title,
      ),
    );
  }
  Widget _entryField_pass(
      String title,
      TextEditingController controller,
      ) {
    return TextField(
      obscureText: true,
      controller: controller,
      decoration: InputDecoration(
        labelText: title,
      ),
    );
  }

  Widget _errorMessage() {
    return Text(errorMessage == '' ? '' : '$errorMessage');
  }

  Widget _submitButton() {
    return ElevatedButton(
        onPressed: isLogin ? signInWithEmailAndPassword : createUserWithEmailAndPassword,
        child: Text(isLogin ? 'Bejelentkezés' : 'Regisztráció'),
    );
  }

  Widget _googleSignin() {
    return TextButton(
        onPressed: () {
        },
        child: Text('Google bejelentkezés')
    );
  }

  Widget _appleSignin() {
    return TextButton(
        onPressed: () {
        },
        child: Text('Apple ID bejelentkezés')
    );
  }

  Widget _loginOrRegButton() {
    return TextButton(
        onPressed: () {
          setState(() {
            isLogin = !isLogin;
          });
        },
        child: Text(isLogin ? 'Regisztráció' : 'Bejelentkezés')
    );
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: _title(),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _entryField('email', controllerEmail),
            _entryField_pass('password', controllerPassword),
            _errorMessage(),
            _submitButton(),
            _loginOrRegButton(),
            _googleSignin(),
            _appleSignin()
          ],
        ),
      ),
    );
  }
}