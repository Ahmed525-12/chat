import 'package:firebase_auth/firebase_auth.dart';

import '../base/base_nav.dart';
import '../base/base_vm.dart';

class LoginViewModel extends BaseViewModel<BaseNavigator> {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  void login(String email, String password) async {
    try {
      baseNavigator?.showloading();
      var result = await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      baseNavigator?.showmesasge("log in sucssfeully");
      print(result.user?.uid);
      baseNavigator?.hideloading();
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
