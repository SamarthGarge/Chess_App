import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_chess/helper/helper_methods.dart';
import 'package:flutter_chess/service/assets_manager.dart';
import 'package:flutter_chess/widgets/main_auth_button.dart';
import 'package:flutter_chess/widgets/widgets.dart';
import 'package:image_cropper/image_cropper.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  File? finalFileImage;
  String fileImageUrl = '';
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void selectImage({required bool fromCamera}) async {
    finalFileImage = await pickImage(
        context: context,
        fromCamera: fromCamera,
        onFail: (e) {
          // show error message
          showSnackBar(context: context, content: e.toString());
        });

    if (finalFileImage != null) {
      cropImage(finalFileImage!.path);
    } else {
      popCropDialog();
    }
  }

  void cropImage(String path) async {
    CroppedFile? croppedFile = await ImageCropper()
        .cropImage(sourcePath: path, maxHeight: 800, maxWidth: 800);

    popCropDialog();

    if (croppedFile != null) {
      setState(() {
        finalFileImage = File(croppedFile.path);
      });
    } else {
      popCropDialog();
    }
  }

  void popCropDialog() {
    Navigator.pop(context);
  }

  void showImagePickerDialog() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Select an option'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  leading: const Icon(Icons.camera_alt),
                  title: const Text("Camera"),
                  onTap: () {
                    // choose image from camera
                    selectImage(fromCamera: true);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.image),
                  title: const Text("Gallery"),
                  onTap: () {
                    // choose image from gallery
                    selectImage(fromCamera: false);
                  },
                ),
              ],
            ),
          );
        });
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20.0,
            vertical: 15,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Sign Up',
                style: TextStyle(fontSize: 34, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 20,
              ),
              finalFileImage != null
                  ? Stack(
                      children: [
                        CircleAvatar(
                          radius: 60,
                          backgroundColor: Colors.blue,
                          backgroundImage:
                              FileImage(File(finalFileImage!.path)),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.lightBlue,
                                border:
                                    Border.all(width: 2, color: Colors.white),
                                borderRadius: BorderRadius.circular(35)),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: IconButton(
                                icon: const Icon(
                                  Icons.camera_alt,
                                  color: Colors.white,
                                ),
                                onPressed: () {
                                  // pick image from camera or gallery
                                  showImagePickerDialog();
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  : Stack(
                      children: [
                        CircleAvatar(
                          radius: 60,
                          backgroundColor: Colors.blue,
                          backgroundImage: AssetImage(AssetsManager.userIcon),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.lightBlue,
                                border:
                                    Border.all(width: 2, color: Colors.white),
                                borderRadius: BorderRadius.circular(35)),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: IconButton(
                                icon: const Icon(
                                  Icons.camera_alt,
                                  color: Colors.white,
                                ),
                                onPressed: () {
                                  // pick image from camera or gallery
                                  showImagePickerDialog();
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
              const SizedBox(
                height: 40,
              ),
              TextFormField(
                decoration: textFormDecoration.copyWith(
                  labelText: 'Enter your Name',
                  hintText: 'Enter your Name',
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                decoration: textFormDecoration.copyWith(
                  labelText: 'Enter your Email',
                  hintText: 'Enter your Email',
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                decoration: textFormDecoration.copyWith(
                  labelText: 'Enter your Password',
                  hintText: 'Enter your Password',
                ),
                obscureText: true,
              ),
              const SizedBox(
                height: 20,
              ),
              MainAuthButton(
                lable: 'SIGN UP',
                onPressed: () {
                  // login the user with Email and password
                },
                fontSize: 24.0,
              ),
              const SizedBox(
                height: 40,
              ),
              HaveAccountWidget(
                label: 'Have an account?',
                labelAction: 'Sign In',
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
