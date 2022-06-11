import 'package:chat/model/myuser.dart';
import 'package:chat/screens/home/home_screen.dart';
import 'package:chat/screens/log/login_navigator.dart';
import 'package:chat/screens/log/login_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/user_provider.dart';
import '../base/base_state.dart';
import '../register/register.dart';

class LogIn extends StatefulWidget {
  static const String routeName = "login";

  LogIn({Key? key}) : super(key: key);

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends BaseState<LogIn, LoginViewModel>
    implements LoginNavigator {
  @override
  LoginViewModel initViewModel() => LoginViewModel();
  @override
  void initState() {
    super.initState();
    viewModel.baseNavigator = this;
  }
  String email='';
  String password='';
  var globalKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<LoginViewModel>(
      create: (buildContext)=>viewModel,
      child: Stack(
        children: [
          Container(
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
              title: Text(
                'Login',
              ),
            ),
            body: Container(
              padding: EdgeInsets.all(12),
              child: Form(
                key: globalKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextFormField(
                        decoration: InputDecoration(labelText: 'Email'),
                        onChanged: (text) {
                          email = text;
                        },
                        validator: (text) {
                          if (text == null || text.trim().isEmpty) {
                            return 'Please enter Email';
                          }

                          bool emailValid = RegExp(
                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(text);
                          if (!emailValid) {
                            return 'email format not valid';
                          }
                          return null;
                        }),
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Password'),
                      onChanged: (text) {
                        password = text;
                      },
                      validator: (text) {
                        if (text == null || text.trim().isEmpty) {
                          return 'please enter password';
                        }
                        if (text.trim().length < 6) {
                          return 'password should be at least 6 chars';
                        }
                        return null;
                      },
                    ),
                    ElevatedButton(
                        onPressed: () {
                          vlidateKey();
                        },
                        child: Text('Login')),
                    InkWell(
                        onTap: (){
                          Navigator.pushReplacementNamed(context,
                              RegisterScreen.routeName);
                        },
                        child: Text("Don't have an account ? "))
                  ],
                ),
              ),
            ),
          )
        ],
      )
    );
  }

  void vlidateKey() async {
    if (globalKey.currentState?.validate() == true) {
      viewModel.login(email, password);
    }
  }

 

  @override
  void goToHome(MyUser myUser) {
    var userprovider = Provider.of<UserProvider>(context,listen: false);
    userprovider.user = myUser;
    Navigator.pushReplacementNamed(context, HomeScreen.routeName);
  }
}
