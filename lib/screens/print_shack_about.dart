import 'package:flutter/material.dart';
import 'package:union_shop/widgets/mainheader.dart';
import 'package:union_shop/widgets/footer.dart';

class PrintShackAbout extends StatelessWidget {
  const PrintShackAbout({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            MainHeader(
              currentRoute: '/print-shack',
              onNavigate: (route) => Navigator.pushNamed(context, route),
              onSaleTap: () => Navigator.pushNamed(context, '/sale'),
            ),
            const SizedBox(height: 12),
            const Center(
              child: Text(
                'The Union Print Shack',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 18),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildImage('assets/images/UOP_SH.png'),
                    _buildImage('assets/images/Print_Shack.png'),
                    _buildImage('assets/images/UOP_Hoodie.png'),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            Center(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 820),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Welcome to The Campus Custom Shop – your ultimate destination for personalizing your clothing! We specialize in high-quality, heat-pressed customization to help you make your mark, whether you\'re celebrating uni pride or expressing your unique individual style.',
                        textAlign: TextAlign.left,
                        style: TextStyle(fontSize: 18),
                      ),
                      SizedBox(height: 12),
                      Text(
                        'Uni Gear & Your Gear: We can personalize any garment! Bring in your official university clothing or any personal item you own—from hoodies and t-shirts to bags—and we\'ll add your custom print.',
                        textAlign: TextAlign.left,
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const Footer(),
          ],
        ),
      ),
    );
  }

  Widget _buildImage(String asset) => SizedBox(
        width: 260,
        height: 190,
        child: Image(
          image: AssetImage(asset),
          fit: BoxFit.cover,
        ),
      );
}
