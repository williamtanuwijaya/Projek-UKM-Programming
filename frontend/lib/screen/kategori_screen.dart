import 'package:flutter/material.dart';
import 'package:ukm_project/api/location_provider.dart';
import 'package:ukm_project/data/list_wisata.dart';
import 'package:ukm_project/models/wisata.dart';
import 'package:ukm_project/screen/detail_screen.dart';
import 'package:ukm_project/screen/search_screen.dart';

class KategoriScreen extends StatefulWidget {
  final String kategori;

  const KategoriScreen({super.key, required this.kategori});

  @override
  State<KategoriScreen> createState() => _KategoriScreenState();
}

class _KategoriScreenState extends State<KategoriScreen> {
  List<Wisata> _listKategoriWisata = [];

  String selectedTombol = 'Terpopuler';

  @override
  void initState() {
    super.initState();
    fillListKategori(widget.kategori);
  }

  void fillListKategori(String kategori) {
    for (var wisata in listWisata) {
      if (wisata.kategori == kategori) {
        _listKategoriWisata.add(wisata);
      }
    }
  }

  String makeKategoriCamel() {
    var words = widget.kategori.split(' ');
    for (int i = 0; i < words.length; i++) {
      words[i] = words[i][0].toUpperCase() + words[i].substring(1);
    }
    return words.join(" ");
  }

  GridView makeGridItem() {
    List<Wisata> sortedListKategoriWisata = _listKategoriWisata;
    setState(() {
      sortedListKategoriWisata.sort((a, b) => b.views.compareTo(a.views));
    });
    if (selectedTombol == 'Terpopuler') {
      return GridView.builder(
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1.1,
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 5,
        ),
        itemCount: sortedListKategoriWisata.length,
        itemBuilder: (context, index) {
          final Wisata wisata = sortedListKategoriWisata[index];
          return InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailScreen(wisata: wisata),
                  ));
            },
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(10)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      height: 120,
                      width: 200,
                      child: Image.network(
                        wisata.imageTitleUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            const Placeholder(),
                      ),
                    ),
                  ),
                  Text(
                    wisata.nama,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.star,
                        color: Colors.yellow,
                      ),
                      Text(wisata.rating.toString()),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      );
    } else if (selectedTombol == 'Terdekat') {
      return GridView.builder(
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1.1,
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 5,
        ),
        itemCount: _listKategoriWisata.length,
        itemBuilder: (context, index) {
          final Wisata wisata = _listKategoriWisata[index];
          if (wisata.namaKota == getCurLocation().city) {
            return InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailScreen(wisata: wisata),
                    ));
              },
              child: Container(
                decoration: const BoxDecoration(color: Colors.white),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        height: 120,
                        width: 200,
                        child: Image.network(
                          wisata.imageTitleUrl,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              const Placeholder(),
                        ),
                      ),
                    ),
                    Text(
                      wisata.nama,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.star,
                          color: Colors.yellow,
                        ),
                        Text(wisata.rating.toString()),
                      ],
                    ),
                  ],
                ),
              ),
            );
          }
        },
      );
    } else if (selectedTombol == 'Terlaris') {
      return GridView.builder(
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1.1,
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 5,
        ),
        itemCount: _listKategoriWisata.length,
        itemBuilder: (context, index) {
          final Wisata wisata = _listKategoriWisata[index];
          return InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailScreen(wisata: wisata),
                  ));
            },
            child: Container(
              decoration: const BoxDecoration(color: Colors.white),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      height: 120,
                      width: 200,
                      child: Image.network(
                        wisata.imageTitleUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            const Placeholder(),
                      ),
                    ),
                  ),
                  Text(
                    wisata.nama,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.star,
                        color: Colors.yellow,
                      ),
                      Text(wisata.rating.toString()),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      );
    } else {
      List<Wisata> _sortedListKategoriWisata = _listKategoriWisata;
      setState(() {
        _sortedListKategoriWisata.sort((a, b) => b.rating.compareTo(a.rating));
      });
      return GridView.builder(
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1.1,
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 5,
        ),
        itemCount: _sortedListKategoriWisata.length,
        itemBuilder: (context, index) {
          final Wisata wisata = _sortedListKategoriWisata[index];
          return InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailScreen(wisata: wisata),
                  ));
            },
            child: Container(
              decoration: const BoxDecoration(color: Colors.white),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      height: 120,
                      width: 200,
                      child: Image.network(
                        wisata.imageTitleUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            const Placeholder(),
                      ),
                    ),
                  ),
                  Text(
                    wisata.nama,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.star,
                        color: Colors.yellow,
                      ),
                      Text(wisata.rating.toString()),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      );
    }
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  readOnly: true,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color(0xFF3980D1),
                    prefixIcon: const Icon(
                      Icons.search,
                      color: Colors.white,
                    ),
                    hintText: 'Mencari...',
                    hintStyle: const TextStyle(
                      color: Colors.white,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SearchScreen(),
                        ));
                  },
                ),
                Text(
                  makeKategoriCamel(),
                  style: const TextStyle(
                      fontSize: 28, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    for (var tombol in [
                      'Terpopuler',
                      'Terdekat',
                      'Terlaris',
                      'Terbaik'
                    ])
                      TombolSort(
                        namaTombol: tombol,
                        isSelected: selectedTombol == tombol,
                        onTap: () {
                          setState(() {
                            selectedTombol = tombol;
                          });
                        },
                      ),
                  ],
                ),
                const SizedBox(height: 10),
                Column(
                  children: [
                    makeGridItem(),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class TombolSort extends StatelessWidget {
  final String namaTombol;
  final bool isSelected;
  final VoidCallback onTap;

  TombolSort(
      {super.key,
      required this.namaTombol,
      required this.isSelected,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: isSelected ? const Color(0x15176FF2) : Colors.transparent,
        ),
        child: Text(
          namaTombol,
          style: TextStyle(
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              color: isSelected
                  ? const Color(0xFF176FF2)
                  : const Color(0xFFB8B8B8)),
        ),
      ),
    );
  }
}
