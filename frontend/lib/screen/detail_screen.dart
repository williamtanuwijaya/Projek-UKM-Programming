import 'package:flutter/material.dart';
import 'package:ukm_project/models/wisata.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';


class DetailScreen extends StatelessWidget {
  final Wisata wisata;

  DetailScreen({super.key, required this.wisata}) {
    wisata.views++;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Align(
          alignment: AlignmentDirectional(-1.00, 0),
          child: Text(
            'Kembali',
            textAlign: TextAlign.start,
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        leading: const Icon(
          Icons.arrow_back_rounded,
          color: Color(0xFF0F1113),
          size: 30,
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.favorite,
              color: Colors.red,
              size: 30,
            ),
            onPressed: () {
              print('Favorite pressed ...');
            },
          ),
          IconButton(
            icon: const Icon(
              Icons.import_export,
              color: Colors.black,
              size: 30,
            ),
            onPressed: () {
              print('Export pressed ...');
            },
          ),
        ],
      ),
      body: Container(
        height: double.infinity,
        color: const Color.fromARGB(255, 242, 247, 253),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(12, 12, 12, 12),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Hero(
                      tag: 'locationImage',
                      transitionOnUserGestures: true,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          wisata.imageTitleUrl,
                          width: double.infinity,
                          height: 250,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const Row(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
                          child: Text(
                            wisata.nama,
                            style: TextStyle(
                              fontFamily: 'Outfit',
                              color: Color(0xFF0F1113),
                              fontSize: 32,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Align(
                            alignment: AlignmentDirectional(1.00, 0.00),
                            child: Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 25, 0, 0),
                              child: Text(
                                'Tampilkan Peta',
                                style: TextStyle(
                                  fontFamily: 'Readex Pro',
                                  color: Colors.amber,
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    const Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Icon(
                            Icons.star_rounded,
                            color: Colors.yellow,
                            size: 24,
                          ),
                          Text(
                            '${wisata.rating} (${wisata.views} Ulasan)',
                            style: TextStyle(
                              fontFamily: 'Plus Jakarta Sans',
                              color: Color(0xFF0F1113),
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(4, 4, 0, 0),
                      child: Text(
                        wisata.deskripsi,
                        style: TextStyle(
                          fontFamily: 'Plus Jakarta Sans',
                          color: Color(0xFF0F1113),
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        const Text(
                          'Baca selengkapnya',
                          style: TextStyle(
                            fontFamily: 'Readex Pro',
                            color: Colors.amber,
                          ),
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.keyboard_arrow_down,
                            color: Colors.amber,
                            size: 20,
                          ),
                          onPressed: () {
                            print('IconButton pressed ...');
                          },
                        ),
                      ],
                    ),
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          const Align(
                            alignment: AlignmentDirectional.topStart,
                            child: Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
                              child: Text(
                                'Penilaian',
                                style: TextStyle(
                                  fontFamily: 'Readex Pro',
                                  color: Colors.amber,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Container(
                                width: 60,
                                height: 60,
                                clipBehavior: Clip.antiAlias,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                ),
                                child: Image.asset(
                                  'images/maren.png',
                                  fit: BoxFit.cover,
                                ),
                              ),
                              const Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(20, 0, 0, 0),
                                child: Text(
                                  'Maren Kenter',
                                  style: TextStyle(
                                    fontFamily: 'Readex Pro',
                                    color: Color(0xFF3683BE),
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Align(
                                  alignment:
                                      const AlignmentDirectional(1.00, 0.00),
                                  child: IconButton(
                                    icon: const Icon(
                                      Icons.thumb_up_outlined,
                                      color: Color(0xFF3683BE),
                                      size: 24,
                                    ),
                                    onPressed: () {
                                      print('IconButton pressed ...');
                                    },
                                  ),
                                ),
                              ),
                              IconButton(
                                icon: const Icon(
                                  Icons.thumb_down_outlined,
                                  color: Color(0xFF3683BE),
                                  size: 24,
                                ),
                                onPressed: () {
                                  print('IconButton pressed ...');
                                },
                              ),
                            ],
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Align(
                                alignment:
                                    const AlignmentDirectional(-1.00, 0.00),
                                child: Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      0, 5, 0, 0),
                                  child: RatingBarIndicator(
                                    itemBuilder: (context, index) => const Icon(
                                      Icons.star_rounded,
                                      color: Colors.yellow,
                                    ),
                                    direction: Axis.horizontal,
                                    rating: 5,
                                    unratedColor: const Color(0xFF95A1AC),
                                    itemCount: 5,
                                    itemSize: 20,
                                  ),
                                ),
                              ),
                              const Expanded(
                                child: Align(
                                  alignment: AlignmentDirectional(1.00, 0.00),
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        190, 0, 0, 0),
                                    child: Text(
                                      '12/12/2023',
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(5, 5, 0, 0),
                            child: Text(
                              'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus tempus nisi non velit euismod, a ultricies urna luctus. Sed sagittis velit a sem varius consectetur. Mauris sed felis eu ex pulvinar eleifend. Fusce at purus diam. Integer',
                              style: TextStyle(
                                fontFamily: 'Readex Pro',
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
