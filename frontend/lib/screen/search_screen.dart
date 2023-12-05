import 'package:flutter/material.dart';
import 'package:ukm_project/data/list_wisata.dart';
import 'package:ukm_project/models/wisata.dart';
import 'package:ukm_project/screen/detail_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _pencarianController = TextEditingController();

  late FocusNode _searchFocusNode = FocusNode();
  List<String> populer = [
    'Punti Kayu',
    'Pantai Nirwana',
    'Menara Pisa',
    'Batu Raja',
    'Raja Ampat'
  ];

  List<String> history = [];
  List<Wisata> _filteredWisata = [];

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      FocusScope.of(context).requestFocus(_searchFocusNode);
    });
  }

  @override
  void dispose() {
    _searchFocusNode.dispose();
    super.dispose();
  }

  void submit() {
    setState(() {
      _filteredWisata.clear();
      if (_pencarianController.text.isNotEmpty) {
        if (!history.contains(_pencarianController.text.trim())) {
          history.add(_pencarianController.text.toLowerCase());
          if (history.length > 10) {
            history.removeAt(0);
          }
        }
        for (var wisata in listWisata) {
          String lowercasedSearch =
              _pencarianController.text.toLowerCase().trim();
          final regex = RegExp(r'\b' + RegExp.escape(lowercasedSearch) + r'\b',
              caseSensitive: false);
          if (regex.hasMatch(wisata.nama.toLowerCase())) {
            if (!_filteredWisata.contains(wisata)) {
              _filteredWisata.add(wisata);
            }
          }
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1F8FF),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  focusNode: _searchFocusNode,
                  controller: _pencarianController,
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
                  onSubmitted: (value) {
                    submit();
                  },
                ),
                const SizedBox(height: 30),
                if (_pencarianController.text.isEmpty)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Riwayat',
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 20),
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  history.clear();
                                });
                              },
                              child: const Text('hapus'),
                            ),
                          ),
                        ],
                      ),
                      if (history.isNotEmpty)
                        Column(
                          children: [
                            SingleChildScrollView(
                              child: Wrap(
                                spacing: 8.0,
                                runSpacing: 8.0,
                                children:
                                    List.generate(history.length, (index) {
                                  return InkWell(
                                    onTap: () {
                                      setState(() {
                                        _pencarianController.text =
                                            history[history.length - 1 - index];
                                      });
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.all(4),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                      child: Text(
                                        history[history.length - 1 - index],
                                        style: const TextStyle(fontSize: 12),
                                      ),
                                    ),
                                  );
                                }),
                              ),
                            ),
                          ],
                        )
                      else
                        const Text('Tidak ada riwayat'),
                      const SizedBox(height: 20),
                      const Text(
                        'Populer',
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      SingleChildScrollView(
                        child: Wrap(
                          spacing: 8.0,
                          runSpacing: 8.0,
                          children: List.generate(populer.length, (index) {
                            return InkWell(
                              onTap: () {
                                setState(() {
                                  _pencarianController.text =
                                      populer[index].toLowerCase();
                                  history.add(populer[index].toLowerCase());
                                  if (history.length > 10) {
                                    history.removeAt(0);
                                  }
                                });
                              },
                              child: Container(
                                padding: const EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Text(
                                  populer[index],
                                  style: const TextStyle(fontSize: 12),
                                ),
                              ),
                            );
                          }),
                        ),
                      ),
                    ],
                  )
                // endif
                else
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GridView.builder(
                        shrinkWrap: true,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 1.1,
                          crossAxisSpacing: 10.0,
                          mainAxisSpacing: 5,
                        ),
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: _filteredWisata.length,
                        itemBuilder: (context, index) {
                          Wisata wisata = _filteredWisata[index];
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        DetailScreen(wisata: wisata),
                                  ));
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10)),
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
                                        errorBuilder:
                                            (context, error, stackTrace) =>
                                                Placeholder(),
                                      ),
                                    ),
                                  ),
                                  Text(
                                    wisata.nama,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Row(
                                    children: [
                                      Icon(
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
                      ),
                    ],
                  ),
                // endelse
              ],
            ),
          ),
        ),
      ),
    );
  }
}
