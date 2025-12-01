import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About Us'),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'About us',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'Welcome to the Union Shop!',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18),
            ),
            Text(
              'We are dedicated to providing quality merchandise for our community.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18),
            ),
            Text(
              'We hope you enjoy our products as much as we enjoy offering them to you.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18),
            ),
            Text(
              'Happy shopping!',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18),
            ),
            Text(
              '- The Union Shop Team',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, fontStyle: FontStyle.italic),
            )
          ],
        ),
      ),
    );
  }
}