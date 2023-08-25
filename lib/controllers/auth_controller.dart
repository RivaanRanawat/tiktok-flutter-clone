import 'dart:io';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:tiktok_tutorial/constants.dart';
// import 'package:tiktok_tutorial/models/user.dart';
import 'package:tiktok_tutorial/views/screens/auth/login_screen.dart';
import 'package:tiktok_tutorial/views/screens/home_screen.dart';
// import 'package:flutter/material.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();
  late Rx<User?> _user;
  late Rx<File?> _pickedImage;

  File? get profilePhoto => _pickedImage.value;
  User get user => _user.value!;

  @override
  void onReady() {
    super.onReady();

    _user = Rx<User?>(supabase.auth.currentUser);
    supabase.auth.onAuthStateChange.listen((data) {
      final AuthChangeEvent event = data.event;
      final Session? session = data.session;

      if (event == AuthChangeEvent.signedIn) {
        _user.value = session!.user;
      } else if (event == AuthChangeEvent.signedOut) {
        _user.value = null;
      }
    });

    ever(_user, _setInitialScreen);
  }

  _setInitialScreen(user) {
    if (user == null) {
      Get.offAll(() => LoginScreen());
    } else {
      Get.offAll(() => const HomeScreen());
    }
  }

  void pickImage() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      Get.snackbar('Profile Picture',
          'You have successfully selected your profile picture!');
    }
    _pickedImage = Rx<File?>(File(pickedImage!.path));
  }

  // upload to firebase storage
  Future<String> _uploadToStorage(File image) async {
    // TODO: fix this
    // Reference ref = firebaseStorage
    //     .ref()
    //     .child('profilePics')
    //     .child(firebaseAuth.currentUser!.uid);

    // UploadTask uploadTask = ref.putFile(image);
    // TaskSnapshot snap = await uploadTask;
    // String downloadUrl = await snap.ref.getDownloadURL();
    const downloadUrl = 'https://picsum.photos/250?image=9';
    return downloadUrl;
  }

  // registering the user
  void registerUser(
      String username, String email, String password, File? image) async {
    try {
      if (username.isNotEmpty &&
          email.isNotEmpty &&
          password.isNotEmpty &&
          image != null) {
        // save out user to our ath and firebase firestore
        // UserCredential cred = await firebaseAuth.createUserWithEmailAndPassword(
        //   email: email,
        //   password: password,
        // );
        final cred =
            await supabase.auth.signUp(email: email, password: password);
        // final session = cred.session;
        // final sbUser = cred.user;

        // String downloadUrl = await _uploadToStorage(image);
        // User user = MyUser(
        //   name: username,
        //   email: email,
        //   id: sbUser!.id,
        //   // profilePhoto: downloadUrl,
        // );
        // print(user.toJson());
        // await supabase.auth.updateUser({profilePhoto: downloadUrl}); // TODO: fix this

        // await firestore
        //     .collection('users')
        //     .doc(cred.user!.uid)
        //     .set(user.toJson());
      } else {
        Get.snackbar(
          'Error Creating Account',
          'Please enter all the fields',
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error Creating Account',
        e.toString(),
      );
    }
  }

  void loginUser(String email, String password) async {
    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        await supabase.auth.signInWithPassword(
          email: email,
          password: password,
        );
      } else {
        Get.snackbar(
          'Error Logging in',
          'Please enter all the fields',
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error Loggin gin',
        e.toString(),
      );
    }
  }

  void signOut() async {
    // await firebaseAuth.signOut();
    await supabase.auth.signOut();
  }
}
