import 'dart:async' show Future;
import 'dart:io' show File;
import 'package:flutter/foundation.dart' show compute;
import 'package:flutter/material.dart' show BuildContext;
import 'package:image/image.dart' as Im;
import 'dart:math' as Math;
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart' show getTemporaryDirectory;

Future<File> takeCompressedPicture(BuildContext context) async {
  var _imageFile = await ImagePicker.pickImage(source: ImageSource.gallery);
  if (_imageFile == null) {
    return null;
  }

  // You can have a loading dialog here but don't forget to pop before return file;

  final tempDir = await getTemporaryDirectory();
  final rand = Math.Random().nextInt(10000);
  _CompressImage compressObject =
      _CompressImage(_imageFile, tempDir.path, rand);
  String filePath = await _compressImage(compressObject);
  print('new path: ' + filePath);
  File file = File(filePath);

  // Pop loading

  return file;
}

Future<String> _compressImage(_CompressImage object) async {
  return compute(_decodeImage, object);
}

String _decodeImage(_CompressImage object) {
  Im.Image image = Im.decodeImage(object.imageFile.readAsBytesSync());

  

  // int maxHeight = 800;
  // int maxWidth = 800;
  // int imageHeight = image.height;
  // int imageWidth = image.width;
  // int height;
  // int width;
  // int ratio;

  // if (imageWidth > maxWidth) {
  //   ratio = (maxWidth ~/ imageWidth);
  //   height = imageHeight * ratio;
  //   width = imageWidth * ratio;
  // }

  // if (imageHeight > maxHeight) {
  //   ratio = (maxHeight ~/ imageHeight);
  //   height = imageHeight * ratio;
  //   width = imageWidth * ratio;
  // }

  Im.Image smallerImage = Im.copyResize(image,
      height: 500); // choose the size here, it will maintain aspect ratio
  var decodedImageFile = File(object.path + '/img_${object.rand}.jpg');
  decodedImageFile.writeAsBytesSync(Im.encodeJpg(smallerImage, quality: 80));
  return decodedImageFile.path;
}

class _CompressImage {
  File imageFile;
  String path;
  int rand;

  _CompressImage(this.imageFile, this.path, this.rand);
}
