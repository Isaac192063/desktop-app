import 'dart:io';
import 'dart:typed_data';

import 'package:desktop_app/config/environment.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart' as path;
import 'package:filepicker_windows/filepicker_windows.dart' as fpw;

class ExceluserService {
  final String _api = "/user/excel/downloadExcel";
  BuildContext? context;

  Future<void> dowloadUsers() async {
    try {
      final url = "${Environment.API_RDQ}$_api";

      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final Uint8List bytes = response.bodyBytes;
        final String dir = (await path.getApplicationDocumentsDirectory()).path;

        final file = fpw.DirectoryPicker()..title = 'Select a directory';

        final result = file.getDirectory();

        final String fullPath = '$dir/users.xlsx';
        if (result != null) {
          String patch = "${result.path}/users.xlsx";
          File file = File(patch);
          await file.writeAsBytes(bytes);

          print('File saved at $fullPath');
          ScaffoldMessenger.of(context!).showSnackBar(SnackBar(
            content: Text('File saved at $fullPath'),
          ));
        }
      } else {
        print('Failed to download file: ${response.statusCode}');
        ScaffoldMessenger.of(context!).showSnackBar(const SnackBar(
          content: Text('Failed to download file'),
        ));
      }
    } catch (e) {
      print(e);
    }
  }
}
