import 'package:flutter/material.dart';
import 'questions_page.dart';
import 'drawer_content.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'package:provider/provider.dart';
import 'PI_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HintManager.initialize();
  await TotalScoreManager.initialize();
  SharedPreferences prefs = await SharedPreferences.getInstance();

  int defaultHintCount = prefs.getInt('hintCount') ?? 41;
  int defaultTotalScore = prefs.getInt('totalScore') ?? 500;

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (_) =>
                PlayerStatisticsProvider()), // Add PlayerStatisticsProvider
      ],
      child: AnimeQuizApp(
        hintCount: defaultHintCount,
        totalScore: defaultTotalScore,
        prefs: prefs, // Pass SharedPreferences to AnimeQuizApp
      ),
    ),
  );
}

class HintManager {
  static late SharedPreferences _prefs;

  static Future<void> initialize() async =>
      _prefs = await SharedPreferences.getInstance();

  static int getHintCount() => _prefs.getInt('hintCount') ?? 41;

  static void setHintCount(int count) => _prefs.setInt('hintCount', count);

  static void deductGeneralHint() {
    int currentCount = getHintCount();
    if (currentCount > 0) {
      currentCount--;
      setHintCount(currentCount);
    }
  }

  static incrementGeneralHint() {
    int currentCount = HintManager.getHintCount();
    currentCount++;
    HintManager.setHintCount(currentCount);
  }
}

class TotalScoreManager {
  static late SharedPreferences _prefs;

  static Future<void> initialize() async =>
      _prefs = await SharedPreferences.getInstance();

  static int getTotalScore() => _prefs.getInt('totalScore') ?? 500;

  static void setTotalScore(int score) => _prefs.setInt('totalScore', score);

  static void addToTotalScore(int scoreToAdd) {
    int currentScore = getTotalScore();
    currentScore += scoreToAdd;
    setTotalScore(currentScore);
  }

  static void subtractFromTotalScore(int scoreToSubtract) {
    int currentScore = getTotalScore();
    currentScore -= scoreToSubtract;
    setTotalScore(currentScore);
  }
}

class AnimeQuizApp extends StatelessWidget {
  final int hintCount;
  final int totalScore;
  final SharedPreferences prefs; // SharedPreferences instance

  AnimeQuizApp({
    required this.hintCount,
    required this.totalScore,
    required this.prefs,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Anime Quiz App',
      theme: ThemeData.light().copyWith(
        colorScheme: ColorScheme.light(
          primary: Colors.red, // Set primary color
          secondary: Colors.blue, // Set secondary color
        ),
        scaffoldBackgroundColor: Colors.grey[100],
      ),
      home: HomePage(
        hintCount: hintCount,
        totalScore: totalScore,
        prefs: prefs, // Pass SharedPreferences to HomePage
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  final int hintCount;
  final int totalScore;
  final SharedPreferences prefs; // SharedPreferences instance

  HomePage({
    required this.hintCount,
    required this.totalScore,
    required this.prefs,
  });

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Map<String, DateTime> titleLockStatus = {};

  // Timer to update the UI
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    // Initialize the timer
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      // Check if any title lock has expired
      _checkTitleLockExpiry();
    });
    // Load title lock status from SharedPreferences
    _loadTitleLockStatus();
  }

  @override
  void dispose() {
    // Cancel the timer when the widget is disposed
    _timer.cancel();
    super.dispose();
  }

  List<String> animeTitles = [
    "attack on titan",
    "demon slayer",
    "jujutsu kaisen",
    "naruto",
    "one piece",
    "one punch man"
  ];
  List<String> selectedTitles = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Anime Quiz',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          Tooltip(
            message:
                'Total Hints:  ${widget.prefs.getInt('hintCount') ?? 41}', // Show hint count in tooltip
            child: IconButton(
              icon: Icon(Icons.lightbulb),
              onPressed: () {
                HintManager.incrementGeneralHint();
                setState(() {});
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Score: ${widget.prefs.getInt('totalScore') ?? 500}',
              style: TextStyle(fontSize: 19),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/hollow.png'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: GridView.builder(
                  itemCount: animeTitles.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 8.0,
                    mainAxisSpacing: 8.0,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    final title = animeTitles[index];
                    final isSelected = selectedTitles.contains(title);
                    final remainingTime = titleLockStatus.containsKey(title)
                        ? titleLockStatus[title]!
                            .difference(DateTime.now())
                            .inSeconds
                        : 0;
                    final isLocked = remainingTime > 0;

                    return GestureDetector(
                      onTap: () => toggleSelection(title),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16.0),
                          border: Border.all(
                            color: (isSelected || isLocked)
                                ? Colors.white
                                : Colors.transparent,
                            width: 2.0,
                          ),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16.0),
                          child: Stack(
                            fit: StackFit.expand,
                            children: [
                              Image.asset(
                                'assets/$title.png',
                                fit: BoxFit.cover,
                              ),
                              if ((isSelected))
                                Positioned.fill(
                                  child: Container(
                                    color: Colors.black.withOpacity(0.5),
                                    child: Center(
                                      child: Text(
                                        title.toUpperCase(),
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              if (isSelected)
                                Positioned(
                                  top: 10,
                                  right: 10,
                                  child: Icon(
                                    Icons.check,
                                    color: Colors.white,
                                    size: 30.0,
                                  ),
                                ),
                              if (isLocked)
                                Positioned.fill(
                                    child: Container(
                                  color: Colors.black.withOpacity(0.5),
                                  child: Center(
                                    child: Icon(
                                      Icons.lock,
                                      color: Colors.white,
                                      size: 50,
                                    ),
                                  ),
                                )),
                              if (isLocked)
                                Positioned(
                                  top: 10,
                                  right: 10,
                                  child: Text(
                                    '$remainingTime',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20.0,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
          if (selectedTitles.length >= 2)
            PreferredSize(
              preferredSize: Size.fromHeight(50.0),
              child: BottomAppBar(
                color: Colors.transparent,
                elevation: 0,
                child: Container(
                  height: 60.0,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.blue.shade600, Colors.red.shade600],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero,
                        ),
                        primary: Colors.transparent,
                        elevation: 0,
                      ),
                      onPressed: navigateToQuestionsPage,
                      child: Ink(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Colors.red.shade600, Colors.blue.shade600],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          ),
                        ),
                        child: Container(
                          alignment: Alignment.center,
                          child: Text(
                            'Start Quiz',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              shadows: [
                                Shadow(
                                  blurRadius: 2,
                                  color: Colors.black.withOpacity(0.5),
                                  offset: Offset(1, 1),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
      drawer: CustomDrawer(),
    );
  }

  void toggleSelection(String title) {
    setState(() {
      // Check if the title is locked
      if (titleLockStatus.containsKey(title) &&
          titleLockStatus[title]!.isAfter(DateTime.now())) {
        // Title is still locked, do not toggle selection
        return;
      }
      if (selectedTitles.contains(title)) {
        selectedTitles.remove(title);
      } else {
        selectedTitles.add(title);
      }
    });
  }

  void navigateToQuestionsPage() {
    if (selectedTitles.length >= 2) {
      int lockDurationInSeconds = calculateLockDuration(selectedTitles.length);
      // Lock titles after "Start Quiz" button is clicked
      for (String title in selectedTitles) {
        titleLockStatus[title] =
            DateTime.now().add(Duration(seconds: lockDurationInSeconds));
        // Save title lock status to SharedPreferences
        widget.prefs.setString(
          title,
          titleLockStatus[title]!.toIso8601String(),
        );
      }
      print("Selected Titles in HomePage: $selectedTitles");
      // Navigate to QuestionsPage
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => QuestionsPage(
            selectedTitles: selectedTitles,
          ),
        ),
      ).then((_) {
        // Clear selectedTitles after returning from QuestionsPage
        selectedTitles.clear();
      });
    }
  }

  int calculateLockDuration(int numberOfSelectedTitles) {
    switch (numberOfSelectedTitles) {
      case 2:
        return 10 * 60; // 10 minutes
      case 3:
        return 7 * 60 + 30; // 7 minutes and 30 seconds
      case 4:
        return 5 * 60; // 5 minutes
      case 5:
        return 2 * 60 + 30; // 2 minutes and 30 seconds
      case 6:
        return 0; // No lock
      default:
        return 0; // No lock by default
    }
  }

  void _checkTitleLockExpiry() {
    // Check if any title lock has expired
    setState(() {
      titleLockStatus
          .removeWhere((title, lockTime) => lockTime.isBefore(DateTime.now()));
    });
  }

  void _loadTitleLockStatus() {
    // Load title lock status from SharedPreferences
    animeTitles.forEach((title) {
      String? lockTimeStr = widget.prefs.getString(title);
      if (lockTimeStr != null) {
        DateTime lockTime = DateTime.parse(lockTimeStr);
        if (lockTime.isAfter(DateTime.now())) {
          titleLockStatus[title] = lockTime;
        }
      }
    });
  }
}
