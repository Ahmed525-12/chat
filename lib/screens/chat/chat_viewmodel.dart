import 'package:chat/database/database_utils.dart';
import 'package:chat/model/message.dart';
import 'package:chat/model/myuser.dart';
import 'package:chat/provider/user_provider.dart';
import 'package:chat/screens/base/base_vm.dart';
import 'package:chat/screens/chat/chat_navigator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

import '../../model/room.dart';

class ChatViewModel extends BaseViewModel<ChatNAvigator> {
  late Room room;
  late MyUser currentUser;
  late Stream<QuerySnapshot<Massage>> massageStream;
  void sendMassage(String massageContent) async {
    if (massageContent.trim().isEmpty) {
      return;
    }
    var massage = Massage(

        roomId: room.id,
        content: massageContent,
        dateTime: DateTime.now().microsecondsSinceEpoch,
        senderid: currentUser.id,
        senderName: currentUser.username);
    try {
      await DataBaseUtils.insertMessageToRoom(massage);
      baseNavigator?.clearMassageText();
    } catch (e) {
      baseNavigator?.showmesasge(e.toString());
    }
    notifyListeners();
  }

  void listenForRoomUpdates() {
   massageStream= DataBaseUtils.getMassageStream(room.id);
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    
  }
}
