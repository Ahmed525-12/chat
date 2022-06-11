import 'package:chat/screens/log/login_navigator.dart';
import 'package:chat/screens/log/login_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
  GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  bool isObscure = true;

  String email = "";
  String password = "";
  @override
  void initState() {
    viewModel.baseNavigator = this;
    super.initState();
  }

  @override
  build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => viewModel,
      child: Stack(
        children: [
          Container(
            color: Colors.white,
            child: Image.asset(
              "assets/img/signin.png",
              alignment: Alignment.center,
              fit: BoxFit.fill,
              width: double.infinity,
            ),
          ),
          Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              title: const Text("Log in"),
              centerTitle: true,
              elevation: 0,
              backgroundColor: Colors.transparent,
            ),
            body: Form(
                key: globalKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(2),
                      child: TextFormField(
                        onChanged: (value) {
                          email = value;
                        },
                        decoration: const InputDecoration(
                          labelText: "Email",
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),
                        ),
                        validator: (text) {
                          if (text == null || text.trim().isEmpty) {
                            return "please fill this field";
                          }
                          bool emailValid = RegExp(
                                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(text);

                          if (!emailValid) {
                            return "email not valid";
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(2),
                      child: TextFormField(
                        obscureText: isObscure,
                        onChanged: (value) {
                          password = value;
                        },
                        decoration: InputDecoration(
                          suffix: IconButton(
                              color: Colors.blue,
                              onPressed: () {
                                isObscure = !isObscure;
                                setState(() {});
                              },
                              icon: Icon(
                                isObscure
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: Colors.blue,
                              )),
                          labelText: "password",
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),
                        ),
                        validator: (text) {
                          if (text == null || text.trim().isEmpty) {
                            return "please fill this field";
                          }

                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextButton(
                                onPressed: () {
                                  Navigator.pushNamed(
                                      context, RegisterScreen.routeName);
                                },
                                child: const Text("Create Account")),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: FloatingActionButton(
                                  onPressed: () {
                                    vlidateKey();
                                  },
                                  child: const Icon(Icons
                                      .keyboard_double_arrow_right_outlined)),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                )),
          ),
        ],
      ),
    );
  }

  void vlidateKey() async {
    if (globalKey.currentState?.validate() == true) {
      viewModel.login(email, password);
    }
  }

  @override
  LoginViewModel initViewModel() {
    return LoginViewModel();
  }

  @override
  void goToHome() {
    Navigator.pushReplacementNamed(context, "routeName");
  }
}
