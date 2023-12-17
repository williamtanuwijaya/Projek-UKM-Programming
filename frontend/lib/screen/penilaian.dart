import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class PenilaianScreen extends StatefulWidget {
  const PenilaianScreen({super.key});

  @override
  State<PenilaianScreen> createState() => _PenilaianScreenState();
}

class _PenilaianScreenState extends State<PenilaianScreen> {
  double rating = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1F8FF),
      body: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(20, 20, 20, 20),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                CircleAvatar(
                  backgroundColor: Colors.white,
                  child: IconButton(
                    icon: const Icon(
                      Icons.arrow_back_ios_new_rounded,
                      color: Color(0xFF49A2F4),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                const Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(20, 0, 0, 0),
                  child: Text(
                    'Beri Penilaian',
                    style: TextStyle(
                      fontFamily: 'fonts/Inter-Black.ttf',
                      color: Color(0xFF1284EE),
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(0, 50, 0, 0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  const Text(
                    'Bagaimana WisataMu?',
                    style: TextStyle(
                      fontFamily: 'fonts/Inter-Black.ttf',
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 27,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                    child: Text(
                      'Berikan Penilaian mu dengan klik \nbintang dibawah ini',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'fonts/Inter-Black.ttf',
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                    child: RatingBar.builder(
                      minRating: 1,
                      onRatingUpdate: (rating) =>
                          setState(() => this.rating = rating),
                      itemBuilder: (context, index) => Icon(
                        Icons.star_rounded,
                        color: Colors.yellow.shade600,
                      ),
                      updateOnDrag: true,
                      direction: Axis.horizontal,
                      itemCount: 5,
                      itemSize: 55,
                      glowColor: Colors.yellow.shade600,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
              child: Container(
                width: 400,
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: const Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: AlignmentDirectional(-1.00, -1.00),
                        child: Icon(
                          Icons.edit,
                          color: Colors.grey,
                          size: 24,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(5, 3, 0, 0),
                        child: Text(
                          'Beritahu kami tentang pengalaman anda',
                          style: TextStyle(
                            fontFamily: 'fonts/Inter-Black.ttf',
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(0, 40, 0, 0),
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  fixedSize: const Size(340, 60),
                  padding: const EdgeInsetsDirectional.fromSTEB(97, 0, 97, 0),
                  textStyle: const TextStyle(
                    fontSize: 15,
                    fontFamily: 'fonts/Inter-Bold.ttf',
                  ),
                  backgroundColor: Colors.blue.shade400,
                  foregroundColor: Colors.white,
                ),
                child: const Text("Beri Ulasan Sekarang"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
