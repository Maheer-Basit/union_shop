class Collections{
  final String id;
  final String title;
  final String imageUrl;
  final List<String> productIds;

  const Collections({
    required this.id,
    required this.title,
    required this.imageUrl,
    this.productIds = const [],
  });
}