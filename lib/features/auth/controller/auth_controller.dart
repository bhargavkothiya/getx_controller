import 'package:demo_project/routes/app_routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;

  // GoogleSignIn instance ko initialize karein

  final GoogleSignIn googleSignIn = GoogleSignIn();

  late Rx<User?> _user;

  @override
  void onReady() {
    super.onReady();
    _user = Rx<User?>(auth.currentUser);
    _user.bindStream(auth.userChanges());
    ever(_user, _initialScreen);
  }

  _initialScreen(User? user) {
    if (user == null) {
      return Get.offAllNamed(
        AppRoutes.login,
      ); // AppRoutes.login ka path use karein
    } else {
      Get.offAllNamed('/bottomNavScreen');
    }
  }

  void loginWithGoogle() async {
    try {
      // Sign in process
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

      if (googleUser != null) {
        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;

        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        await auth.signInWithCredential(credential);
      }
    } catch (e, str) {
      Get.snackbar(
        "Error",
        "Login failed: $e",
        snackPosition: SnackPosition.BOTTOM,
      );
      print("Login Error: $e");
    }
  }

  void logout() async {
    await googleSignIn.signOut();
    await auth.signOut();
  }
}
