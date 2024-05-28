import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddFriendView extends StatefulWidget {
  @override
  _AddFriendViewState createState() => _AddFriendViewState();
}

class _AddFriendViewState extends State<AddFriendView> {
  String _name = '';
  int _age = 0;
  final _picker = ImagePicker();
  File? _image;


  Future<void> _pickImage() async {
    final XFile? pickedImage = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('New Friend')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              decoration: InputDecoration(labelText: 'Name'),
              onChanged: (value) {
                setState(() {
                  _name = value;
                });
              },
            ),
            SizedBox(height: 16.0),
            TextField(
              decoration: InputDecoration(labelText: 'Age'),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  _age = int.tryParse(value) ?? 0;
                });
              },
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                // Handle photo upload (e.g., show image picker)
                // Set __image with the selected image URL
                _pickImage();
              },
              child: Text('Upload Photo'),
            ),
            SizedBox(height: 16.0),
            if (_image != null) Image.file(_image!),
            Text('Photo URL: $_image'), // Display the selected photo URL
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Save the friend details (name, age, photo URL) to your data source
          // You can use a database or other storage mechanism
          // For now, just print the details as an example:
          print('Name: $_name, Age: $_age, Photo URL: $_image');
        },
        child: Icon(Icons.save),
      ),
    );
  }
}
