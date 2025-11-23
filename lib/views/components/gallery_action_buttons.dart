import 'package:flutter/material.dart';

class GalleryActionButtons extends StatelessWidget {
  final bool isSelectionMode;
  final VoidCallback onCreateAlbum;
  final VoidCallback onSelectAll;
  final VoidCallback onCancel;

  const GalleryActionButtons({
    super.key,
    required this.isSelectionMode,
    required this.onCreateAlbum,
    required this.onSelectAll,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    // Based on the wireframe, we want these accessible.
    // If NOT in selection mode, we might just show the "Create Album" or nothing.
    // For this implementation, let's toggle visibility based on mode for better UX.
    
    if (!isSelectionMode) {
      // When not selecting, maybe just a simple icon to start organizing?
      // Or return empty to keep it clean as per the drawing which implies they appear with context.
      return const SizedBox.shrink(); 
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Select All
        IconButton(
          icon: const Icon(Icons.select_all),
          tooltip: "Select All",
          onPressed: onSelectAll,
        ),
        // Create Album
        IconButton(
          icon: const Icon(Icons.create_new_folder_outlined),
          tooltip: "Create Album",
          onPressed: onCreateAlbum,
        ),
        // Cancel Text
        TextButton(
          onPressed: onCancel,
          child: const Text("Cancel"),
        ),
      ],
    );
  }
}