// main.dart
import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:proj/firebase_options.dart';
import 'package:proj/friend_app.dart';
import 'package:proj/utils/themes.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

// Import views
import 'home.dart';
import 'friends_list/friends.dart';
import 'utils/splash_screen.dart';  // Import SplashScreen


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return ChangeNotifierProvider(
            create: (context) => MyAppState(),
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'frienDiary',
              theme: ThemeData(
                useMaterial3: true,
                colorScheme: myTheme.colorScheme,
              ),
              home: SplashScreen(),
            ),
          );
        }
        return CircularProgressIndicator();
      },
    );
  }
}

class MyAppState extends ChangeNotifier {
  String username = "Username";
  String userEmail = "";
  String userPhotoUrl = "";
  List<Friend> friends = [];
  List<Event> events = [];

  void updateUser(User? user) {
    if (user != null) {
      username = user.displayName ?? "Username";
      userEmail = user.email ?? "";
      userPhotoUrl = user.photoURL ?? "";
      notifyListeners();
    }
  }

  void updateFriendsAndEvents(List<Friend> fetchedFriends, List<Event> fetchedEvents) {
    friends = [...fetchedFriends];
    events = [...fetchedEvents];
    notifyListeners();
  }

  Future<void> saveDataToFirebase() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;

    if (user != null) {
      final DatabaseReference usersRef = FirebaseDatabase.instance.ref().child('users');
      final DatabaseReference userRef = usersRef.child(user.uid);

      await userRef.set({
        'username': user.displayName,
        'email': user.email,
        'friends': friends.map((friend) => friend.toMap()).toList(),
        'events': events.map((event) => event.toMap()).toList(),
      });
    }
  }

  Future<void> fetchDataFromFirebase(String userId) async {
    try {
      final DatabaseReference usersRef = FirebaseDatabase.instance.reference().child('users').child(userId);
      DatabaseEvent event = await usersRef.once();
      DataSnapshot dataSnapshot = event.snapshot;
      var value = dataSnapshot.value;

      if (value != null && value is Map<dynamic, dynamic>) {
        String jsonString = jsonEncode(value);
        Map<String, dynamic> dataMap = jsonDecode(jsonString);

        List<Friend> fetchedFriends = [];
        if (dataMap.containsKey('friends')) {
          List<dynamic> friendsDataList = dataMap['friends'];
          List<Map<String, dynamic>> friendsData = List<Map<String, dynamic>>.from(friendsDataList);
          fetchedFriends = friendsData.map((friendData) => Friend.fromJson(friendData)).toList();
        }

        List<Event> fetchedEvents = [];
        if (dataMap.containsKey('events')) {
          List<dynamic> eventsDataList = dataMap['events'];
          List<Map<String, dynamic>> eventsData = List<Map<String, dynamic>>.from(eventsDataList);
          fetchedEvents = eventsData.map((eventData) => Event.fromJson(eventData)).toList();
        }

        updateFriendsAndEvents(fetchedFriends, fetchedEvents);
      } else {
        print('Data is not in expected format');
      }
    } catch (error) {
      print('Error fetching data: $error');
    }
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var selectedIndex = 1;

  void navbarTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  Future<void> _handleSignIn() async {
    try {
      //Mobile client ID
      final String clientId = '559087557131-6f6qnjk74ab60kr7ha34e3iu03979o7h.apps.googleusercontent.com';
      
      //Web client ID
      // final String clientId = '559087557131-6f6qnjk74ab60kr7ha34e3iu03979o7h.apps.googleusercontent.com';

      final GoogleSignIn googleSignIn = GoogleSignIn(
        clientId: clientId,
        scopes: ['email'],
      );

      GoogleSignInAccount? googleSignInAccount = await googleSignIn.signInSilently();
      if (googleSignInAccount == null) {
        googleSignInAccount = await googleSignIn.signIn();
      }

      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;

        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );

        final UserCredential authResult = await FirebaseAuth.instance.signInWithCredential(credential);
        final User? user = authResult.user;

        if (user != null) {
          print('Signed in as: ${user.displayName}');
          Provider.of<MyAppState>(context, listen: false).fetchDataFromFirebase(user.uid);
          Provider.of<MyAppState>(context, listen: false).updateUser(user);

        } else {
          print('Sign in failed');
        }
      } else {
        print('Google Sign-In cancelled or failed.');
      }
    } catch (error) {
      print('Error signing in with Google: $error');
    }
  }

  Future<void> _handleSignOut() async {
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn();
      await googleSignIn.signOut();

      await FirebaseAuth.instance.signOut();

      // Clear user data from app state
      Provider.of<MyAppState>(context, listen: false).updateUser(null);
      Provider.of<MyAppState>(context, listen: false).updateFriendsAndEvents([], []);
    } catch (error) {
      print('Error signing out: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    final myAppState = Provider.of<MyAppState>(context);

    // Determine if the user is signed in
    final bool isLoggedIn = myAppState.userEmail.isNotEmpty;

    Widget view;
    switch (selectedIndex) {
      case 0:
        view = FriendsView();
        break;
      case 1:
        view = HomeView(onSignIn: isLoggedIn ? _handleSignOut : _handleSignIn, isLoggedIn: isLoggedIn);
        break;
      default:
        view = Placeholder();
    }

    
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.people), label: 'Friends'),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        ],
        currentIndex: selectedIndex,
        onTap: navbarTapped,
      ),
      body: Container(
        color: myTheme.colorScheme.surface,
        child: view,
      ),
    );
  }
}