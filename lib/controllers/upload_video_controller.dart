import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:tiktok_tutorial/constants.dart';
// import 'package:tiktok_tutorial/models/video.dart';
import 'package:video_compress/video_compress.dart';
import 'package:uuid/uuid.dart';

class UploadVideoController extends GetxController {
  _compressVideo(String videoPath) async {
    final compressedVideo = await VideoCompress.compressVideo(
      videoPath,
      quality: VideoQuality.MediumQuality,
    );
    return compressedVideo!.file;
  }

  Future<String> _uploadVideoToStorage(
      String uid, String videoPath, String uuid) async {
    final compressedVideo = await _compressVideo(videoPath);
    final filename = "video_${uid}_${uuid}.mov";

    final String downloadUrl = await supabase.storage.from('videos').upload(
          filename,
          compressedVideo,
          fileOptions: const FileOptions(cacheControl: '3600', upsert: false),
        );

    return downloadUrl;
  }

  _getThumbnail(String videoPath) async {
    final thumbnail = await VideoCompress.getFileThumbnail(videoPath);
    return thumbnail;
  }

  Future<String> _uploadImageToStorage(
      String uid, String thumbnailPath, String uuid) async {
    final String downloadUrl = await supabase.storage.from('videos').upload(
          "thumbnail_${uid}_${uuid}.jpg",
          await _getThumbnail(thumbnailPath),
          fileOptions: const FileOptions(cacheControl: '3600', upsert: false),
        );

    return downloadUrl;
  }

  // upload video
  uploadVideo(String songName, String caption, String videoPath) async {
    try {
      String uid = supabase.auth.currentUser!.id;
      const uuidClass = Uuid();
      final uuid = uuidClass.v4();
      String videoUrl = await _uploadVideoToStorage(uid, videoPath, uuid);
      String thumbnail = await _uploadImageToStorage(uid, videoPath, uuid);

      // create video object
      await supabase.from('videos').insert({
        // 'id': uuid,
        'uid': uid,
        'username': authController.userProfile!.username,
        'likes': 0,
        'commentCount': 0,
        'shareCount': 0,
        'songName': songName,
        'caption': caption,
        'videoUrl': videoUrl,
        'profilePhoto': authController.userProfile!.avatarUrl,
        'thumbnail': thumbnail,
      });

      // Video video = Video(
      //   username: authController.userProfile!.username,
      //   uid: uid,
      //   id: "Video $uuid",
      //   likes: [],
      //   commentCount: 0,
      //   shareCount: 0,
      //   songName: songName,
      //   caption: caption,
      //   videoUrl: videoUrl,
      //   profilePhoto: authController.userProfile!.avatarUrl,
      //   thumbnail: thumbnail,
      // );

      // await firestore.collection('videos').doc('Video $len').set(
      //       video.toJson(),
      //     );
      Get.back();
    } catch (e) {
      Get.snackbar(
        'Error Uploading Video',
        e.toString(),
      );
    }
  }
}
