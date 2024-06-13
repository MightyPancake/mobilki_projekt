import 'package:english_words/english_words.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:proj/firebase_options.dart';
import 'package:proj/utils/themes.dart';
import 'package:provider/provider.dart';

//Import views
import 'home.dart';
import 'friends_list/friends.dart';
import 'utils/splash_screen.dart';  // Import SplashScreen
// import 'events.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'frienDiary',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: myTheme.colorScheme
        ),
        home: SplashScreen(),
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {
  var username = "Username";
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var selectedIndex = 1;


  void navbarTapped(int index){
    setState(() {
      selectedIndex = index;
    });
  }
  
  @override
  Widget build(BuildContext context) {
    Widget view;
    switch (selectedIndex) {
      case 0:
        view = FriendsView();
        break;
      case 1:
        view = HomeView();
        break;
      // case 2:
      //   view = EventsView();
      //   break;
      // case 3:
      //   view = AddFriendView();
      //   break;
      default:
        view = Placeholder();
    }

    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.people), label: 'Friends'),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          // BottomNavigationBarItem(icon: Icon(Icons.event), label: 'Events'),
        ],
        currentIndex: selectedIndex,
        onTap: navbarTapped,
      ),
      body: Expanded(
        child: Container(
          color: myTheme.colorScheme.surface,
          child: view,
        ),
      ),
    );
  }
}


class BigCard extends StatelessWidget {
  const BigCard({
    super.key,
    required this.pair,
  });

  final WordPair pair;

  @override
  Widget build(BuildContext context) {
    var theme = myTheme;
    var style = theme.textTheme.displayMedium!.copyWith(
      color: theme.colorScheme.onPrimary,
    );
    return Card(
      color: theme.colorScheme.primary,
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Text(
          pair.asLowerCase,
          style: style,
          semanticsLabel: pair.asPascalCase,
        ),
      ),
    );
  }
}

