import 'dart:io';

import 'package:class_manager_two/app/home_page/atoms/home_page_atoms.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class MyMobile {
  Future<String?> selectImage() async {
    File? image;
    String? filePath;
    final ImagePicker picker = ImagePicker();
    try {
      XFile? xfile = await picker.pickImage(source: ImageSource.gallery);
      if (xfile != null) {
        image = File(xfile.path);

        final appDocumentsDir = await getApplicationDocumentsDirectory();
        filePath = '${appDocumentsDir.path}/${xfile.name}';

        await image.copy(filePath);
      }
    } catch (e) {
      filePath = null;
    }
    imagePathAtom.setValue(filePath);

    return filePath;

    // XFile? image;
    // final ImagePicker picker = ImagePicker();
    // try {
    //   XFile? file = await picker.pickImage(source: ImageSource.gallery);
    //   print('selectImage');
    //   if (file != null) image = file;
    //   print(image!.name);
    //   print('selectImage2');
    // } catch (e) {
    //   image = null;
    // }
    // return image!.path;

    // File? image;
    // final ImagePicker picker = ImagePicker();
    // try {
    //   XFile? xfile = await picker.pickImage(source: ImageSource.gallery);
    //   if (xfile != null) {
    //     image = File(xfile.path);
    //     print('----------------------------------${image.path}');
    //     print('MyMobile');
    //   }
    // } catch (e) {
    //   print('MyMobile catch');
    //   image = null;
    // }

    // return image?.path;

    //  File? image;
    // final ImagePicker picker = ImagePicker();
    // try {
    //   XFile? xfile = await picker.pickImage(source: ImageSource.gallery);
    //   if (xfile != null) image = File(xfile.path);

    // } catch (e) {
    //   image = null;
    // }
    // return image.path;
  }
}


// XFile? image;
    // final ImagePicker picker = ImagePicker();
    // try {
    //   XFile? file = await picker.pickImage(source: ImageSource.gallery);
    //   if (file != null) image = file;
    // } catch (e) {
    //   image = null;
    // }
    // return image!.path;