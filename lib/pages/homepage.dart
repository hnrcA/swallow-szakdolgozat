import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:swallow/auth.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final User? user  = Auth().currentuser;

  Future<void> signOut() async {
    await Auth().signOut();
  }

  Widget title() {
    return const Text("Swallow - Kezdőlap");
  }

  Widget userUid() {
    return  Text(user?.email ?? 'Email cím');
  }
  Widget signOutbutton() {
    return ElevatedButton(
        onPressed: signOut,
        child: const Text("Kijelentkezés")
    );
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
          title: title()
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        padding: const EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            userUid(),
            signOutbutton(),
          ],
        ),
      ) ,);
  }
}