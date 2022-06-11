import 'package:chat/screens/base/base_state.dart';
import 'package:chat/screens/home/home_navigator.dart';
import 'package:chat/screens/home/home_view_model.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = "Home Page";
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends BaseState<HomeScreen,HomeViewModel>implements HomeNavigator {
  @override
  build(BuildContext context) {
    return Scaffold(
      appBar: null,
    );
  }
  
  @override
  HomeViewModel initViewModel()=>HomeViewModel();
  }

