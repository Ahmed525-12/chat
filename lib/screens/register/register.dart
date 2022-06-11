import 'package:chat/model/myuser.dart';
import 'package:chat/provider/user_provider.dart';
import 'package:chat/screens/base/base_state.dart';
import 'package:chat/screens/home/home_screen.dart';
import 'package:chat/screens/log/login.dart';
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

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String firstname = '';

  String lastname = '';

  String email = '';

  String password = '';

  String username = '';

  @override
  void initState() {
    super.initState();
    // don't forget
    viewModel.baseNavigator = this;
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => viewModel,
      child: Builder(builder: (_) {
        return Stack(
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
                  'Create Account',
                ),
              ),
              body: Container(
                padding: EdgeInsets.all(12),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextFormField(
                        decoration: InputDecoration(labelText: 'First Name'),
                        onChanged: (text) {
                          firstname = text;
                        },
                        validator: (text) {
                          if (text == null || text.trim().isEmpty) {
                            return 'Please enter first Name';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                          decoration: InputDecoration(labelText: 'Last Name'),
                          onChanged: (text) {
                            lastname = text;
                          },
                          validator: (text) {
                            if (text == null || text.trim().isEmpty) {
                              return 'Please enter last Name';
                            }
                            return null;
                          }),
                      TextFormField(
                          decoration: InputDecoration(labelText: 'User Name'),
                          onChanged: (text) {
                            username = text;
                          },
                          validator: (text) {
                            if (text == null || text.trim().isEmpty) {
                              return 'Please enter user Name';
                            }
                            if (text.contains(' ')) {
                              return 'user name must not contains white spaces';
                            }
                            return null;
                          }),
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
                          child: Text('Create Account')),
                      InkWell(
                          onTap: () {
                            Navigator.pushReplacementNamed(
                                context, LogIn.routeName);
                          },
                          child: Text("Already have an account ? "))
                    ],
                  ),
                ),
              ),
            )
          ],
        );
      }),
    );
  }

  void vlidateKey() async {
    if (formKey.currentState?.validate() == true) {
      viewModel.register(email, password, firstname, lastname, username);
    }
  }

  @override
  void goToHome(MyUser myUser) {
    hideloading();
    var userprovider = Provider.of<UserProvider>(context,listen: false);
    userprovider.user = myUser;
    Navigator.pushReplacementNamed(context, HomeScreen.routeName);
  }
}
