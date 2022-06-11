import 'package:chat/database/database_utils.dart';
import 'package:chat/model/myuser.dart';
import 'package:chat/screens/base/base_nav.dart';
import 'package:chat/screens/base/base_vm.dart';
import 'package:chat/screens/register/register_navigator.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterViewModel extends BaseViewModel<RegisterNavigator> {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  void register(String email, String password, String fname, String lname,
      String username) async {
    try {
      baseNavigator?.showloading();
      var result = await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      var user = MyUser(
          id: result.user?.uid ?? " ",
          fname: fname,
          lname: lname,
          username: username,
          email: email);
      var task = await DataBaseUtils.createDBUser(user);
      baseNavigator?.goToHome();
      print(result.user?.uid);
      baseNavigator?.hideloading();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        baseNavigator?.hideloading();
        baseNavigator?.showmesasge("The password provided is too weak.");
      } else if (e.code == 'email-already-in-use') {
        baseNavigator?.hideloading();
        baseNavigator
            ?.showmesasge("The account already exists for that email.");
      }
    } catch (e) {
      baseNavigator?.showmesasge("something went wrong ");
    }
  }
}
