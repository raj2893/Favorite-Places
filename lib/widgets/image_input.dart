import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ImageInput extends StatefulWidget {
  const ImageInput({super.key, required this.onPickImage});
  final void Function(File image) onPickImage;

  @override
  State<ImageInput> createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File? _selectedImage;
  void _takePicture() async {
    final imagePicker = ImagePicker();
    final pickImage =
        await imagePicker.pickImage(source: ImageSource.camera, maxWidth: 600);
    if (pickImage == null) return;
    setState(() {
      _selectedImage = File(pickImage.path);
    });

    widget.onPickImage(_selectedImage!);
  }

  void _galleryPicture() async {
    final imagePicker = ImagePicker();
    final pickImage =
        await imagePicker.pickImage(source: ImageSource.gallery, maxWidth: 600);
    if (pickImage == null) return;
    setState(() {
      _selectedImage = File(pickImage.path);
    });

    widget.onPickImage(_selectedImage!);
  }

  @override
  Widget build(BuildContext context) {
    Widget content = Row(
      children: [
        TextButton.icon(
          icon: Icon(Icons.collections),
          label: Text('Choose from gallery'),
          onPressed: _galleryPicture,
        ),
        TextButton.icon(
          icon: Icon(Icons.camera),
          label: Text('Take Picture'),
          onPressed: _takePicture,
        ),
      ],
    );
    if (_selectedImage != null) {
      content = GestureDetector(
        onTap: _takePicture,
        child: Image.file(
          _selectedImage!,
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
        ),
      );
    }
    return Container(
        height: 250,
        width: double.infinity,
        decoration: BoxDecoration(
          border: Border.all(
            width: 1,
            color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
          ),
        ),
        alignment: Alignment.center,
        child: content);
  }
}
