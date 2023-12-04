class Wisata {
  final String nama;
  final String deskripsi;
  final String imageTitleUrl;
  late List<String> imageUrls;

  bool isFavorite;
  double rating;

  Wisata({
    required this.nama,
    required this.deskripsi,
    required this.imageTitleUrl,
    this.isFavorite = false,
    this.rating = 0,
  });
}
