import 'package:flutter/material.dart';
import 'package:ukm_project/widgets/custom_navigation_bar.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  int _selectedIndex = 2;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFFF1F8FF),
        bottomNavigationBar: CustomNavigationBar(
          onItemSelected: (index) {
            _selectedIndex = index;
          },
          selectedIndex: _selectedIndex,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // TODO: 1. Buat tulisan Tiket
            const Padding(
              padding: EdgeInsets.all(20.0),
              child: Text(
                  'Tiket',
                  style: TextStyle(
                    color: Colors.orangeAccent,
                    fontSize: 30
                  )
              ),
            ),

            // TODO: 2. Buat kotak destinasi
            Padding(
              padding: const EdgeInsets.only(
                right: 20.0,
                bottom: 20.0,
                left: 20.0
              ),
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      spreadRadius: 2,
                      blurRadius: 3,
                      offset: Offset(0, 5)
                    )
                  ]
                ),
                child: const Row(
                  children: [
                    SizedBox(height: 50,),

                    Text('Punti Kayu')
                  ],
                ),
              ),
            ),

            // TODO: 3. Buat Stack Keterangan
            Stack(
              children: [

                // TODO: 4. Buat 3 kotak biru di belakang
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      height: 80,
                      color: const Color(0xFF4280BD),
                    ),

                    const SizedBox(height: 15),

                    Container(
                      height: 40,
                      color: const Color(0xFF4280BD),
                    ),

                    const SizedBox(height: 15),

                    Container(
                      height: 200,
                      color: const Color(0xFF4280BD),
                    ),
                  ],
                ),

                Column(
                  children: [
                    // TODO: 5. Kotak tanggal
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 10.0,
                          right: 20.0,
                          bottom: 10.0,
                          left: 20.0
                      ),
                      child: Container(
                        height: 60,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                        ),
                        child: const Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.all(12.0),
                              child: Icon(
                                  Icons.calendar_month_rounded,
                                  color: Color(0xFF4280BD)
                              ),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('Tanggal'),
                                  Text('26 Juni 2000')
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(12.0),
                              child: Icon(
                                  Icons.edit_calendar_rounded,
                                  color: Color(0xFF4280BD)
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    // TODO 6: Voucher
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 20.0,
                          right: 20.0,
                          bottom: 10.0,
                          left: 20.0
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Expanded(
                            flex: 3,
                            child: Text(
                                'Voucher',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold
                                ),
                            ),
                          ),

                          Expanded(
                            flex: 2,
                            child: Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10)
                              ),
                              child: Text('Test'),
                            ),
                          )
                        ],
                      ),
                    ),

                    // TODO 7: Jumlah Orang
                    Padding(
                        padding: const EdgeInsets.only(
                          left: 20,
                          bottom: 0,
                          right: 20,
                          top: 15
                        ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                              'Jumlah Orang',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold
                              ),
                          ),

                          const SizedBox(height: 5),

                          Container(
                            height: 60,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(Radius.circular(15)),
                            ),
                            child: const Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(12.0),
                                  child: Icon(
                                      Icons.calendar_month_rounded,
                                      color: Color(0xFF4280BD)
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text('Tanggal'),
                                      Text('26 Juni 2000')
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(12.0),
                                  child: Icon(
                                      Icons.edit_calendar_rounded,
                                      color: Color(0xFF4280BD)
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 10),

                          Container(
                            height: 60,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(Radius.circular(15)),
                            ),
                            child: const Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(12.0),
                                  child: Icon(
                                      Icons.calendar_month_rounded,
                                      color: Color(0xFF4280BD)
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text('Tanggal'),
                                      Text('26 Juni 2000')
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(12.0),
                                  child: Icon(
                                      Icons.edit_calendar_rounded,
                                      color: Color(0xFF4280BD)
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    )

                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
