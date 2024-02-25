import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StatisticsInfoDialog extends StatelessWidget {
  final String statisticName;
  final String statisticInfo;

  const StatisticsInfoDialog({
    Key? key,
    required this.statisticName,
    required this.statisticInfo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(statisticName),
      content: SingleChildScrollView(
        child: Text(statisticInfo),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Close'),
        ),
      ],
    );
  }
}

class PlayerStatistics {
  int gamesWon;
  int gamesLost;
  int hseStaked;
  int hseWon;
  int hseLost;
  int gamesPlayed;

  PlayerStatistics({
    required this.gamesWon,
    required this.gamesLost,
    required this.hseStaked,
    required this.hseWon,
    required this.hseLost,
    required this.gamesPlayed,
  });
}

class PlayerStatisticsProvider extends ChangeNotifier {
  PlayerStatistics _playerStatistics = PlayerStatistics(
    gamesWon: 0,
    gamesLost: 0,
    hseStaked: 0,
    hseWon: 0,
    hseLost: 0,
    gamesPlayed: 0,
  );

  bool _won50GamesAchievement = false;
  bool _lost50GamesAchievement = false;
  bool _played100GamesAchievement = false;
  bool _won5000ScoreAchievement = false;
  bool _lost2500ScoreAchievement = false;

  PlayerStatistics get playerStatistics => _playerStatistics;

  bool get won50Games => _won50GamesAchievement;
  bool get lost50Games => _lost50GamesAchievement;
  bool get played100Games => _played100GamesAchievement;
  bool get won5000Score => _won5000ScoreAchievement;
  bool get lost2500Score => _lost2500ScoreAchievement;

  void updatePlayerStatistics(PlayerStatistics newStatistics) {
    _playerStatistics = newStatistics;
    _checkAchievements(); // Check achievements when statistics are updated
    notifyListeners();
  }

  void _checkAchievements() {
    // Check for achievements
    if (_playerStatistics.gamesWon >= 50) {
      _won50GamesAchievement = true;
    }
    if (_playerStatistics.gamesLost >= 50) {
      _lost50GamesAchievement = true;
    }
    if (_playerStatistics.gamesPlayed >= 100) {
      _played100GamesAchievement = true;
    }
    if (_playerStatistics.hseWon >= 5000) {
      _won5000ScoreAchievement = true;
    }
    if (_playerStatistics.hseLost >= 2500) {
      _lost2500ScoreAchievement = true;
    }
  }
}

class PInform extends StatefulWidget {
  const PInform({Key? key}) : super(key: key);

  @override
  State<PInform> createState() => _PInformState();
}

class _PInformState extends State<PInform> with SingleTickerProviderStateMixin {
  final List<String> imagePaths = [
    'assets/dark.jpg',
    'assets/Raiden_Shogun.png',
    'assets/rakd.jpg',
    'assets/Skad_Heart.jpg'
  ];

  String selectedImagePath = ''; // Initial image path
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    selectRandomImage();
  }

  void selectRandomImage() {
    final random = Random();
    setState(() {
      selectedImagePath = imagePaths[random.nextInt(imagePaths.length)];
    });
  }

  @override
  void dispose() {
    _tabController.dispose(); // Dispose the tab controller
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    PlayerStatistics playerStatistics =
        Provider.of<PlayerStatisticsProvider>(context).playerStatistics;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text(
          "Player Information",
          style: TextStyle(
            color: Colors.white,
            fontFamily: "AnimeFont",
            fontSize: 24.0,
          ),
        ),
      ),
      body: Column(
        children: [
          Stack(
            children: [
              Container(
                height: MediaQuery.of(context).size.height /
                    4, // 1/4th of screen height
                color: Colors.blue, // Example color
                child: Center(
                  child: Text(
                    '',
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 15,
                left: 15,
                child: Container(
                  width: 125, // Fixed width for the square rectangle
                  height: 125, // Fixed height for the square rectangle
                  decoration: BoxDecoration(
                    color: Colors
                        .white10, // Example color for the square rectangle
                    border: Border.all(
                      color: Colors.black, // Border color
                      width: 4.0, // Border width
                    ),
                  ),
                  child: selectedImagePath.isNotEmpty
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.asset(
                            selectedImagePath,
                            fit: BoxFit.cover,
                          ),
                        )
                      : Center(
                          child: Text(
                            'Tap to add image',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                        ),
                ),
              ),
              Positioned(
                bottom: 25,
                right: 15,
                child: Text(
                  "User ID: 1111",
                  style: TextStyle(
                    fontSize: 17,
                    color: Colors.black,
                  ),
                ),
              ),
              Positioned(
                top: 35,
                left: 150,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(children: [
                      Text(
                        'Pabzoli',
                        style: TextStyle(
                            fontSize: 32.5,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Icon(Icons.edit_square)
                    ]),
                    SizedBox(
                      height: 7.5,
                    ),
                    Row(
                      children: [
                        Icon(Icons.star_border_rounded, size: 30),
                        SizedBox(width: 5),
                        Text(
                          '0',
                          style: TextStyle(
                            fontSize: 30,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Positioned(
                top: 150,
                left: 15,
                child: Row(
                  children: [
                    Icon(
                      Icons.search,
                      color: Colors.black,
                      size: 25,
                    ),
                    SizedBox(width: 5),
                    Text(
                      'UnknownServer',
                      style: TextStyle(
                        fontSize: 21,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Stack(
            children: [
              Container(
                height: MediaQuery.of(context).size.height /
                    16, // 1/4th of screen height
                color: Colors.blue, // Example color
                child: Center(),
              ),
              TabBar(
                controller: _tabController,
                labelColor: Colors.white, // Selected tab text color
                unselectedLabelColor: Colors.black, // Unselected tab text color
                labelStyle: TextStyle(fontSize: 20), // Selected tab text size
                tabs: [
                  Tab(
                    text: 'Statistics',
                  ),
                  Tab(text: 'Achievements'),
                  Tab(text: 'History'),
                ],
              ),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                SingleChildScrollView(
                  child: Container(
                    color: Colors.white,
                    padding: EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Based on Games Played in Multiplayer",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        SizedBox(height: 5),
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                children: [
                                  _buildStatItem(
                                    'GWon',
                                    playerStatistics.gamesWon.toString(),
                                    'You have won ${playerStatistics.gamesWon.toString()} games in total.',
                                  ),
                                  SizedBox(height: 10.0),
                                  _buildStatItem(
                                    'GLost',
                                    playerStatistics.gamesLost.toString(),
                                    'You have lost ${playerStatistics.gamesLost.toString()} games in total.',
                                  ),
                                  SizedBox(height: 10.0),
                                  _buildStatItem(
                                    'GPlayed',
                                    playerStatistics.gamesPlayed.toString(),
                                    'You have successfully completed ${playerStatistics.gamesPlayed.toString()} games in total.',
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: 20.0),
                            Expanded(
                              child: Column(
                                children: [
                                  _buildStatItem(
                                    'HSEW',
                                    playerStatistics.hseWon.toString(),
                                    'Your Highest Score ever won is ${playerStatistics.hseWon.toString()}',
                                  ),
                                  SizedBox(height: 10.0),
                                  _buildStatItem(
                                    'HSEL',
                                    playerStatistics.hseLost.toString(),
                                    'Your Highest Score ever lost is ${playerStatistics.hseLost.toString()}',
                                  ),
                                  SizedBox(height: 10.0),
                                  _buildStatItem(
                                    'HSES',
                                    playerStatistics.hseStaked.toString(),
                                    'Your Highest Score ever staked is ${playerStatistics.hseStaked.toString()}',
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  color: Colors.white,
                  child: Consumer<PlayerStatisticsProvider>(
                    builder: (context, playerStatisticsProvider, _) {
                      return _buildAchievementsTab();
                    },
                  ),
                ),
                Container(
                  color: Colors.white,
                  child: Center(child: Text('History content')),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.white,
              child: Placeholder(), // Placeholder for the rest of the content
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAchievementsTab() {
    return SingleChildScrollView(
      child: Container(
        color: Colors.white,
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildAchievementItem(
              'Won 50 games',
              'Win 50 games to unlock this achievement',
              Provider.of<PlayerStatisticsProvider>(context).won50Games,
            ),
            SizedBox(height: 10.0),
            _buildAchievementItem(
              'Lost 50 games',
              'Lose 50 games to unlock this achievement',
              Provider.of<PlayerStatisticsProvider>(context).lost50Games,
            ),
            SizedBox(height: 10.0),
            _buildAchievementItem(
              'Played 100 games',
              'Play 100 games to unlock this achievement',
              Provider.of<PlayerStatisticsProvider>(context).played100Games,
            ),
            SizedBox(height: 10.0),
            _buildAchievementItem(
              'Won 5000 Score',
              'Win 5000 score to unlock this achievement',
              Provider.of<PlayerStatisticsProvider>(context).won5000Score,
            ),
            SizedBox(height: 10.0),
            _buildAchievementItem(
              'Lost 2500 Score',
              'Lose 2500 score to unlock this achievement',
              Provider.of<PlayerStatisticsProvider>(context).lost2500Score,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(String label, String value, String info) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) => StatisticsInfoDialog(
            statisticName: label,
            statisticInfo: info,
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
        ),
        padding: EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Text(
                label,
                style: TextStyle(fontSize: 18.0),
              ),
            ),
            Flexible(
              child: Text(
                value,
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAchievementItem(
      String title, String description, bool achieved) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(
          'assets/icons_trophy.png', // Replace this with the path to your custom trophy image
          width: 36.0,
          height: 40.0,
        ),
        SizedBox(width: 12.0),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 4.0),
            Text(
              description,
              style: TextStyle(
                fontSize: 14.0,
                color: Colors.grey,
              ),
            ),
          ],
        ),
        Spacer(),
        if (achieved)
          Icon(
            Icons.check_circle,
            color: Colors.green,
          )
        else
          Icon(
            Icons.radio_button_unchecked,
            color: Colors.red,
          ),
      ],
    );
  }
}
