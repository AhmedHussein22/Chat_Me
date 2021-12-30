import 'dart:io';
import 'package:chat_me/ui/widgets/click_botton.dart';
import 'package:chat_me/ui/widgets/text_fleid.dart';
import 'package:chat_me/utils/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';

class CompletUserInfo extends StatefulWidget {
  final String phonenumber;
  const CompletUserInfo({this.phonenumber});
  @override
  _CompletUserInfoState createState() => _CompletUserInfoState();
}

class _CompletUserInfoState extends State<CompletUserInfo> {
  String _fristname = "";
  String _lastname = "";
  String _urlImg = "";
  bool _isLoading = false;
  File _image;
  final picker = ImagePicker();
  final _formKey = GlobalKey<FormState>();
//******************** pick image ************************ */
  Future<void> getImage(int type) async {
    final pickedFile = await picker.getImage(
        source: type == 0 ? ImageSource.gallery : ImageSource.camera,
        preferredCameraDevice: CameraDevice.front);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

//******************** uploadImage to FirebaseStorage ************************ */
//

  Future<void> uploadImage() async {
    try {
      final Reference storageRef =
          FirebaseStorage.instance.ref().child('users images');
      final Reference ref = storageRef.child(_image.path);
      UploadTask storageUploadTask = ref.putFile(_image);
      TaskSnapshot taskSnapshot;
      String url = await taskSnapshot.ref.getDownloadURL();
      print('url================ $url');
      setState(
        () {
          _urlImg = url;
        },
      );
    } catch (ex) {
      print("error===========${ex.toString()}");
    }
  }

//******************** show Cupertino Action Sheet ************************ */
  action(ThemeData theme) {
    return CupertinoActionSheet(
      title: Text(
        "Choose to Add Photo",
        style: theme.textTheme.headline1,
      ),
      actions: <Widget>[
        CupertinoActionSheetAction(
          child: Text(
            "Gallery",
            style: theme.textTheme.headline2.copyWith(color: Colors.blue),
          ),
          isDefaultAction: true,
          onPressed: () async {
            print("Gallery is been clicked");
            await getImage(0);
            Get.back();
          },
        ),
        CupertinoActionSheetAction(
          child: Text(
            "Camera",
            style: theme.textTheme.headline2.copyWith(color: Colors.red),
          ),
          isDestructiveAction: true,
          onPressed: () async {
            print("Camera is been clicked");
            await getImage(1);
            Get.back();
          },
        )
      ],
      cancelButton: CupertinoActionSheetAction(
        child: Text(
          "Cancel",
          style: theme.textTheme.headline2,
        ),
        onPressed: () {
          Get.back();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 100),
                DottedBorder(
                  color: GRAY_COLOR,
                  borderType: BorderType.RRect,
                  radius: Radius.circular(8),
                  strokeWidth: 2,
                  dashPattern: [10, 4],
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    child: Container(
                      width: 130,
                      height: 140,
                      child: _image == null
                          ? Icon(CupertinoIcons.person_alt_circle,
                              color: Colors.grey[300], size: 90)
                          : Image.file(
                              _image,
                              height: 140,
                              width: 130,
                              fit: BoxFit.cover,
                            ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                InkWell(
                  onTap: () {
                    showCupertinoModalPopup(
                      context: context,
                      builder: (context) => action(theme),
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.add_a_photo_outlined,
                        color: DARK_BLUE_COLOR,
                        size: 30,
                      ),
                      SizedBox(width: 10),
                      Text(
                        "Add Photo",
                        style: theme.textTheme.headline1,
                      )
                    ],
                  ),
                ),
                SizedBox(height: 60),
                TextInputField(
                  hintText: "Frist Name*",
                  validatorFun: (value) => value.toString().isEmpty
                      ? "Please Enter Frist Name"
                      : null,
                  onChanged: (value) {
                    setState(() {
                      _fristname = value;
                    });
                  },
                ),
                SizedBox(height: 30),
                TextInputField(
                  hintText: "Last Name(optional)",
                  onChanged: (value) {
                    setState(() {
                      _lastname = value;
                    });
                  },
                ),
                SizedBox(height: 30),
                _isLoading
                    ? Container(
                        child: CupertinoActivityIndicator(                         
                          radius: 50,
                        ),
                      )
                    : Container()
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ClickButton(
          text: "Done",
          onPressed: () async {
            FocusScope.of(context).unfocus();
            if (_formKey.currentState.validate()) {
              _formKey.currentState.save();
              String uid = FirebaseAuth.instance.currentUser.uid;

              try {
                setState(() {
                  _isLoading = true;
                });
                print("userid============$uid");

                await uploadImage();
                print("userimg============$_urlImg");
                await FirebaseFirestore.instance
                    .collection("Users")
                    .doc(widget.phonenumber)
                    .set({
                  "phoneNumber": widget.phonenumber,
                  "uid": uid,
                  "firstname": _fristname,
                  "lasttname": _lastname ?? "",
                  "imgurl": _urlImg ?? "",
                });
                setState(() {
                  _isLoading = false;
                });
                
                var box = await Hive.openBox("userInfo");
                box.put('phoneNumber', widget.phonenumber);

                //   Get.offAllNamed("/HomPage");
              } catch (e) {
                print("Error ====================== ${e.message}");
                setState(() {
                  _isLoading = false;
                });
                FocusScope.of(context).unfocus();
                Get.snackbar(" Login Failed", "${e.message}",
                    colorText: BLACK_COLOR, snackPosition: SnackPosition.TOP);
              }
            }
          },
        ),
      ),
    );
  }
}
