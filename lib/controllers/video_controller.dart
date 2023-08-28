// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:tiktok_tutorial/constants.dart';
import 'package:tiktok_tutorial/models/video.dart';

class VideoController extends GetxController {
  late Rx<List<Video>> _videoList = Rx<List<Video>>([]);

  List<Video> get videoList => _videoList.value;

  @override
  Future<void> onInit() async {
    super.onInit();

    _videoList = Rx<List<Video>>([]);
    try {
      final List<dynamic> videoData = await supabase.from('videos').select();
      for (var i = 0; i < videoData.length; i++) {
        var un = videoData[i]['likes'];
        // print(un);
        // print(videoData[i]['id']);
        var vid = Video(
          username: videoData[i]['username'],
          uid: videoData[i]['uid'],
          id: videoData[i]['id'],
          likes: videoData[i]['likes'],
          commentCount: videoData[i]['commentCount'],
          shareCount: videoData[i]['shareCount'],
          songName: videoData[i]['songName'],
          caption: videoData[i]['caption'],
          videoUrl: videoData[i]['videoUrl'],
          profilePhoto: videoData[i]['profilePhoto'],
          thumbnail: videoData[i]['thumbnail'],
        );
        _videoList.value.add(vid);
      }
    } catch (e) {
      print(e.toString());
    }

    // print(videoData);
    // videoData.forEach((e, i) {
    //   print(e);
    // _videoList.value.add(Video(
    //   username: e['username'],
    //   uid: e['uid'],
    //   id: e['id'],
    //   likes: e['likes'],
    //   commentCount: e['commentCount'],
    //   shareCount: e['shareCount'],
    //   songName: e['songName'],
    //   caption: e['caption'],
    //   videoUrl: e['videoUrl'],
    //   profilePhoto: e['profilePhoto'],
    //   thumbnail: e['thumbnail'],
    // ));
    // });

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
