import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class AuthenticationController extends GetxController{
  static AuthenticationController authController = Get.find();
  late Rx<File?> pickedFile;
  File? get profileImage => pickedFile.value;
  XFile ? imageFile;

  pickImageFileFromGallery() async{
     imageFile = await ImagePicker().pickImage(source: ImageSource.gallery);

    if(imageFile != null){
      Get.snackbar("Profile Image", "Inserted Successfully");

    }
    pickedFile = Rx<File?>(File(imageFile!.path));

  }
  captureImageFromCamera() async{
    imageFile = await ImagePicker().pickImage(source: ImageSource.camera);

    if(imageFile != null){
      Get.snackbar("Profile Image", "Inserted Successfully");

    }
    pickedFile = Rx<File?>(File(imageFile!.path));

  }

}