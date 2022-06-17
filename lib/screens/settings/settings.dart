import 'package:chat/screens/log/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Settings extends StatelessWidget {
  static const String RouteName = "settings";
  const Settings({Key? key}) : super(key: key);

  @override
  build(BuildContext context) {
    return Stack(
      children: [ Container(
            color: Colors.white,
            child: Image.asset(
              'assets/img/signin.png',
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.fill,
            ),
          ),
          Scaffold(
              backgroundColor: Colors.transparent,
              appBar: AppBar(
              centerTitle: true,
              elevation: 0,
              backgroundColor: Colors.transparent,
              title: const Text("Settings"),
             
            ),
            body:  ElevatedButton(onPressed: () async{
      await FirebaseAuth.instance.signOut();
       Navigator.pushNamedAndRemoveUntil(context, LogIn.routeName,(route) => false);
    }, child: Row(children: [Text("Log Out"), SizedBox(width:  5,), Icon(Icons.logout_outlined)],)),
          )
          ],
    );
  }
}
