import 'package:flutter/material.dart';
import 'package:union_shop/widgets/mainheader.dart';
import 'package:union_shop/widgets/footer.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            MainHeader(
              currentRoute: '/about',
              onNavigate: (route) => Navigator.pushNamed(context, route),
              onSaleTap: () => Navigator.pushNamed(context, '/sale'),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 12.0),
              child: Center(
                child: Text(
                  'About us',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(20, 24, 32, 24),
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
                    style: TextStyle(fontSize: 18, fontStyle: FontStyle.italic),
                  )
                ],
              ),
            ),
            const Footer(),
          ],
        ),
      ),
    );
  }
}
