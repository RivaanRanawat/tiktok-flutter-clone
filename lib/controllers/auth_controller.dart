import 'dart:io';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:tiktok_tutorial/constants.dart';
import 'package:tiktok_tutorial/models/user_profile.dart';
import 'package:tiktok_tutorial/views/screens/auth/login_screen.dart';
import 'package:tiktok_tutorial/views/screens/home_screen.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.put(AuthController()); //Get.find();
  late Rx<User?> _user;
  late Rx<File?> _pickedImage;
  late Rx<ProfileUser?> _userProfile;

  File? get profilePhoto => _pickedImage.value;
  User get user => _user.value!;
  ProfileUser? get userProfile => _userProfile.value;

  @override
  void onReady() {
    super.onReady();

    _user = Rx<User?>(supabase.auth.currentUser);
    _userProfile = Rx<ProfileUser?>(null);

    supabase.auth.onAuthStateChange.listen((data) async {
      final AuthChangeEvent event = data.event;
      final Session? session = data.session;

      if (event == AuthChangeEvent.signedIn) {
        _user.value = session!.user;
        update();
        var profileData = await supabase
            .from('profiles')
            .select('id, username, avatar_url')
            .eq('id', user.id);

        if (profileData.length > 0) {
          final d = profileData[0];
          _userProfile.value = ProfileUser(
              username: d['username'],
              email: user.email,
              id: user.id,
              avatarUrl: d['avatar_url']);
          update();
        }
      } else if (event == AuthChangeEvent.signedOut) {
        _user.value = null;
      }
    });

    ever(_user, _setInitialScreen);
  }

  // Future<dynamic> _getProfile() async {
  //   try {
  //     // any way to avoid this?

  //     final profileData = await supabase
  //         .from('profiles')
  //         .select('id, username, avatar_url')
  //         .eq('id', user.id)
  //         .single();
  //     return profileData;
  //   } catch (e) {
  //     Get.snackbar(
  //       'Error fetching profile',
  //       e.toString(),
  //     );
  //   }
  // }

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

  // registering the user
  void registerUser(
      String username, String email, String password, File? image) async {
    try {
      if (username.isNotEmpty &&
          email.isNotEmpty &&
          password.isNotEmpty &&
          image != null) {
        // Create new user
        final cred = await supabase.auth.signUp(
          email: email,
          password: password,
        );

        _user.value = cred.user;
        update();

        final String downloadUrl =
            await supabase.storage.from('avatars').upload(
                  "avatar_${user.id}.${image.path.split('.').last}",
                  image,
                  fileOptions:
                      const FileOptions(cacheControl: '3600', upsert: false),
                );

        await supabase.from('profiles').insert(
            {'id': user.id, 'username': username, 'avatar_url': downloadUrl});
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
        'Error Logging in',
        e.toString(),
      );
    }
  }

  void signOut() async {
    // await firebaseAuth.signOut();
    await supabase.auth.signOut();
  }
}
