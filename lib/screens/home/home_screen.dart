import 'package:chat/screens/base/base_state.dart';
import 'package:chat/screens/home/home_navigator.dart';
import 'package:chat/screens/home/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = "Home Page";
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends BaseState<HomeScreen,HomeViewModel>implements HomeNavigator {
  @override
  build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => viewModel,
      child: Scaffold(
        floatingActionButton: FloatingActionButton(onPressed: () {
          
        },child: Icon(Icons.add),),
        appBar: AppBar(title: Text("Home"),),
      ),
    );
  }
  
  @override
  HomeViewModel initViewModel()=>HomeViewModel();
  }

