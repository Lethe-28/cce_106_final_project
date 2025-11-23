import 'package:flutter/material.dart';

class GalleryPhotoGrid extends StatelessWidget {
  final bool isSelectionMode;
  final Set<int> selectedIndices;
  final Function(int) onItemSelected;

  const GalleryPhotoGrid({
    super.key,
    required this.isSelectionMode,
    required this.selectedIndices,
    required this.onItemSelected,
  });

  @override
  Widget build(BuildContext context) {
    // TODO: Replace with real data later
    final int dummyItemCount = 24;

    return GridView.builder(
      // Use physics: BouncingScrollPhysics() for iOS feel if desired
      padding: const EdgeInsets.only(bottom: 100), // Space for bottom nav/fab
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3, // Standard 3-column photo grid
        crossAxisSpacing: 2, // Tight spacing like standard gallery apps
        mainAxisSpacing: 2,
        childAspectRatio: 1,
      ),
      itemCount: dummyItemCount,
      itemBuilder: (context, index) {
        final isSelected = selectedIndices.contains(index);

        return GestureDetector(
          onLongPress: () {
            // Enter selection mode on long press
            onItemSelected(index);
          },
          onTap: () {
            if (isSelectionMode) {
              // If in selection mode, tap simply toggles selection
              onItemSelected(index);
            } else {
              // Normal tap behavior (Open Fullscreen Image)
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Open Photo $index"), duration: const Duration(milliseconds: 500)),
              );
            }
          },
          child: Stack(
            fit: StackFit.expand,
            children: [
              // 1. The Image
              Container(
                color: Colors.grey[300], // Placeholder color
                child: Image.network(
                  'https://picsum.photos/200?random=$index', // Random placeholder images
                  fit: BoxFit.cover,
                  errorBuilder: (c, e, s) => const Icon(Icons.image_not_supported),
                ),
              ),

              // 2. The Selection Overlay
              if (isSelectionMode)
                Container(
                  decoration: BoxDecoration(
                    color: isSelected ? Colors.black.withOpacity(0.4) : Colors.transparent,
                  ),
                  child: Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        isSelected ? Icons.check_circle : Icons.circle_outlined,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}