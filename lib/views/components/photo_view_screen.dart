import 'package:flutter/material.dart';

class PhotoViewScreen extends StatelessWidget {
  final String imageUrl;
  final String title;

  const PhotoViewScreen({
    super.key,
    required this.imageUrl,
    this.title = "Photo",
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black.withOpacity(0.5),
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(title, style: const TextStyle(color: Colors.white)),
        actions: [
          IconButton(
            icon: const Icon(Icons.print),
            tooltip: "Print",
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Sending to printer...")),
              );
            },
          ),
        ],
      ),
      body: Center(
        child: Hero(
          tag: imageUrl, // Animation tag matches the grid
          child: Image.network(
            imageUrl,
            fit: BoxFit.contain,
            errorBuilder: (c, e, s) => const Icon(Icons.broken_image, color: Colors.white),
          ),
        ),
      ),
    );
  }
}