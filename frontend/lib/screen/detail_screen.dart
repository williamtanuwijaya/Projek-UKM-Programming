import 'package:flutter/material.dart';

import '../models/wisata.dart';

class DetailScreen extends StatelessWidget {
  final Wisata wisata;
  const DetailScreen({super.key, required this.wisata});

  @override
  Widget build(BuildContext context) {
    final informationTextStyle = const TextStyle(
      fontSize: 16.0,
      fontWeight: FontWeight.bold,
    );

    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CircleAvatar(
                  backgroundColor: Colors.grey,
                  child: IconButton(
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                const FavoriteButton(),
              ],
            ),
            SizedBox(
              height: 150,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: wisata.imageUrls.map((url) {
                  return Padding(
                    padding: const EdgeInsets.all(10),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(url),
                    ),
                  );
                }).toList(),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 16.0),
              padding: const EdgeInsets.all(10),
              child: Text(
                wisata.nama,
                textAlign: TextAlign.left,
                style: const TextStyle(
                  fontSize: 24,
                  fontFamily: 'Staatliches',
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: Row(
                children: [
                  const Icon(
                    Icons.star_rounded,
                    color: Colors.yellow,
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  Text(
                    wisata.rating as String,
                    style: const TextStyle(
                      fontWeight: FontWeight.w300,
                      fontSize: 12,
                    ),
                  ),
                  const Text(
                    ' (255 Ulasan)',
                    style: TextStyle(
                      fontWeight: FontWeight.w300,
                      fontSize: 12,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 165),
                    child: const Text(
                      ' Tampilkan peta',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: Text(
                wisata.deskripsi,
                textAlign: TextAlign.justify,
                style: const TextStyle(fontSize: 16.0),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: const Row(
                children: [
                  Text(
                    'Baca Selengkapnya',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                      color: Colors.blue,
                    ),
                  ),
                  Icon(
                    Icons.arrow_drop_down_sharp,
                    color: Colors.blue,
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 16.0),
              padding: const EdgeInsets.all(10),
              child: const Text(
                'Penilaian',
                style: TextStyle(
                  fontSize: 24,
                  fontFamily: 'Staatliches',
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
            ),
            Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      const Column(
                        children: [
                          Text(
                            'Harga',
                            style: TextStyle(
                              fontSize: 24,
                              fontFamily: 'Staatliches',
                            ),
                          ),
                          Text(
                            'IDR 24.000',
                            style: TextStyle(
                              fontSize: 24,
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Staatliches',
                            ),
                          ),
                        ],
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 100),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: TextButton(
                            onPressed: () {},
                            style: TextButton.styleFrom(
                              backgroundColor: Colors.blue,
                            ),
                            child: const Column(
                              children: [
                                Text(
                                  'Pesan Sekarang',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Staatliches',
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class FavoriteButton extends StatefulWidget {
  const FavoriteButton({super.key});

  @override
  _FavoriteButtonState createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        isFavorite ? Icons.favorite : Icons.favorite_border,
        color: Colors.red,
      ),
      onPressed: () {
        setState(() {
          isFavorite = !isFavorite;
        });
      },
    );
  }
}
