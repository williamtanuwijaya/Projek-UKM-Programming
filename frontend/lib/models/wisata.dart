class Wisata {
  final String kategori;
  final String nama;
  final String deskripsi;
  final String imageTitleUrl;
  final String namaKota;
  late List<String> imageUrls;

  bool isFavorite;
  bool isGood;
  bool isBad;
  double rating;
  int views;
  int goodCounts;
  int badCounts;

  Wisata({
    required this.kategori,
    required this.nama,
    required this.deskripsi,
    required this.imageTitleUrl,
    required this.namaKota,
    this.isFavorite = false,
    this.rating = 0,
    this.views = 0,
    this.goodCounts = 0,
    this.badCounts = 0,
    this.isGood = false,
    this.isBad = false,
    this.imageUrls = const [],
  });
}
