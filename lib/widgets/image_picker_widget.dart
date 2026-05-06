import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/foundation.dart'; // 👈 IMPORTANTE

class ImagePickerWidget extends StatefulWidget {
  final String? initialImageUrl;
  final Function(File?) onImageSelected;

  const ImagePickerWidget({
    super.key,
    this.initialImageUrl,
    required this.onImageSelected,
  });

  @override
  State<ImagePickerWidget> createState() => _ImagePickerWidgetState();
}

class _ImagePickerWidgetState extends State<ImagePickerWidget> {
  File? selectedImage;
  Uint8List? webImage;
  final picker = ImagePicker();

  Future<void> pickImage() async {
    final picked = await picker.pickImage(source: ImageSource.gallery);

    if (picked != null) {
      if (kIsWeb) {
        /// 🌐 WEB
        final bytes = await picked.readAsBytes();
        setState(() {
          webImage = bytes;
        });
      } else {
        /// 📱 MOBILE
        setState(() {
          selectedImage = File(picked.path);
        });
        widget.onImageSelected(selectedImage);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 160,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(15),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: _buildImage(),
          ),
        ),
        const SizedBox(height: 10),
        ElevatedButton.icon(
          onPressed: pickImage,
          icon: const Icon(Icons.image),
          label: const Text("Seleccionar Imagen"),
        ),
      ],
    );
  }

  Widget _buildImage() {
    /// 🌐 WEB
    if (kIsWeb && webImage != null) {
      return Image.memory(webImage!, fit: BoxFit.cover);
    }

    /// 📱 MOBILE
    if (!kIsWeb && selectedImage != null) {
      return Image.file(selectedImage!, fit: BoxFit.cover);
    }

    /// 🌍 FIREBASE URL
    if (widget.initialImageUrl != null) {
      return Image.network(widget.initialImageUrl!, fit: BoxFit.cover);
    }

    return const Center(child: Text("Sin imagen"));
  }
}
