import 'package:chat/database/database_utils.dart';
import 'package:chat/model/myuser.dart';
import 'package:chat/screens/base/base_vm.dart';
import 'package:chat/screens/register/register_navigator.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterViewModel extends BaseViewModel<RegisterNavigator> {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  
  void register(String email, String password, String firstName,
      String lastName, String userName) async {
    String? message;
    try {
      baseNavigator?.showloading();
      var result = await firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      // add user in databse
      var user = MyUser(
          id: result.user?.uid ?? "",
          fname: firstName,
          lname: lastName,
          username: userName,
          email: email);
      var task =  await DataBaseUtils.createDBUser(user);
      baseNavigator?.goToHome(user);
      return;
    } on FirebaseAuthException catch (e) {
      if (e.code == "weak-password") {
        message = 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        message = 'The account already exists for that email';
      } else {
        message = 'Wrong username or password';
      }
    } catch (e) {
      message = 'something went wrong';
    }
    baseNavigator?.hideloading();
    if (message != null) {
      baseNavigator?.showmesasge(message);
    }
  }
}
