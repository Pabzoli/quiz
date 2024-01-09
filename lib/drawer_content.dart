import 'package:flutter/material.dart';
import 'package:quiz/multi_P.dart';

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 170,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.purple,
              Colors.red,
              Colors.black,
              Colors.blue,
              Colors.purple,
            ], // Red, black, and blue gradient
            begin: Alignment.topLeft, // Optional: define the gradient start
            end: Alignment.bottomRight, // Optional: define the gradient end
          ),
        ), // Background color for the drawer
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            _buildOutlinedTile(
              icon: Icons.person,
              text: 'Player Information',
              onTap: () {
                // Handle tapping on player information
              },
              backgroundColor: Colors.purple, // Background color for the tile
            ),
            _buildOutlinedTile(
              icon: Icons.people,
              text: 'Multiplayer Mode',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => BetScreen()),
                );
              },
              backgroundColor: Colors.white, // Background color for the tile
            ),
            _buildOutlinedTile(
              icon: Icons.file_download,
              text: 'Download Resources',
              onTap: () {
                // Handle tapping on download resources
              },
              backgroundColor: Colors.blue, // Background color for the tile
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOutlinedTile({
    required IconData icon,
    required String text,
    required Function() onTap,
    required Color backgroundColor,
  }) {
    return Container(
      margin: EdgeInsets.symmetric(
          vertical: 5, horizontal: 5), // Add vertical margin between cards
      decoration: BoxDecoration(
        border: Border.all(
            color: Colors.black,
            width: 5.0), // Outline the card with a black border
        borderRadius: BorderRadius.circular(20), // Curved edges
      ),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15), // Curved edges for the card
        ),
        margin: EdgeInsets.zero,
        color: backgroundColor, // Background color for the tile
        child: ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 12),
          title: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: Colors.black, size: 55), // Icon color
              SizedBox(height: 2),
              Text(
                text,
                textAlign: TextAlign.center,
                style:
                    TextStyle(color: Colors.black, fontSize: 22), // Text color
              ),
            ],
          ),
          onTap: onTap,
        ),
      ),
    );
  }
}
