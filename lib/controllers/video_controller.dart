// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:tiktok_tutorial/constants.dart';
import 'package:tiktok_tutorial/models/video.dart';

class VideoController extends GetxController {
  late Stream<List<Video>> _videos;

  Stream<List<Video>> get videos => _videos;

  @override
  Future<void> onInit() async {
    super.onInit();

    try {
      _videos = supabase.from('videos').stream(primaryKey: ['id']).map(
          (maps) => maps.map((map) => Video.fromMap(map: map)).toList());
    } catch (e) {
      print(e.toString());
    }

    update();
  }

  likeVideo(String id) async {
    // DocumentSnapshot doc = await firestore.collection('videos').doc(id).get();
    // var uid = authController.user.id;
    // if ((doc.data()! as dynamic)['likes'].contains(uid)) {
    //   await firestore.collection('videos').doc(id).update({
    //     'likes': FieldValue.arrayRemove([uid]),
    //   });
    // } else {
    //   await firestore.collection('videos').doc(id).update({
    //     'likes': FieldValue.arrayUnion([uid]),
    //   });
    // }
  }
}
