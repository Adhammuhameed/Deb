import 'package:deb/base.dart';
import 'package:deb/database/database_utils.dart';
import 'package:deb/models/my_user.dart';
import 'package:deb/modules/login/login_navigator.dart';
import 'package:deb/shared/components/firebase_errors.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginScreenViewModel extends BaseViewModel<LoginNavigator> {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  String? message;

  void login(String email, String password) async {
    try {
      navigator!.showLoading();
      final credential =
      await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      MyUser? myUser = await DataBaseUtils.readUserFromFirestore(
          credential.user?.uid ?? "");
      if (myUser != null) {
        print(myUser.email);
        navigator!.goToAdmin(myUser);
      } else {
        message = "User Not Found In Database";
      }
      message = "Successfully Login";
    } on FirebaseAuthException catch (e) {
      message = "Wrong Email Or Password";

      // } catch (e) {
      //   message="Something went wrong";
      //   print(e);
      // }
      if (message != null) {
        navigator!.hideLoading();
        navigator!.showMessage(message!);
      }
    }
  }
}