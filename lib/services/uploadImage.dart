
import 'dart:io';

import 'package:image_picker/image_picker.dart';

class UploadImage {
  static Future upImage (File image) async{
    final returnImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (returnImage==null) return;
    image = File(returnImage.path);
  }
}