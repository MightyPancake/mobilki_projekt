// home.dart
import 'package:flutter/material.dart';
import 'package:proj/utils/themes.dart';
import 'package:provider/provider.dart';
import 'main.dart';

class HomeView extends StatelessWidget {
  final VoidCallback onSignIn;

  const HomeView({required this.onSignIn, super.key});

  @override
  Widget build(BuildContext context) {
    var theme = myTheme;

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: AppBar(title: const Text('User Profile')),
      floatingActionButton: FloatingActionButton(
        onPressed: onSignIn,
        tooltip: 'Sign in with Google',
        child: Icon(Icons.login),
      ),
      body: Center(
        child: Consumer<MyAppState>(
          builder: (context, appState, _) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundImage: appState.userPhotoUrl.isNotEmpty
                      ? NetworkImage(appState.userPhotoUrl)
                      : AssetImage('assets/img/default_avatar.jpg') as ImageProvider,
                ),
                SizedBox(height: 16),
                Text(appState.username, style: TextStyle(fontSize: 24)),
                Text(appState.userEmail, style: TextStyle(fontSize: 16)),
              ],
            );
          },
        ),
      ),
    );
  }
}
