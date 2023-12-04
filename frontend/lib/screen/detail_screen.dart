import 'package:flutter/material.dart';
import 'package:ukm_project/models/wisata.dart';

class DetailScreen extends StatelessWidget {
  final Wisata wisata;

  const DetailScreen({super.key, required this.wisata});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.network(wisata.imageTitleUrl),
            Text(wisata.nama),
          ],
        ),
      ),
    );
  }
}
