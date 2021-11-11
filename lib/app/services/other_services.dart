import 'dart:io';

import 'package:file_picker/file_picker.dart';

class OtherServices {
  static Future<Map<String, dynamic>?> pickFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'pdf', 'png', 'jpeg'],
      withData: true,
      withReadStream: true,
    );

    if (result != null) {
      final fileName = result.files[0].name;
      final file = File(result.files[0].path!);
      return {
        'fileName': fileName,
        'file': file,
      };
    }
    return null;
  }
}
