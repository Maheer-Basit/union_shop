import 'package:flutter/material.dart';
import 'package:union_shop/widgets/mainheader.dart';
import 'package:union_shop/widgets/print.dart';
import 'package:union_shop/widgets/footer.dart';

class PrintShackPersonalisation extends StatelessWidget {
  const PrintShackPersonalisation({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            MainHeader(
              currentRoute: '/print-personalisation',
              onNavigate: (route) => Navigator.pushNamed(context, route),
              onSaleTap: () => Navigator.pushNamed(context, '/sale'),
            ),

            const SizedBox(height: 12),

            // Print customizer widget
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 12.0),
              child: PrintCustomizer(
                title: 'Custom UOP Hoodie',
                price: 24.99,
                images: [
                  'assets/images/UOP_Hoodie.png',
                  'assets/images/UOP_PSH.png',
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
