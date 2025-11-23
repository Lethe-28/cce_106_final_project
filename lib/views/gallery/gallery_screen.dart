import 'package:flutter/material.dart';
import '../components/gallery_header.dart';
import '../components/style_grid.dart';
import 'photo_grid_screen.dart'; // <--- Make sure this is imported

class GalleryScreen extends StatefulWidget {
  const GalleryScreen({super.key});

  @override
  State<GalleryScreen> createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryScreen> {

  void _onAlbumTapped(int index) {
    Navigator.push(
      context,
      MaterialPageRoute(
        // FIX: Use PhotoGridScreen here, NOT GalleryPhotoGrid
        builder: (context) => PhotoGridScreen(
          albumTitle: index == 0 ? "All Photos" : "Album $index",
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: SingleChildScrollView(
            // Padding to prevent content from hiding behind the floating nav bar
            padding: const EdgeInsets.only(bottom: 120),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 16),
                const GalleryHeader(),
                const SizedBox(height: 24),
                
                // The Grid
                StyleGrid(
                  onStyleTapped: _onAlbumTapped,
                ),
                
                // Removed AddNewStyleCard() as planned
              ],
            ),
          ),
        ),
      ),
    );
  }
}