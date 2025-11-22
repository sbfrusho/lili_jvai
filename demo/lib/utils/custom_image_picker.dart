
	 import 'dart:io';
import 'package:image_picker/image_picker.dart';


Future<File?> customImagePicker({isCircular = true, isSquared = true}) async {
  final picker = ImagePicker();

  final XFile? pickedImage = await picker.pickImage(
    source: ImageSource.gallery,
  );

  if (pickedImage == null) return null;

  return File(pickedImage.path);
}
	  