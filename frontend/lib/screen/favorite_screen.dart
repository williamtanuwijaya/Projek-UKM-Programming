import 'package:flutter/material.dart';
import 'package:ukm_project/data/list_wisata.dart';
import 'package:ukm_project/models/wisata.dart';
import 'package:ukm_project/screen/detail_screen.dart';
import 'package:ukm_project/widgets/custom_navigation_bar.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  int _selectedIndex = 1;
  List<Wisata> _favoriteList = [];

  @override
  void initState() {
    super.initState();
    fillFavoriteList();
  }

  void fillFavoriteList() {
    for (var wisata in listWisata) {
      if (wisata.isFavorite) {
        _favoriteList.add(wisata);
      }
    }
  }

  GridView makeGridItem() {
    return GridView.builder(
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1.1,
        crossAxisSpacing: 10.0,
        mainAxisSpacing: 5,
      ),
      itemCount: _favoriteList.length,
      itemBuilder: (context, index) {
        final Wisata wisata = _favoriteList[index];
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorite'),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              children: [
                makeGridItem(),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: CustomNavigationBar(
        onItemSelected: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        selectedIndex: _selectedIndex,
      ),
    );
  }
}
