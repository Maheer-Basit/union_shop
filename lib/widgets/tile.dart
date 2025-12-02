import 'package:flutter/material.dart';

class CollectionTile extends StatelessWidget {
 final String image;
  final String title;
  final VoidCallback? onTap;
  final double height;
  const CollectionTile({
    Key? key,
    required this.image,
    required this.title,
    this.onTap,
    this.height = 160,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
    
      child: ClipRRect(
        child: SizedBox(
          height: height,
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image(
                image: AssetImage(image),
                fit: BoxFit.cover,
              ),
              Container(color: Colors.black.withOpacity(0.45)),
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Text(
                    title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}