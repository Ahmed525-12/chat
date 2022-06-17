import 'package:chat/screens/base/base_nav.dart';
import 'package:chat/screens/base/base_vm.dart';
import 'package:flutter/material.dart';

abstract class BaseState<T extends StatefulWidget, VM extends BaseViewModel>
    extends State<T> implements BaseNavigator {
 
  VM initViewModel();
 late VM viewModel= initViewModel() ;


  @override
  void initState() {
    super.initState();
    viewModel = initViewModel();
  }

  
  @override
  void hideloading() {
  Navigator.popUntil(context, (route) {
    bool isVisible = route is PopupRoute;
    return !isVisible;
    });
  }
    @override
  void hideloadingg() {
                  Navigator.pop(context);

  }

  @override
  void showloading() {
    showDialog(
        context: context,
        builder: (_) => const AlertDialog(
              title: Center(child: CircularProgressIndicator.adaptive()),
            ));
  }
@override
  void showmesasge(String message,{String? actionName , VoidCallback? action}) {
    List<Widget>actions = [];
    if(actionName!=null){
      actions.add(
        TextButton(onPressed: action, child: Text(actionName)));
    }

    showDialog(
        context: context,
        builder: (_) => AlertDialog(
          actions: actions,
          content: Row(
            children: [Expanded(child: Text(message))],
          ),
        ));
  }

}
