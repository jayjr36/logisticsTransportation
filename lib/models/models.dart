

// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class Models{
  final uid = FirebaseAuth.instance.currentUser!.uid;
  

  Future<void> uploadDocument(
    BuildContext context, String documentId) async {
  final documentReference = FirebaseFirestore.instance
      .collection('orders')
      .doc(uid)
      .collection('myorders')
      .doc(documentId);

  final result = await FilePicker.platform.pickFiles(
    type: FileType.custom,
    allowedExtensions: ['pdf'],
    allowMultiple: false,
  );

  if (result != null && result.files.isNotEmpty) {
    final selectedFile = result.files.first;
    final fileName = selectedFile.name;
    final filePath = selectedFile.path;

    try {
      // Read the file as bytes using dart:io.
      final fileBytes = File(filePath!).readAsBytesSync();

      final storageReference = FirebaseStorage.instance.ref().child(fileName);
      final uploadTask = storageReference.putData(fileBytes);
      await uploadTask.whenComplete(() {});

      final downloadURL = await storageReference.getDownloadURL();

      await documentReference.update({
        'passDoc': downloadURL,
      });

      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Document uploaded successfully!'),
        backgroundColor: Colors.green,
      ));
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Error: $error'),
        backgroundColor: Colors.red,
      ));
    }
  } else {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('No file selected.'),
      backgroundColor: Colors.red,
    ));
  }


   }
}