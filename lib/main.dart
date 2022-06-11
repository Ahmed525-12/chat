import 'package:chat/provider/user_provider.dart';
import 'package:chat/screens/add_room/add_room.dart';
import 'package:chat/screens/home/home_screen.dart';
import 'package:chat/screens/log/login.dart';
import 'package:chat/screens/register/register.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiProvider(providers: [
ChangeNotifierProvider<UserProvider>(
      create: (context) => UserProvider(),
    ),
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var userprovider = Provider.of<UserProvider>(context);
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        RegisterScreen.routeName: (context) => RegisterScreen(),
        LogIn.routeName: (context) => LogIn(),
        HomeScreen.routeName: (context) => HomeScreen(),
        AddRoom.routeName: (context) => AddRoom(),
      },
      initialRoute:userprovider.firebaseUser==null? LogIn.routeName:HomeScreen.routeName,
    );
  }
}
