import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../const/app_color.dart';
import 'package:image_picker/image_picker.dart';

import '../../../widgets/widgets.dart';

class TestScreen extends StatefulWidget {
  String sub;
  String dept;
  String sem;

  TestScreen({super.key, required this.sub, required this.dept, required this.sem});

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  File? _image;
  Future getImage(ImageSource source) async {
    final image = await ImagePicker().pickImage(source: source);
    if (image == null) return;
    final imageTemporary = File(image.path);
    setState(() {
    this._image = imageTemporary;
    });
  }

  final TextEditingController _assign = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.purplee,
        title: const Text('Daily Test'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                alignment: Alignment.center,
                height: 95.h,
                decoration: BoxDecoration(
                  color: AppColor.purplee,
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.sub,
                      style: TextStyle(
                        letterSpacing: 0.5,
                        fontSize: 20.sp,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      widget.dept,
                      style: TextStyle(
                        fontSize: 17.sp,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Container(
                  height: 150.h,
                  width: 180.h,
                  color: Colors.grey,
                  alignment: Alignment.center,
                  child: _image != null
                      ? Image.file(
                          _image!,
                          fit: BoxFit.cover,
                        )
                      : Image.asset('assets/icons/as2.png')),
              SizedBox(
                height: 10.h,
              ),
              subBtmn('Upload the Task', () {
                //TODO: SDKFHASHFILASDH

                showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return Container(
                      // show model bottom sheet
                      height: 300.h,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                      ),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Upload',
                              style: TextStyle(
                                  fontSize: 25.sp,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black),
                            ),
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  menuBtn(
                                      'From Galley', 'assets/icons/time.png',
                                      () {
                                    getImage(ImageSource.gallery);
                                    if (_image != null) {
                                      print('A image uploaded');
                                  
                                    }
                                  }),
                                  menuBtn(
                                      'From Camera', 'assets/icons/lecture.png',
                                      () {
                                    getImage(ImageSource.camera);
                                    if (_image != null)
                                      print('A image is uploaded');
                               
                                  }),
                                ]),
                          ]),
                    );
                  },
                );
              }), // upload image source
              SizedBox(
                height: 40.h,
              ),
              Text(
                'Task Details:',
                style: TextStyle(
                  fontSize: 24.sp,
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Container(
                padding: EdgeInsets.all(10.r),
                height: 250.h,
                width: 300.w,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: TextFormField(
                  controller: _assign,
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  textCapitalization: TextCapitalization.sentences,
                  decoration: const InputDecoration.collapsed(
                      hintText: 'Please write down here..'),
                  style: TextStyle(fontSize: 20.sp),
                ),
              ),
              SizedBox(
                height: 15.h,
              ),

              subBtmn('Submit', () {
                var snackBar = const SnackBar(content: Text('Task Uploaded.'));
                ScaffoldMessenger.of(context).showSnackBar(snackBar);

                Timer(const Duration(seconds: 3), () {
                  Navigator.pop(context);
                });
              }),
            ],
          ),
        ),
      ),
    ));
  }
}

subBtmn(txt, ontap) {
  return InkWell(
    onTap: ontap,
    child: Container(
      height: 45.h,
      alignment: Alignment.center,
      width: 220.w,
      decoration: BoxDecoration(
        color: AppColor.purplee,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Text(
        txt,
        style: TextStyle(
          color: Colors.white,
          fontSize: 20.sp,
          // fontWeight: FontWeight.bold,
        ),
      ),
    ),
  );
}
