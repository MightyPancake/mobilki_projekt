// home.dart
import 'package:flutter/material.dart';
import 'package:proj/utils/themes.dart';
import 'package:provider/provider.dart';
import 'main.dart';

class HomeView extends StatelessWidget {
  final VoidCallback onSignIn;

  const HomeView({Key? key, required this.onSignIn}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final myAppState = Provider.of<MyAppState>(context);

    return Scaffold(
      backgroundColor: myTheme.colorScheme.surface,
      appBar: AppBar(title: Text('User Profile')),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          onSignIn(); // Call the sign-in method
        },
        tooltip: 'Sign in with Google',
        child: Icon(Icons.login),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(myAppState.userPhotoUrl),
            ),
            SizedBox(height: 16),
            Text(myAppState.username, style: TextStyle(fontSize: 24)),
            Text(myAppState.userEmail, style: TextStyle(fontSize: 24)),
          ],
        ),
      ),
    );
  }
}
