import 'package:flutter/material.dart';
import 'package:union_shop/widgets/navbar.dart';
import 'package:union_shop/widgets/footer.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          NavBar(
            currentRoute: '/about',
            onNavigate: (route) => Navigator.pushNamed(context, route),
            onSaleTap: () => Navigator.pushNamed(context, '/sale'),
          ),
          // page title moved under navbar
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 12.0),
            child: Center(
              child: Text(
                'About us',
                style:
                    TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          const Expanded(
            child: SingleChildScrollView(
              child: Padding(
                // left gap of 200, move content down with top padding
                padding: EdgeInsets.fromLTRB(20, 40, 32, 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Welcome to the Union Shop!',
                      textAlign: TextAlign.left,
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(height: 12),
                    Text(
                      'We are dedicated to providing quality merchandise for our community.',
                      textAlign: TextAlign.left,
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'We hope you enjoy our products as much as we enjoy offering them to you.',
                      textAlign: TextAlign.left,
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Happy shopping!',
                      textAlign: TextAlign.left,
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(height: 8),
                    Text(
                      '- The Union Shop Team',
                      textAlign: TextAlign.left,
                      style:
                          TextStyle(fontSize: 18, fontStyle: FontStyle.italic),
                    )
                  ],
                ),
              ),
            ),
          ),
          const Footer(),
        ],
      ),
    );
  }
}
