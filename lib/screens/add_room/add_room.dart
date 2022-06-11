import 'package:chat/model/category.dart';
import 'package:chat/screens/add_room/add_room_navigator.dart';
import 'package:chat/screens/add_room/add_room_view_model.dart';
import 'package:chat/screens/base/base_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddRoom extends StatefulWidget {
  static const String routeName = "addroom";
  AddRoom({Key? key}) : super(key: key);

  @override
  State<AddRoom> createState() => _AddRoomState();
}

class _AddRoomState extends BaseState<AddRoom, AddRoomViewModel>
    implements AddRoomNavigator {
  GlobalKey<FormState> globalKey = GlobalKey<FormState>();

  String title = "";
  String discreption = "";
  var categories = Category.getCategory();
  late Category selected;
  @override
  void initState() {
    super.initState();
    selected = categories[0];
    viewModel.baseNavigator = this;
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
              title: const Text("Add Room"),
            ),
            body: Container(
              margin: const EdgeInsets.all(24),
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5), //color of shadow
                  spreadRadius: 5, //spread radius
                  blurRadius: 7, // blur radius
                  offset: const Offset(0, 2), // changes position of shadow
                  //first paramerter of offset is left-right
                  //second parameter is top to down
                ),
                //you can set more BoxShadow() here
              ], borderRadius: BorderRadius.circular(12), color: Colors.white),
              child: Form(
                key: globalKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      "Create New Room",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Image.asset("assets/img/addroom.png"),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return "type here please";
                        }
                        return null;
                      },
                      decoration: InputDecoration(hintText: "Room Title"),
                      onChanged: (val) {
                        title = val;
                        setState(() {});
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                          child: DropdownButton<Category>(
                              value: selected,
                              items: categories
                                  .map((cat) => DropdownMenuItem<Category>(
                                      value: cat,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          children: [
                                            Image.asset(cat.image),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            Text(cat.title)
                                          ],
                                        ),
                                      )))
                                  .toList(),
                              onChanged: (val) {
                                if (val == null) {
                                  return;
                                }
                                selected = val;
                                setState(() {});
                              }),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return "type here please";
                        }
                        return null;
                      },
                      decoration: InputDecoration(hintText: "Description"),
                      onChanged: (val) {
                        discreption = val;
                        setState(() {});
                      },
                    ),
                    ElevatedButton(
                        onPressed: () {
                          validateFrom();
                        },
                        child: const Text("Create"))
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  void validateFrom() {
    if (globalKey.currentState!.validate() == true) {
      viewModel.createRoom(title, discreption, selected.id);
    }
  }

  @override
  AddRoomViewModel initViewModel() => AddRoomViewModel();

  @override
  void roomCreated() {
    showmesasge("your room is created");
   
  }
}
