class Wisata {
  final String kategori;
  final String nama;
  final String deskripsi;
  final String imageTitleUrl;
  late List<String> imageUrls;

  bool isFavorite;
  double rating;
  int views;

  Wisata({
    required this.kategori,
    required this.nama,
    required this.deskripsi,
    required this.imageTitleUrl,
    this.isFavorite = false,
    this.rating = 0,
    this.views = 0,
  });
}
