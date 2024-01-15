import 'package:flutter/material.dart';
import 'questions_page.dart';
import 'drawer_content.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HintManager.initialize();
  await TotalScoreManager.initialize();
  SharedPreferences prefs = await SharedPreferences.getInstance();

  int defaultHintCount = prefs.getInt('hintCount') ?? 41;
  int defaultTotalScore = prefs.getInt('totalScore') ?? 500;

  runApp(
    AnimeQuizApp(hintCount: defaultHintCount, totalScore: defaultTotalScore),
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

  AnimeQuizApp({required this.hintCount, required this.totalScore});
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
      home: HomePage(hintCount: hintCount, totalScore: totalScore),
    );
  }
}

class HomePage extends StatefulWidget {
  final int hintCount;
  final int totalScore;

  HomePage({required this.hintCount, required this.totalScore});
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Rebuild the AppBar when the dependencies change (e.g., returning to this page)
    setState(() {});
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
                  'Total Hints:  ${HintManager.getHintCount()}', // Show hint count in tooltip
              child: IconButton(
                icon: Icon(Icons.lightbulb),
                onPressed: () {
                  HintManager.incrementGeneralHint();
                  setState(() {});
                },
              )),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Score: ${TotalScoreManager.getTotalScore()}',
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

                    return GestureDetector(
                      onTap: () => toggleSelection(title),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16.0),
                          border: Border.all(
                            color:
                                isSelected ? Colors.white : Colors.transparent,
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
                              if (isSelected)
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
      if (selectedTitles.contains(title)) {
        selectedTitles.remove(title);
      } else {
        selectedTitles.add(title);
      }
    });
  }

  void navigateToQuestionsPage() {
    if (selectedTitles.length >= 2) {
      print("Selected Titles in HomePage: $selectedTitles");
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => QuestionsPage(
            selectedTitles: selectedTitles,
          ),
        ),
      );
    }
  }
}
