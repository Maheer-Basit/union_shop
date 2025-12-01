import 'package:flutter/material.dart';

class Footer extends StatelessWidget {
  const Footer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: double.infinity,
      color: Colors.grey[50],
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          LayoutBuilder(builder: (ctx, constraints) {
            final isWide = constraints.maxWidth >= 800;

            Widget sectionTitle(String text) => Text(
                  text,
                  style: theme.textTheme.titleMedium
                      ?.copyWith(fontWeight: FontWeight.bold),
                );

            Widget openingHours() => const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Opening Hours',
                        style: TextStyle(fontWeight: FontWeight.w700)),
                    SizedBox(height: 8),
                    Text('Mon - Fri: 9:00 - 17:00'),
                    Text('Saturday: 10:00 - 16:00'),
                    Text('Sunday: Closed'),
                  ],
                );

            Widget helpInfo() => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    sectionTitle('Help & Information'),
                    const SizedBox(height: 8),
                    TextButton(
                      onPressed: () {},
                      style: TextButton.styleFrom(padding: EdgeInsets.zero),
                      child: const Text('Search'),
                    ),
                    TextButton(
                      onPressed: () {},
                      style: TextButton.styleFrom(padding: EdgeInsets.zero),
                      child: const Text('Terms & Conditions of Sale Policy'),
                    ),
                  ],
                );

            Widget latestOffers() => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    sectionTitle('Latest Offers'),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: 'Enter your email',
                              border: OutlineInputBorder(),
                              isDense: true,
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 12),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        ElevatedButton(
                          onPressed: () {},
                          child: const Text('Subscribe'),
                        ),
                      ],
                    ),
                  ],
                );

            if (isWide) {
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: openingHours()),
                  Expanded(child: helpInfo()),
                  Expanded(child: latestOffers()),
                ],
              );
            }

            // stacked layout for narrow screens
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                openingHours(),
                const SizedBox(height: 18),
                helpInfo(),
                const SizedBox(height: 18),
                latestOffers(),
              ],
            );
          }),

          const SizedBox(height: 20),
          const Divider(),
          const SizedBox(height: 12),

          // Social links row
          Center(
            child: Wrap(
              spacing: 12,
              alignment: WrapAlignment.start, 
              children: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.facebook, color: Color(0xFF444444)),
                  tooltip: 'Facebook',
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.alternate_email,
                      color: Color(0xFF444444)),
                  tooltip: 'Twitter',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
