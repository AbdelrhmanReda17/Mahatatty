import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:io';
import '../components/edit_profile_field.dart'; // Import the custom field widget

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  EditProfileScreenState createState() => EditProfileScreenState();
}

class EditProfileScreenState extends State<EditProfileScreen> {
  File? _imageFile;
  final ImagePicker _picker = ImagePicker();

  final TextEditingController _usernameController =
      TextEditingController(text: 'Magdalena Sucrose');
  final TextEditingController _emailController =
      TextEditingController(text: 'magdalena83@mail.com');

  // Function to pick an image from the gallery
  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  Future<void> _linkGoogleAccount() async {
    const url = 'https://accounts.google.com/';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not open the link';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {
              // Additional options
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: _pickImage,
              child: CircleAvatar(
                radius: 50,
                backgroundImage: _imageFile != null
                    ? FileImage(_imageFile!)
                    : const AssetImage('assets/avatar.jpg') as ImageProvider,
                child: _imageFile == null
                    ? const Icon(Icons.camera_alt,
                        size: 50, color: Colors.white70)
                    : null,
              ),
            ),
            const SizedBox(height: 16),
            EditProfileField(
              icon: Icons.person_outline,
              label: 'Username',
              controller: _usernameController,
            ),
            const SizedBox(height: 16),
            EditProfileField(
              icon: Icons.email_outlined,
              label: 'Email or Phone Number',
              controller: _emailController,
            ),
            const SizedBox(height: 16),
            GestureDetector(
              onTap: _linkGoogleAccount,
              child: const EditProfileField(
                icon: Icons.link,
                label: 'Account Linked With',
                value: 'Google',
                isLink: true,
              ),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Save changes functionality
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal.shade700,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text(
                  'Save Changes',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white, // White text color
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
