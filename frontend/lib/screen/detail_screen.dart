import 'package:flutter/material.dart';

import '../models/wisata.dart';

class DetailScreen extends StatefulWidget {
  final Wisata wisata;
  const DetailScreen({super.key, required this.wisata});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  DateTime? _selectedDateKeberangkatan = DateTime.now();
  DateTime? _selectedDateKepulangan = DateTime.now();

  void setGood() {
    setState(() {
      if (!widget.wisata.isGood) {
        widget.wisata.goodCounts++;
      } else {
        widget.wisata.goodCounts--;
      }
      if (!widget.wisata.isGood && widget.wisata.isBad) {
        widget.wisata.badCounts--;
      }
      widget.wisata.isGood = !widget.wisata.isGood;
      widget.wisata.isBad = false;
    });
  }

  void setBad() {
    setState(() {
      if (!widget.wisata.isBad) {
        widget.wisata.badCounts++;
      } else {
        widget.wisata.badCounts--;
      }
      if (!widget.wisata.isBad && widget.wisata.isGood) {
        widget.wisata.goodCounts--;
      }
      widget.wisata.isBad = !widget.wisata.isBad;
      widget.wisata.isGood = false;
    });
  }

  void setFavorite() {
    setState(() {
      widget.wisata.isFavorite = !widget.wisata.isFavorite;
    });
  }

  Future<void> _selectDate(BuildContext context, bool isKeberangkatan,
      void Function(void Function()) setState) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: isKeberangkatan
          ? _selectedDateKeberangkatan ?? DateTime.now()
          : _selectedDateKepulangan ?? DateTime.now(),
      firstDate: DateTime(DateTime.now().year),
      lastDate: DateTime(DateTime.now().year + 1),
    );

    if (isKeberangkatan) {
      if (picked != null && picked != _selectedDateKeberangkatan) {
        setState(() {
          _selectedDateKeberangkatan = picked;
          if (_selectedDateKeberangkatan!.isAfter(_selectedDateKepulangan!)) {
            _selectedDateKepulangan = _selectedDateKeberangkatan;
          }
        });
      }
    } else {
      if (picked != null && picked != _selectedDateKepulangan) {
        setState(() {
          _selectedDateKepulangan = picked;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1F8FF),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
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
                      const SizedBox(width: 10),
                      const Text(
                        'Kembali',
                        style: TextStyle(fontSize: 20),
                      ),
                    ],
                  ),
                  IconButton(
                    icon: Icon(
                      widget.wisata.isFavorite
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color: Colors.red,
                    ),
                    onPressed: () {
                      setState(() {
                        setFavorite();
                      });
                    },
                  ),
                ],
              ),
              SizedBox(
                height: 150,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: widget.wisata.imageUrls.map((url) {
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
                  widget.wisata.nama,
                  textAlign: TextAlign.left,
                  style: const TextStyle(
                    fontSize: 24, fontWeight: FontWeight.bold,
                    // fontFamily: 'Staatliches',
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
                      widget.wisata.rating.toString(),
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
                  widget.wisata.deskripsi,
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
                    fontSize: 24, fontWeight: FontWeight.bold,
                    // fontFamily: 'Staatliches',
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Column(
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.amber,
                            ),
                            SizedBox(width: 10),
                            Text('pengguna.nama'),
                          ],
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Row(
                          children: [
                            Column(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    setGood();
                                  },
                                  icon: Icon(widget.wisata.isGood
                                      ? Icons.thumb_up
                                      : Icons.thumb_up_outlined),
                                ),
                                Text(widget.wisata.goodCounts.toString()),
                              ],
                            ),
                            Column(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    setBad();
                                  },
                                  icon: Icon(widget.wisata.isBad
                                      ? Icons.thumb_down
                                      : Icons.thumb_down_outlined),
                                ),
                                Text(widget.wisata.badCounts.toString()),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          children: [
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Harga',
                        style: TextStyle(
                          fontSize: 16,
                          // fontFamily: 'Staatliches',
                        ),
                      ),
                      Text(
                        'IDR 24.000',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                          // fontFamily: 'Staatliches',
                        ),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return BottomSheet(
                            onClosing: () {},
                            builder: (context) {
                              return StatefulBuilder(
                                builder: (context, setState) {
                                  return Container(
                                    height: 600,
                                    width: double.infinity,
                                    padding: const EdgeInsets.all(20),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Text(
                                              'Pilih Tanggal',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 24,
                                              ),
                                            ),
                                            const SizedBox(height: 20),
                                            const Text(
                                              'Tanggal Keberangkatan',
                                              style: TextStyle(fontSize: 18),
                                            ),
                                            Container(
                                              padding: const EdgeInsets.all(20),
                                              decoration: BoxDecoration(
                                                border: Border.all(width: 1),
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  InkWell(
                                                    onTap: () {
                                                      _selectDate(context, true,
                                                          setState);
                                                    },
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: <Widget>[
                                                        const Icon(Icons
                                                            .calendar_today),
                                                        const SizedBox(
                                                            width: 12),
                                                        Text(
                                                          _selectedDateKeberangkatan !=
                                                                  null
                                                              ? "${_selectedDateKeberangkatan!.toLocal()}"
                                                                  .split(' ')[0]
                                                              : "Pilih Tanggal",
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            const SizedBox(height: 20),
                                            const Text(
                                              'Tanggal Kepulangan',
                                              style: TextStyle(fontSize: 18),
                                            ),
                                            Container(
                                              padding: const EdgeInsets.all(20),
                                              decoration: BoxDecoration(
                                                border: Border.all(width: 1),
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  InkWell(
                                                    onTap: () => _selectDate(
                                                        context,
                                                        false,
                                                        setState),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: <Widget>[
                                                        const Icon(Icons
                                                            .calendar_today),
                                                        const SizedBox(
                                                            width: 12),
                                                        Text(
                                                          _selectedDateKepulangan !=
                                                                  null
                                                              ? "${_selectedDateKepulangan!.toLocal()}"
                                                                  .split(' ')[0]
                                                              : "Pilih Tanggal",
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'Harga',
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    // fontFamily: 'Staatliches',
                                                  ),
                                                ),
                                                Text(
                                                  'IDR 24.000',
                                                  style: TextStyle(
                                                    fontSize: 20,
                                                    color: Colors.green,
                                                    fontWeight: FontWeight.bold,
                                                    // fontFamily: 'Staatliches',
                                                  ),
                                                ),
                                              ],
                                            ),
                                            GestureDetector(
                                              onTap: () {},
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 20,
                                                        vertical: 10),
                                                decoration: BoxDecoration(
                                                  color: Colors.blue,
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                ),
                                                child: const Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          'Pesan',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                        Text(
                                                          'Sekarang',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(width: 20),
                                                    Icon(
                                                      Icons.arrow_forward,
                                                      color: Colors.white,
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              );
                            },
                          );
                        },
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Pesan',
                                style: TextStyle(color: Colors.white),
                              ),
                              Text(
                                'Sekarang',
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                          SizedBox(width: 20),
                          Icon(
                            Icons.arrow_forward,
                            color: Colors.white,
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
