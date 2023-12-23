import 'package:flutter/material.dart';

class BetScreen extends StatefulWidget {
  @override
  _BetScreenState createState() => _BetScreenState();
}

class _BetScreenState extends State<BetScreen> {
  TextEditingController _scoreController = TextEditingController();
  int _betScore = 0;

  @override
  void dispose() {
    _scoreController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red, // Blue-themed app bar
        title: Text(
          'Place Your Bet',
          style: TextStyle(
            fontFamily: 'AnimeFont', // Anime-style font
            fontSize: 24.0,
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.blue.shade600, // Blue gradient start color
              Colors.red.shade600, // Red gradient end color
            ],
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _scoreController,
                keyboardType: TextInputType.number,
                style: TextStyle(
                  color: Colors.white, // Text color
                  fontSize: 18.0,
                ),
                decoration: InputDecoration(
                  labelText: 'Enter the score to bet',
                  labelStyle: TextStyle(
                    color: Colors.white,
                    fontFamily: 'AnimeFont',
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _betScore = int.tryParse(_scoreController.text) ?? 0;
                  });
                  // Navigate to the multiplayer page passing the bet score
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          MultiplayerPage(betScore: _betScore),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.redAccent, // Red button color
                  padding: EdgeInsets.symmetric(vertical: 15.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
                child: Text(
                  'Start Multiplayer',
                  style: TextStyle(
                    fontFamily: 'AnimeFont',
                    fontSize: 20.0,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MultiplayerPage extends StatelessWidget {
  final int betScore;

  const MultiplayerPage({Key? key, required this.betScore}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent, // Blue-themed app bar
        title: Text(
          'Multiplayer Page',
          style: TextStyle(
            fontFamily: 'AnimeFont', // Anime-style font
            fontSize: 24.0,
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.blue.shade600, // Blue gradient start color
              Colors.red.shade600, // Red gradient end color
            ],
          ),
        ),
        child: Center(
          child: Text(
            'Bet Score: $betScore',
            style: TextStyle(
              fontFamily: 'AnimeFont', // Anime-style font
              fontSize: 24.0,
              color: Colors.white, // Text color
            ),
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: BetScreen(),
  ));
}
