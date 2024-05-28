import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.colorScheme.background,
      appBar: AppBar(title: const Text('User Profile')),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/duck.jpg'),
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
