import 'dart:async';
import 'package:flutter/material.dart';

class Slide {
  final String imageUrl;
  final String title;
  final String subtitle;

  const Slide(
      {required this.imageUrl, required this.title, required this.subtitle});
}

class HeroSection extends StatefulWidget {
  final VoidCallback? onBrowse;
  final double height;
  final List<Slide> slides;
  final Duration autoPlayInterval;

  const HeroSection({
    Key? key,
    this.onBrowse,
    this.height = 400,
    this.autoPlayInterval = const Duration(seconds: 5),
    this.slides = const [
      Slide(
        //essential range image from assets folder
        imageUrl: 'assets/images/UOP_T_Shirt.png',
        title: 'Essential range',
        subtitle: 'Explore our essential collection',
      ),
      Slide(
        imageUrl:
            'https://shop.upsu.net/cdn/shop/files/PortsmouthCityPostcard2_1024x1024@2x.jpg?v=1752232561',
        title: 'The Print Shack',
        subtitle: 'Personalise your merch',
      ),
      Slide(
        imageUrl:
            'https://shop.upsu.net/cdn/shop/files/PortsmouthCityPostcard2_1024x1024@2x.jpg?v=1752232561',
        title: 'Hungry?',
        subtitle: 'Grab a snack while you shop',
      ),
      Slide(
        imageUrl:
            'https://shop.upsu.net/cdn/shop/files/PortsmouthCityPostcard2_1024x1024@2x.jpg?v=1752232561',
        title: "What's your next move?",
        subtitle: 'Find the perfect item today',
      ),
    ],
  }) : super(key: key);

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection> {
  late final PageController _pageController;
  Timer? _timer;
  int _current = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Precache images for smoother transitions
      for (final s in widget.slides) {
        precacheImage(NetworkImage(s.imageUrl), context);
      }
    });

    if (widget.slides.length > 1) _startAutoPlay();
  }

  @override
  void didUpdateWidget(covariant HeroSection oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.slides.length != oldWidget.slides.length) {
      _timer?.cancel();
      if (widget.slides.length > 1) _startAutoPlay();
    }
  }

  void _startAutoPlay() {
    _timer = Timer.periodic(widget.autoPlayInterval, (_) {
      if (!mounted || widget.slides.isEmpty) return;
      final next = (_current + 1) % widget.slides.length;
      _pageController.animateToPage(next,
          duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final slides = widget.slides;
    if (slides.isEmpty) return const SizedBox.shrink();

    return SizedBox(
      height: widget.height,
      width: double.infinity,
      child: Stack(
        children: [
          // background PageView
          Positioned.fill(
            child: PageView.builder(
              controller: _pageController,
              itemCount: slides.length,
              onPageChanged: (i) {
                setState(() => _current = i);
                if (_timer != null) {
                  _timer!.cancel();
                  _startAutoPlay();
                }
              },
              itemBuilder: (context, index) {
                final slide = slides[index];
                return DecoratedBox(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(slide.imageUrl),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Container(color: Colors.black.withOpacity(0.7)),
                );
              },
            ),
          ),

          // overlay content
          Positioned.fill(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 350),
                      transitionBuilder: (child, anim) => FadeTransition(
                        opacity: anim,
                        child: child,
                      ),
                      child: Column(
                        key: ValueKey<int>(_current),
                        children: [
                          Text(
                            slides[_current].title,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              height: 1.2,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            slides[_current].subtitle,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              height: 1.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 28),
                    ElevatedButton(
                      onPressed: widget.onBrowse,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF4d2963),
                        foregroundColor: Colors.white,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero,
                        ),
                      ),
                      child: const Text(
                        'BROWSE PRODUCTS',
                        style: TextStyle(fontSize: 14, letterSpacing: 1),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // indicators
          Positioned(
            bottom: 16,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(slides.length, (i) {
                final active = i == _current;
                return GestureDetector(
                  onTap: () => _pageController.animateToPage(i,
                      duration: const Duration(milliseconds: 350),
                      curve: Curves.easeInOut),
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 6),
                    width: active ? 12 : 8,
                    height: active ? 12 : 8,
                    decoration: BoxDecoration(
                      color: active ? Colors.white : Colors.white70,
                      shape: BoxShape.circle,
                    ),
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
