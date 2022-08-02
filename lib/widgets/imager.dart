import 'package:image_picker/image_picker.dart';

// for picking up image from gallery
pickImage(ImageSource source) async {
  final ImagePicker imagePicker = ImagePicker();
  XFile? image = await imagePicker.pickImage(source: source);
  if (image != null) {
    return image.readAsBytes();
  }
}
