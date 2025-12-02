import 'package:flutter/material.dart';

class WinterFavourites extends StatelessWidget {
  const WinterFavourites({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Winter Favourites'),
      ),
      body: const Center(
        child: Text(
          'Winter Favourites',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}