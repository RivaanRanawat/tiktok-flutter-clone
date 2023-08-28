import 'package:get/get.dart';
import 'package:tiktok_tutorial/constants.dart';

class ProfileController extends GetxController {
  final Rx<Map<String, dynamic>> _user = Rx<Map<String, dynamic>>({});
  Map<String, dynamic> get user => _user.value;

  final Rx<String> _uid = "".obs;

  updateUserId(String uid) {
    _uid.value = uid;
    getUserData();
  }

  getUserData() async {
    List<String> thumbnails = [];
    // var myVideos = await firestore
    //     .collection('videos')
    //     .where('uid', isEqualTo: _uid.value)
    //     .get();

    // for (int i = 0; i < myVideos.docs.length; i++) {
    //   thumbnails.add((myVideos.docs[i].data() as dynamic)['thumbnail']);
    // }

    final profileData = authController.userProfile;
    String profilePhoto = profileData!.avatarUrl;
    // int likes = 0;
    // int followers = 0;
    // int following = 0;
    // bool isFollowing = false;

    // for (var item in myVideos.docs) {
    //   likes += (item.data()['likes'] as List).length;
    // }
    // var followerDoc = await firestore
    //     .collection('users')
    //     .doc(_uid.value)
    //     .collection('followers')
    //     .get();
    // var followingDoc = await firestore
    //     .collection('users')
    //     .doc(_uid.value)
    //     .collection('following')
    //     .get();
    // followers = followerDoc.docs.length;
    // following = followingDoc.docs.length;

    // firestore
    //     .collection('users')
    //     .doc(_uid.value)
    //     .collection('followers')
    //     .doc(authController.user.id)
    //     .get()
    //     .then((value) {
    //   if (value.exists) {
    //     isFollowing = true;
    //   } else {
    //     isFollowing = false;
    //   }
    // });

    // _user.value = {
    //   'followers': followers.toString(),
    //   'following': following.toString(),
    //   'isFollowing': isFollowing,
    //   'likes': likes.toString(),
    //   'profilePhoto': profilePhoto,
    //   'name': name,
    //   'thumbnails': thumbnails,
    // };
    _user.value = {
      'followers': '0',
      'following': '0',
      'isFollowing': false,
      'likes': '0',
      'profilePhoto': profilePhoto,
      'name': profileData.username,
      'thumbnails': thumbnails,
    };
    update();
  }

  followUser() async {
    var doc = null; // TODO
    // var doc = await firestore
    //     .collection('users')
    //     .doc(_uid.value)
    //     .collection('followers')
    //     .doc(authController.user.id)
    //     .get();

    if (!doc.exists) {
      // await firestore
      //     .collection('users')
      //     .doc(_uid.value)
      //     .collection('followers')
      //     .doc(authController.user.id)
      //     .set({});
      // await firestore
      //     .collection('users')
      //     .doc(authController.user.id)
      //     .collection('following')
      //     .doc(_uid.value)
      //     .set({});
      _user.value.update(
        'followers',
        (value) => (int.parse(value) + 1).toString(),
      );
    } else {
      // await firestore
      //     .collection('users')
      //     .doc(_uid.value)
      //     .collection('followers')
      //     .doc(authController.user.id)
      //     .delete();
      // await firestore
      //     .collection('users')
      //     .doc(authController.user.id)
      //     .collection('following')
      //     .doc(_uid.value)
      //     .delete();
      _user.value.update(
        'followers',
        (value) => (int.parse(value) - 1).toString(),
      );
    }
    _user.value.update('isFollowing', (value) => !value);
    update();
  }
}
