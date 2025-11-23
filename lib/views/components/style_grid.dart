import 'package:flutter/material.dart';
import 'style_preview_card.dart';

class StyleGrid extends StatelessWidget {
  final Function(int) onStyleTapped;

  const StyleGrid({
    super.key,
    required this.onStyleTapped,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3, // 3 columns makes them smaller
        crossAxisSpacing: 8, 
        mainAxisSpacing: 8,
        childAspectRatio: 0.9, 
      ),
      itemCount: 9,
      itemBuilder: (context, index) {
        
        // --- 1. SPECIAL CARD FOR INDEX 0 (Navigates to Photo Grid) ---
        if (index == 0) {
          return GestureDetector(
            onTap: () => onStyleTapped(index),
            child: Container(
              decoration: BoxDecoration(
                // Using the pink accent color from your nav bar
                color: Color.fromARGB(255, 235, 153, 47).withOpacity(0.08), 
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: Color.fromARGB(255, 235, 153, 47).withOpacity(0.3),
                  width: 1.5
                ),
              ),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.auto_awesome_mosaic, 
                    size: 28, 
                    color: Color.fromARGB(255, 235, 153, 47)
                  ),
                  SizedBox(height: 8),
                  Text(
                    "All Photos",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 235, 153, 47),
                    ),
                  ),
                ],
              ),
            ),
          );
        }

        // --- 2. STANDARD CARDS FOR OTHER INDEXES ---
        final style = (index % 3 == 0) ? "Anime" : "Oil Paint";

        return GestureDetector(
          onTap: () => onStyleTapped(index),
          child: StylePreviewCard(
            styleName: style,
          ),
        );
      },
    );
  }
}