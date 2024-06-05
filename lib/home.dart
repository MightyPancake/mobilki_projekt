import 'package:flutter/material.dart';
import 'package:proj/themes.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = myTheme;
    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: AppBar(title: const Text('User Profile')),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/img/bob.jpg'),
            ),
            SizedBox(height: 16),
            Text('John Doe', style: TextStyle(fontSize: 24)),
            // List upcoming events here (e.g., using ListView)
          ],
        ),
      ),
    );
  }
}
