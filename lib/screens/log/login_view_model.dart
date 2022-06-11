import 'package:chat/database/database_utils.dart';
import 'package:chat/screens/log/login_navigator.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../base/base_nav.dart';
import '../base/base_vm.dart';

class LoginViewModel extends BaseViewModel<LoginNavigator> {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  void login(String email, String password) async {
    try {
      baseNavigator?.showloading();
      var result = await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      var userObj = DataBaseUtils.readuser(result.user?.uid ?? "");
      if (userObj == null) {
        baseNavigator?.showmesasge("Failed to Complete sign in ");
      } else {
        baseNavigator?.goToHome();
      }

      baseNavigator?.hideloading();
      return;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        baseNavigator?.showmesasge("the user not found .");
        baseNavigator?.hideloading();
      } else if (e.code == 'wrong-password') {
        baseNavigator?.showmesasge("wrong password");
        baseNavigator?.hideloading();
      }
    } catch (e) {
      baseNavigator?.showmesasge("something went wrong ");
    }
  }
}
