import 'package:cce_106_final_project/views/components/photo_view_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
// import '../components/photo_view_screen.dart'; // Import the new viewer

class PhotoGridScreen extends StatefulWidget {
  final String albumTitle;
  // NEW: Flag to determine button behavior
  final bool showCreateAlbum; 

  const PhotoGridScreen({
    super.key,
    this.albumTitle = "Photos",
    // Default to true so GalleryScreen works without changes
    this.showCreateAlbum = true, 
  });

  @override
  State<PhotoGridScreen> createState() => _PhotoGridScreenState();
}

class _PhotoGridScreenState extends State<PhotoGridScreen> {
  bool _isSelectionMode = false;
  final Set<int> _selectedIndices = {};
  final int _totalItems = 24; 

  void _toggleItemSelection(int index) {
    setState(() {
      if (_selectedIndices.contains(index)) {
        _selectedIndices.remove(index);
        if (_selectedIndices.isEmpty) _isSelectionMode = false;
      } else {
        _selectedIndices.add(index);
        _isSelectionMode = true;
      }
    });
  }

  void _selectAll() {
    setState(() {
      for (int i = 0; i < _totalItems; i++) {
        _selectedIndices.add(i);
      }
    });
  }

  // Action 1: Create Album (For Main Gallery)
  void _createAlbum() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Created Album with ${_selectedIndices.length} items")),
    );
    _cancelSelection();
  }

  // Action 2: Print Photos (For Specific Albums)
  void _printSelectedPhotos() {
    // Logic to print specifically selected photos
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Print Photos"),
        content: Text("Send ${_selectedIndices.length} photos to printer?"),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text("Cancel")),
          FilledButton.icon(
            icon: const Icon(Icons.print),
            label: const Text("Print"),
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Printing started...")),
              );
              _cancelSelection();
            },
          ),
        ],
      ),
    );
  }

  void _cancelSelection() {
    setState(() {
      _selectedIndices.clear();
      _isSelectionMode = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isSelectionMode ? "${_selectedIndices.length} Selected" : widget.albumTitle),
        actions: _isSelectionMode
            ? [
                IconButton(
                  icon: const Icon(Icons.select_all),
                  tooltip: "Select All",
                  onPressed: _selectAll,
                ),
                
                // CONDITIONAL RENDERING
                if (widget.showCreateAlbum)
                  IconButton(
                    icon: const Icon(Icons.create_new_folder_outlined),
                    tooltip: "Create Album",
                    onPressed: _createAlbum,
                  )
                else
                  IconButton(
                    icon: const Icon(Icons.print),
                    tooltip: "Print Selected",
                    onPressed: _printSelectedPhotos,
                  ),

                TextButton(
                  onPressed: _cancelSelection,
                  child: const Text("Done"),
                ),
              ]
            : null,
      ),
      body: MasonryGridView.count(
        crossAxisCount: 2,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        padding: const EdgeInsets.all(8),
        itemCount: _totalItems,
        itemBuilder: (context, index) {
          final isSelected = _selectedIndices.contains(index);
          final double aspectRatio = _getDummyAspectRatio(index);
          final String imageUrl = _getDummyImageUrl(index, aspectRatio);

          return GestureDetector(
            // 1. Long Press to Select
            onLongPress: () => _toggleItemSelection(index),
            
            // 2. Tap Behavior
            onTap: () {
              if (_isSelectionMode) {
                // If selecting, tap just toggles
                _toggleItemSelection(index);
              } else {
                // If NOT selecting, open the viewer
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PhotoViewScreen(
                      imageUrl: imageUrl,
                      title: "Photo ${index + 1}",
                    ),
                  ),
                );
              }
            },
            child: Stack(
              children: [
                Hero(
                  tag: imageUrl,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: AspectRatio(
                      aspectRatio: aspectRatio,
                      child: Container(
                        color: Colors.grey[200],
                        child: Image.network(
                          imageUrl,
                          fit: BoxFit.cover,
                          errorBuilder: (c, e, s) => const Center(child: Icon(Icons.image)),
                        ),
                      ),
                    ),
                  ),
                ),
                if (_isSelectionMode)
                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        color: isSelected ? Colors.black.withOpacity(0.5) : Colors.transparent,
                        borderRadius: BorderRadius.circular(12),
                        border: isSelected ? Border.all(color: Colors.white, width: 2) : null,
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
                  ),
              ],
            ),
          );
        },
      ),
    );
  }

  // Helper functions remain the same
  double _getDummyAspectRatio(int index) {
    const options = [0.7, 1.0, 1.4];
    return options[index % options.length];
  }

  String _getDummyImageUrl(int index, double aspectRatio) {
    final width = 400;
    final height = (400 / aspectRatio).round();
    return 'https://picsum.photos/seed/$index/$width/$height';
  }
}