import 'package:flutter/material.dart';
import 'gallery/gallery_screen.dart';
import 'package:cce_106_final_project/views/selection/image_selection.dart';
import '../views/albums/album_screen.dart';

// --- Placeholder Screens (So buttons work) ---
class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});
  @override
  Widget build(BuildContext context) => const Scaffold(
    body: Center(
      child: Text(
        "Search Page",
        style: TextStyle(fontSize: 24, color: Colors.grey),
      ),
    ),
  );
}

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});
  @override
  Widget build(BuildContext context) => const Scaffold(
    body: Center(
      child: Text(
        "History Page",
        style: TextStyle(fontSize: 24, color: Colors.grey),
      ),
    ),
  );
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});
  @override
  Widget build(BuildContext context) => const Scaffold(
    body: Center(
      child: Text(
        "Profile Page",
        style: TextStyle(fontSize: 24, color: Colors.grey),
      ),
    ),
  );
}

// --- Main Root Screen ---
class RootScreen extends StatefulWidget {
  const RootScreen({super.key});

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  // 0: Home, 1: Search, 2: History, 3: Profile
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const GalleryScreen(),
    const AlbumsScreen(),
    const HistoryScreen(),
    const ProfileScreen(),
  ];

  void _onAddPhotoTapped() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ImageSelectionScreen()),
    );
  }

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true, // Allows body to flow behind the floating nav bar
      body: IndexedStack(index: _currentIndex, children: _screens),
      bottomNavigationBar: SafeArea(
        child: Container(
          height: 80,
          margin: const EdgeInsets.fromLTRB(20, 0, 20, 24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(40),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 30,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // Tab 0: Home
              _NavBarIcon(
                icon: Icons.image,
                label: "Gallery",
                isSelected: _currentIndex == 0,
                onTap: () => _onTabTapped(0),
              ),

              // Tab 1: Search
              _NavBarIcon(
                icon: Icons.photo_album,
                label: "Album",
                isSelected: _currentIndex == 1,
                onTap: () => _onTabTapped(1),
              ),

              // CENTER BUTTON: Add New (Floating Action)
              GestureDetector(
                onTap: _onAddPhotoTapped,
                child: Container(
                  width: 58,
                  height: 58,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(
                      255,
                      235,
                      153,
                      47,
                    ), // Pink accent color
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: const Color.fromARGB(
                          255,
                          235,
                          153,
                          47,
                        ).withOpacity(0.4),
                        blurRadius: 0,
                        offset: const Offset(0, 0),
                      ),
                    ],
                  ),
                  child: const Icon(Icons.add, color: Colors.white, size: 32),
                ),
              ),

              // Tab 2: History
              _NavBarIcon(
                icon: Icons.history_rounded,
                label: "History",
                isSelected: _currentIndex == 2,
                onTap: () => _onTabTapped(2),
              ),

              // Tab 3: Profile
              _NavBarIcon(
                icon: Icons.person_rounded,
                label: "Profile",
                isSelected: _currentIndex == 3,
                onTap: () => _onTabTapped(3),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Helper Widget for the Icons
class _NavBarIcon extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _NavBarIcon({
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque, // Ensures the tap area is generous
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 26,
            color: isSelected
                ? Color.fromARGB(255, 235, 153, 47)
                : Colors.grey.shade400,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
              color: isSelected
                  ? Color.fromARGB(255, 102, 62, 9)
                  : Colors.grey.shade400,
            ),
          ),
        ],
      ),
    );
  }
}
