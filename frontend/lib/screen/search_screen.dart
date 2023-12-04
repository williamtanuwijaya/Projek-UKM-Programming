import 'package:flutter/material.dart';

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
                    setState(() {
                      if (_pencarianController.text.isNotEmpty) {
                        if (!history.contains(_pencarianController.text)) {
                          history.add(value);
                        }
                      }
                      if (history.length > 10) {
                        history.removeAt(0);
                      }
                    });
                  },
                ),
                SizedBox(height: 30),
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
                                    onTap: () {},
                                    child: Container(
                                      padding: EdgeInsets.all(4),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                      child: Text(
                                        history[history.length - 1 - index],
                                        style: TextStyle(fontSize: 12),
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
                              onTap: () {},
                              child: Container(
                                padding: EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Text(
                                  populer[index],
                                  style: TextStyle(fontSize: 12),
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
                  Placeholder(),
                // endelse
              ],
            ),
          ),
        ),
      ),
    );
  }
}
