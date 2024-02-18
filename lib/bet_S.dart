import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:async';
import 'multiplayer_page.dart';
import 'main.dart';

class CustomAlertDialog extends StatelessWidget {
  final String title;
  final String content;
  final List<Widget> actions;

  const CustomAlertDialog({
    required this.title,
    required this.content,
    required this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: actions,
    );
  }
}

class BetValidation {
  static bool isValidBet(int betScore, int totalScore) {
    return betScore >= 100 &&
        betScore <= 99000 &&
        (betScore % 100 == 0 ||
            betScore % 1000 == 0 ||
            betScore % 10000 == 0 ||
            betScore % 100000 == 0) &&
        betScore <= totalScore;
  }
}

class BetScreen extends StatefulWidget {
  const BetScreen({
    Key? key,
  }) : super(key: key);

  @override
  _BetScreenState createState() => _BetScreenState();
}

class _BetScreenState extends State<BetScreen> {
  TextEditingController _scoreController = TextEditingController();
  int _betScore = 0;

  @override
  void initState() {
    super.initState();
    TotalScoreManager.initialize();
  }

  @override
  void dispose() {
    _scoreController.dispose();
    super.dispose();
  }

  void _navigateToMultiplayerPage(int betScore) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FindingOpponentScreen(betScore: betScore),
      ),
    );
  }

  void _showInvalidBetDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Invalid Bet'),
          content: Text(
            'Please enter a valid bet in multiples of 100s and within your total score.',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _handleBetPlacement() {
    int enteredBetScore = int.tryParse(_scoreController.text) ?? 0;

    if (BetValidation.isValidBet(
        enteredBetScore, TotalScoreManager.getTotalScore())) {
      setState(() {
        _betScore = enteredBetScore;
      });
      _navigateToMultiplayerPage(_betScore);
    } else {
      _showInvalidBetDialog();
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          Navigator.of(context).popUntil((route) => route.isFirst);
          return true;
        },
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.red,
            title: Text(
              'Place Your Bet',
              style: TextStyle(
                fontFamily: 'AnimeFont',
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
                  Colors.blue.shade600,
                  Colors.red.shade600,
                ],
              ),
            ),
            child: Padding(
              padding: EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Text(
                      'Total Score: ${TotalScoreManager.getTotalScore()}',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'AnimeFont',
                        fontSize: 18.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  TextFormField(
                    controller: _scoreController,
                    keyboardType: TextInputType.number,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                    ),
                    decoration: InputDecoration(
                      labelText: 'Enter the score to stake',
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
                      _handleBetPlacement();
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.redAccent,
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
        ));
  }
}

class FindingOpponentScreen extends StatefulWidget {
  final int betScore;

  const FindingOpponentScreen({Key? key, required this.betScore})
      : super(key: key);

  @override
  _FindingOpponentScreenState createState() => _FindingOpponentScreenState();
}

class _FindingOpponentScreenState extends State<FindingOpponentScreen> {
  String _opponentName = '';
  String _playerId = '';
  bool _isDialogVisible = false;
  late Timer _navigationTimer;

  @override
  void initState() {
    super.initState();
    TotalScoreManager.initialize();

    final random = Random();
    final randomDuration = Duration(seconds: 5 + random.nextInt(6));
    Future.delayed(randomDuration, () {
      setState(() {
        _opponentName = _generateRandomName();
        _playerId = _generateRandomPlayerId();
      });

      _showFoundOpponentDialog();
      _startNavigationTimer();
    });
  }

  @override
  void dispose() {
    _navigationTimer.cancel(); // Cancel the timer when disposing the screen
    super.dispose();
  }

  void _startNavigationTimer() {
    _navigationTimer = Timer(Duration(seconds: 7), _navigateBackToBetScreen);
  }

  void _navigateBackToBetScreen() {
    if (mounted) {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BetScreen(),
          ));
    }
  }

  String _generateRandomName() {
    List<String> names = ['Sakura', 'Ichigo', 'Naruto', 'Asuna', 'Luffy'];
    return names[Random().nextInt(names.length)];
  }

  String _generateRandomPlayerId() {
    const characters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    String playerId = '';
    for (int i = 0; i < 6; i++) {
      playerId += characters[Random().nextInt(characters.length)];
    }
    return playerId;
  }

  void _navigateToMultiplayerPage(int betScore) {
    _disposeTimer();
    TotalScoreManager.subtractFromTotalScore(betScore);
    print("Total Score: ${TotalScoreManager.getTotalScore()}");
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) {
          return FadeTransition(
            opacity: animation,
            child: MultiplayerPage(
              betScore: betScore,
              playerName: _opponentName,
            ),
          );
        },
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return child;
        },
        transitionDuration: Duration(milliseconds: 500),
      ),
    );
  }

  void _disposeTimer() {
    if (_navigationTimer.isActive) {
      _navigationTimer.cancel();
    }
  }

  void _showFoundOpponentDialog() async {
    setState(() {
      _isDialogVisible = true;
    });

    bool continueToMultiplayer = await showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async => false,
          child: AlertDialog(
            backgroundColor: Colors.white,
            title: Text(
              'Opponent Found!',
              style: TextStyle(color: Colors.black),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Opponent Name: $_opponentName',
                  style: TextStyle(color: Colors.black),
                ),
                SizedBox(height: 10),
                Text(
                  'Player ID: $_playerId',
                  style: TextStyle(color: Colors.black),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
                child: Text(
                  'Cancel',
                  style: TextStyle(color: Colors.red),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(
                      context, true); // Signal to navigate to MultiplayerPage
                },
                child: Text(
                  'Continue',
                  style: TextStyle(color: Colors.blue),
                ),
              ),
            ],
          ),
        );
      },
    );

    if (continueToMultiplayer == true) {
      _navigateToMultiplayerPage(widget.betScore);
    } else {
      Navigator.pop(context); // Navigate back to BetScreen
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context); // Navigate back to BetScreen
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red,
          title: Text(
            'Searching for your Opponent',
            style: TextStyle(color: Colors.white, fontSize: 25),
          ),
        ),
        backgroundColor: Colors.blueAccent,
        body: GestureDetector(
          onTap: () {
            if (_isDialogVisible) {
              Navigator.pop(context); // Navigate back to BetScreen
            }
          },
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
                  strokeWidth: 6.0,
                ),
                SizedBox(height: 20),
                Text(
                  'Finding Opponent',
                  style: TextStyle(fontSize: 30, color: Colors.white),
                ),
                SizedBox(height: 10),
                Text(
                  'Please wait...',
                  style: TextStyle(fontSize: 25, color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
