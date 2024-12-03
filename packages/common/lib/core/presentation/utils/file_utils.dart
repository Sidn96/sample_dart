import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';

enum MimeType{
  png, jpeg, none
}



class FileUtils{

  static const String jpg = 'jpg';
  static const String jpeg = 'jpeg';
  static const String png = 'png';




  /// pick image from web
  static Future<(Uint8List?, double?, String)> pickWebImage({String? mimeType = 'image/jpeg'}) async {
    Uint8List? webImage = Uint8List(8);
    ImagePicker imagePicker = ImagePicker();
    XFile? xFile = await imagePicker.pickImage(source: ImageSource.gallery, imageQuality: 20);
    final mimeType = getImageExt(xFile);
    // if(mimeType)
    // getImageSize(xFile);
    var f = await xFile?.readAsBytes();
    if(f != null){
      webImage = f;
    }
    double? size = await _getImageSize(xFile);
    return (webImage, size, mimeType);
  }

  static String getImageExt(XFile? xFile) {
    String s = xFile?.mimeType ?? '';
    if (s.isNotEmpty) {
      int idx = s.indexOf("/");
      debugPrint('getImageExt: ${s.substring(idx + 1).trim()}');
     return s.substring(idx + 1).trim();
    }
    return '';
  }

  /// convert bytes to file
  static File convertBytesToFile(Uint8List? webImage) {
    return File.fromRawPath(webImage!);
  }

  /// convert bytes to base64
  static String convertBytesToBase64(Uint8List? webImage) {
    return base64.encode(webImage!);
  }

  /// convert base64 to bytes
  static Uint8List convertBase64ToBytes(String base64string) {
    return base64.decode(base64string);
  }


  static Future<double?> _getImageSize(XFile? xFile) async {
    double? imageSize;
    if (xFile != null) {
      final bytes = (await xFile.readAsBytes()).lengthInBytes;
      if (bytes <= 0) {
        imageSize = 0.0;
      }
      const suffixes = ["B", "KB", "MB", "GB", "TB", "PB", "EB", "ZB", "YB"];
      var i = (log(bytes) / log(1024)).floor();
      if (suffixes[i] == "B" || suffixes[i] == "KB" || suffixes[i] == "MB") {
        imageSize = bytes / pow(1024, i);
        debugPrint("Image: $imageSize ${suffixes[i]}");
        // CustomLogger.printLog("Image: $imageSize ${suffixes[i]}");
      }
      return imageSize ?? 0.0;
    }
    return imageSize;
  }

  static _imageMaxSizeRestriction(XFile? xFile, Uint8List webImage) async {
    double? imageSize = await _getImageSize(xFile);
    debugPrint('imageSize: $imageSize');
    if (imageSize! > 2) {}
  }

  static getImageSize(XFile? xFile) async {
    if (xFile != null) {
      final bytes = (await xFile.readAsBytes()).lengthInBytes;
      if (bytes <= 0) return "0 B";
      const suffixes = ["B", "KB", "MB", "GB", "TB", "PB", "EB", "ZB", "YB"];
      var i = (log(bytes) / log(1024)).floor();
      if (suffixes[i] == "MB" && (bytes / pow(1024, i)) > 2) {
        // isImageSizeAllow = false;
        // CustomLogger.printLog("isImageSizeAllow: FALSE");
      } else {
        // isImageSizeAllow = true;
        // CustomLogger.printLog("isImageSizeAllow: TRUE");
      }
    }
  }
}

extension ResponseStatusExtension on MimeType{
  static const mimeType = {
    MimeType.png: 'png',
    MimeType.jpeg: 'jpg/jpeg',
  };

  String? get getMimeType => mimeType[this];



}