import 'package:chat/model/message.dart';
import 'package:chat/model/myuser.dart';
import 'package:chat/model/room.dart';
import 'package:chat/provider/user_provider.dart';
import 'package:chat/screens/base/base_nav.dart';
import 'package:chat/screens/base/base_state.dart';
import 'package:chat/screens/chat/chat_navigator.dart';
import 'package:chat/screens/chat/chat_viewmodel.dart';
import 'package:chat/screens/chat/massage_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatScreen extends StatefulWidget {
  static const String routeNane = "chat screen";
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends BaseState<ChatScreen, ChatViewModel>
    implements ChatNAvigator {
  String massage = "";
  var textcontroller = TextEditingController();
  @override
  void initState() {
    super.initState();
    viewModel.baseNavigator = this;
  }

  @override
  build(BuildContext context) {
    Room room = ModalRoute.of(context)!.settings.arguments as Room;
    MyUser userProvider = Provider.of<UserProvider>(context).user!;
        viewModel.room = room;
    viewModel.currentUser = userProvider;
    viewModel.listenForRoomUpdates();

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
              title: Text(room.title),
            ),
            body: Container(
              width: double.infinity,
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
              child: Column(
                children: [
                  Expanded(
                      child: StreamBuilder<QuerySnapshot<Massage>>(
                    stream: viewModel.massageStream,
                    builder: (_, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                            child: CircularProgressIndicator.adaptive());
                      } else if (snapshot.hasError) {
                        return Center(child: Text(snapshot.error.toString()));
                      }
                      var massages =
                          snapshot.data!.docs.map((e) => e.data()).toList();
                      return ListView.builder(
                        itemBuilder: (context, index) {
                          return MassageWidget(massages.elementAt(index));
                        },
                        itemCount: massages.length,
                      );
                    },
                  )),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: textcontroller,
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.all(4),
                            hintText: 'Send masage ',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(12)),
                              borderSide: BorderSide(),
                            ),
                          ),
                          onChanged: (text) {
                            massage = text;
                          },
                          validator: (text) {
                            if (text == null || text.trim().isEmpty) {
                              return 'Please enter massage';
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      ElevatedButton(
                          onPressed: () {
                            viewModel.sendMassage(massage);
                          },
                          child: Row(
                            children: const [
                              Text("Send"),
                              SizedBox(
                                width: 8,
                              ),
                              Icon(Icons.send)
                            ],
                          ))
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  ChatViewModel initViewModel() => ChatViewModel();

  @override
  void clearMassageText() {
    textcontroller.clear();
  }
}
