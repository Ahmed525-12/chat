import 'package:chat/screens/base/base_state.dart';
import 'package:chat/screens/home/home_screen.dart';
import 'package:chat/screens/register/register_navigator.dart';
import 'package:chat/screens/register/register_view_model.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  static const String routeName = "RegisterScreen";

  RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends BaseState<RegisterScreen, RegisterViewModel>
    implements RegisterNavigator {
  @override
  RegisterViewModel initViewModel() {
    return RegisterViewModel();
  }

  GlobalKey<FormState> globalKey = GlobalKey<FormState>();

  bool isObscure = true;

  String firstname = "";

  String lastname = "";

  String username = "";

  String email = "";

  String password = "";
  @override
  void initState() {
    viewModel.baseNavigator = this;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
              title: const Text("create account"),
              centerTitle: true,
              elevation: 0,
              backgroundColor: Colors.transparent,
            ),
            body: Form(
                key: globalKey,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 50),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(2),
                          child: TextFormField(
                            onChanged: (value) {
                              firstname = value;
                            },
                            decoration: const InputDecoration(
                              labelText: "frist name",
                              labelStyle: TextStyle(color: Colors.black),
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
                              return null;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(2),
                          child: TextFormField(
                            onChanged: (value) {
                              lastname = value;
                            },
                            decoration: const InputDecoration(
                              labelText: "last name",
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
                              return null;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(2),
                          child: TextFormField(
                            onChanged: (value) {
                              username = value;
                            },
                            decoration: const InputDecoration(
                              labelText: "user name",
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
                              return null;
                            },
                          ),
                        ),
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

                              return null;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ElevatedButton(
                              onPressed: () {
                                vlidateKey();
                              },
                              child: const Text("Create Account")),
                        )
                      ],
                    ),
                  ),
                )),
          )
        ],
      ),
    );
  }

  void vlidateKey() async {
    if (globalKey.currentState?.validate() == true) {
      viewModel.register(email, password, firstname, lastname, username);
    }
  }

  @override
  void goToHome() {
    hideloading();
    Navigator.pushReplacementNamed(context, HomeScreen.routeName);
  }
}
