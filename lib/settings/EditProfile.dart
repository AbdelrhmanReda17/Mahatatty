import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:url_launcher/url_launcher.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  File? _imageFile;
  final ImagePicker _picker = ImagePicker();

  TextEditingController _usernameController = TextEditingController(text: 'Magdalena Succrose');
  TextEditingController _emailController = TextEditingController(text: 'magdalena83@mail.com');

  // Function to pick an image from the gallery
  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  // Function to open Google accounts for linking
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
                    : AssetImage('assets/avatar.jpg') as ImageProvider, // Replace with your image asset
                child: _imageFile == null
                    ? Icon(Icons.camera_alt, size: 50, color: Colors.white70)
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
                  backgroundColor: Colors.teal.shade700, // Darker teal color
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

class EditProfileField extends StatelessWidget {
  final IconData icon;
  final String label;
  final TextEditingController? controller;
  final String? value;
  final bool isLink;

  const EditProfileField({
    Key? key,
    required this.icon,
    required this.label,
    this.controller,
    this.value,
    this.isLink = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 14, color: Colors.black54),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey[300]!),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              Icon(icon, color: Colors.black54),
              const SizedBox(width: 16),
              Expanded(
                child: isLink
                    ? Text(
                  value ?? '',
                  style: const TextStyle(fontSize: 16),
                )
                    : TextFormField(
                  controller: controller,
                  style: const TextStyle(fontSize: 16),
                  decoration: const InputDecoration.collapsed(
                    hintText: '',
                  ),
                ),
              ),
              if (isLink)
                const Icon(
                  Icons.arrow_forward_ios,
                  size: 16,
                  color: Colors.grey,
                ),
            ],
          ),
        ),
      ],
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: EditProfileScreen(),
  ));
}
