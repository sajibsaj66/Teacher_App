import 'dart:io';


import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_storage/firebase_storage.dart';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:teacher_management/ui/view/demo/data.dart';


class DemoScreen extends StatefulWidget {
  DemoScreen({super.key});

  @override
  State<DemoScreen> createState() => _DemoScreenState();
}

class _DemoScreenState extends State<DemoScreen> {
  final TextEditingController _title = TextEditingController();

  final TextEditingController _description = TextEditingController();
  XFile? _assignImage;
  String? imageUrl;

  chooseimagefromGallery() async {
    final ImagePicker _picker = ImagePicker();
    _assignImage = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {});
  }

  writeData() async {
    File imgFile = File(_assignImage!.path);
    FirebaseStorage _storage = FirebaseStorage.instance;
    UploadTask _uploadTask =
        _storage.ref('images').child(_assignImage!.name).putFile(imgFile);

    TaskSnapshot snapshot = await _uploadTask;
    imageUrl = await snapshot.ref.getDownloadURL();

    CollectionReference _data =
        FirebaseFirestore.instance.collection("students");
    print(imageUrl);
    print('Hello bro');

    _data.add({
      'name': _title.text,
      'description': _description.text,
      'image': imageUrl
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            ElevatedButton(
                onPressed: () {
                  chooseimagefromGallery();
                },
                child: const Icon(Icons.add)),
            TextField(
              controller: _title,
            ),
            TextField(
              controller: _description,
            ),
            ElevatedButton(
                onPressed: () {
                  writeData();
                },
                child: const Text('Submit')),
            _assignImage != null
                ? Image.file(File(_assignImage!.path))
                : const Text('No image selected'),
            ElevatedButton(
                onPressed: () {
                  Get.to(Data());
                },
                child: const Text('data')),
          ],
        ),
      ),
    );
  }
}
