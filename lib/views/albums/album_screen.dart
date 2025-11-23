import 'package:flutter/material.dart';
import '../components/album_card.dart';
import '../gallery/photo_grid_screen.dart';

class AlbumsScreen extends StatelessWidget {
  const AlbumsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Dummy Data for demonstration
    final List<Map<String, dynamic>> dummyAlbums = List.generate(
      12,
      (index) => {
        "name": "Vacation $index",
        "owner": index % 2 == 0 ? "You" : "John Doe",
        "date": "Nov ${index + 1}, 2025",
        "count": (index + 1) * 5,
      },
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text("Albums"),
        centerTitle: false, // Keep standard left alignment or change to true
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: GridView.builder(
          // Padding at bottom to avoid nav bar obstruction
          padding: const EdgeInsets.only(top: 16, bottom: 120),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            // MATCHING YOUR STYLE_GRID CONFIGURATION
            crossAxisCount: 3,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
            childAspectRatio: 0.8, // Slightly taller to fit the text
          ),
          itemCount: dummyAlbums.length,
          itemBuilder: (context, index) {
            final album = dummyAlbums[index];

            return AlbumCard(
              index: index,
              albumName: album["name"],
              owner: album["owner"],
              dateCreated: album["date"],
              itemCount: album["count"],
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PhotoGridScreen(
                      albumTitle: album["name"],
                      showCreateAlbum:
                          false, // <--- DISABLES 'Create Album', ENABLES 'Print'
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
