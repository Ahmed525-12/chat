import 'package:chat/database/database_utils.dart';
import 'package:chat/model/room.dart';
import 'package:chat/screens/base/base_vm.dart';
import 'package:chat/screens/home/home_navigator.dart';

class HomeViewModel extends BaseViewModel<HomeNavigator> {
  List<Room> rooms = [];

  void getRooms() async {
    rooms = await DataBaseUtils.getRoomsFromFirestore();
    notifyListeners();
  }
}
