import 'dart:io';
import 'package:universal_html/html.dart' as html;

import 'package:common/features/profile/presentation/common_imports.dart';
import 'package:dio/dio.dart';
import 'package:fl_downloader/fl_downloader.dart';
import 'package:flutter/foundation.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart';

part 'file_view_provider.g.dart';

@riverpod
Future<void> downloadFile(Ref ref, String url) async {
  try {
    if (kIsWeb) {
      String fileName = url.split("?").first;
      await downloadWebFile(url: url, fileName: fileName);
      return;
    }
    // Download the file
    String fileName = url.split(Platform.pathSeparator).last.split("?").first;
    await FlDownloader.initialize();
    final permission = await FlDownloader.requestPermission();
    if (permission == StoragePermissionStatus.granted) {
      await FlDownloader.download(url, fileName: fileName);
      await Future.delayed(
          const Duration(seconds: 2)); // keep time to wait download
    }
    print("File downloaded and saved");
  } catch (e) {
    launchUrl(Uri.parse(url));
    print("Error downloading file: $e");
  }
}

@riverpod
Future<void> downloadViewFile(Ref ref, String url) async {
  try {
    if (kIsWeb) {
      launchUrl(Uri.parse(url));
      return;
    }
    final permission = await FlDownloader.requestPermission();
    if (permission == StoragePermissionStatus.granted) {
      String fileName = url.split(Platform.pathSeparator).last.split("?").first;
      final appDocDir = defaultTargetPlatform == TargetPlatform.iOS
          ? await getApplicationDocumentsDirectory()
          : Directory(AppConstants.defaultDownloadDirectory);
      String filePath = "${appDocDir.path}/$fileName";
      final file = File(filePath);
      if (await file.exists()) {
        await launchOpenFile(filePath, url);
      } else {
        // Download the file
        await FlDownloader.initialize();
        await FlDownloader.download(url, fileName: fileName);
        await Future.delayed(
            const Duration(seconds: 4)); // keep time to wait download
        await launchOpenFile(filePath, url);
      }
    }
    print("File downloaded and saved");
  } catch (e) {
    print("Error downloading file: $e");
  }
}

Future<void> launchOpenFile(String filePath, String url) async {
  try {
    await OpenFilex.open(filePath);
  } catch (_) {
    launchUrl(Uri.parse(url));
  }
}

Future<void> downloadWebFile(
    {required String url, required String fileName}) async {
  try {
    Dio dio = Dio();

    // Make the HTTP request to download the file
    Response<List<int>> response = await dio.get<List<int>>(
      url,
      options:
          Options(responseType: ResponseType.bytes), // Get the file as bytes
    );

    // Convert the response to a Blob
    final blob = html.Blob([response.data], 'application/octet-stream');

    // Create a link and trigger the download
    final anchor =
        html.AnchorElement(href: html.Url.createObjectUrlFromBlob(blob))
          ..setAttribute("download", fileName)
          ..click();

    // Clean up the object URL
    html.Url.revokeObjectUrl(anchor.href!);
  } catch (e) {
    print("Error downloading file: $e");
  }
}
