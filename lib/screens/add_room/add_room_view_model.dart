import 'package:chat/database/database_utils.dart';
import 'package:chat/screens/add_room/add_room_navigator.dart';
import 'package:chat/screens/base/base_vm.dart';

class AddRoomViewModel extends BaseViewModel<AddRoomNavigator> {
  void createRoom(String title, String desc, String id) async {
  baseNavigator?.showloading();
    String? message =null;
    try{
      var res  = await DataBaseUtils.createroom(title,desc,id);
    }catch(ex){
      message = ex.toString();
      message = 'something went wrong';
    }
    baseNavigator?.hideloading();
    if(message !=null){
      baseNavigator?.showmesasge(message);
    }else {
      baseNavigator?.roomCreated();
    }
  }
}
