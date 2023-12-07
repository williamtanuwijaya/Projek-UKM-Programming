import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:location/location.dart';
import 'package:ukm_project/screen/kategori_screen.dart';
import 'package:ukm_project/screen/search_screen.dart';
import 'package:ukm_project/models/location_data.dart' as locationData;
import '../widgets/custom_navigation_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  locationData.LocationData currentLocation = locationData.LocationData(
      city: "Loading...",
      province: 'Loading...',
      latitude: 0.0,
      longitude: 0.0);
  Location location = Location();

  @override
  void initState() {
    super.initState();
    fetchLocationData();
  }

  Future<void> fetchLocationData() async {
    try {
      locationData.LocationData result = await getCurrentLocation();
      setState(() {
        currentLocation = result;
      });
    } catch (e) {
      print('Error fetching location data: $e');
    }
  }

  Future<locationData.LocationData> getCurrentLocation() async {
    try {
      var userLocation = await location.getLocation();
      double latitude = userLocation.latitude!;
      double longitude = userLocation.longitude!;
      return await getCityDataFromCoordinates(latitude, longitude);
    } catch (e) {
      print('Error getting current location: $e');
      return locationData.LocationData(
          city: "Unknown", province: 'Unknown', latitude: 0.0, longitude: 0.0);
    }
  }

  Future<locationData.LocationData> getCityDataFromCoordinates(
      double latitude, double longitude) async {
    final apiKey = '6c5ed6878672432b8604c7f112179000';
    final apiUrl =
        'https://api.opencagedata.com/geocode/v1/json?q=$latitude+$longitude&key=$apiKey';

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        if (data['results'] != null && data['results'].isNotEmpty) {
          final city = data['results'][0]['components']['city'];
          final province = data['results'][0]['components']['state'];
          final lat = data['results'][0]['geometry']['lat'];
          final lon = data['results'][0]['geometry']['lng'];

          return locationData.LocationData(
              city: city, province: province, latitude: lat, longitude: lon);
        }
      }
    } catch (e) {
      print('Error getting city data: $e');
    }

    return locationData.LocationData(
        city: "Unknown", province: 'Unknown', latitude: 0.0, longitude: 0.0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1F8FF),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, top: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const Icon(
                        Icons.location_on,
                        color: Colors.blue,
                      ),
                      Text(
                          '${currentLocation.city}, ${currentLocation.province}'),
                      const Icon(Icons.arrow_drop_down),
                    ],
                  ),
                ),
                const SizedBox(height: 2),
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
                const Text(
                  'Mau kemana hari ini?',
                  style: TextStyle(fontSize: 16),
                ),
                Text(
                  currentLocation.city,
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color(0xFFCCE3FD),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.grey,
                        offset: Offset(1, 3),
                        blurRadius: 4,
                        spreadRadius: 1,
                      )
                    ],
                  ),
                  child: Row(
                    children: [
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.wallet),
                                Text('TruPay'),
                              ],
                            ),
                            Text(
                              'Rp. 2.000.000',
                              style: TextStyle(fontSize: 20),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 3,
                        height: 45,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                InkWell(
                                  onTap: () {},
                                  child: const Column(
                                    children: [
                                      Icon(Icons.square),
                                      Text('Voucher'),
                                    ],
                                  ),
                                ),
                                InkWell(
                                  onTap: () {},
                                  child: const Column(
                                    children: [
                                      Icon(Icons.backpack),
                                      Text('Isi Ulang'),
                                    ],
                                  ),
                                ),
                                InkWell(
                                  onTap: () {},
                                  child: const Column(
                                    children: [
                                      Icon(Icons.qr_code),
                                      Text('Qris'),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: <Widget>[
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const KategoriScreen(
                                    kategori: 'wisata alam'),
                              ));
                        },
                        child: const SizedBox(
                          width: 90,
                          child: Column(
                            children: [
                              Icon(Icons.forest),
                              SizedBox(height: 8),
                              Text('Wisata Alam')
                            ],
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const KategoriScreen(kategori: 'wahana'),
                              ));
                        },
                        child: const SizedBox(
                          width: 90,
                          child: Column(
                            children: [
                              Icon(Icons.castle),
                              SizedBox(height: 8),
                              Text('Wahana')
                            ],
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const KategoriScreen(
                                    kategori: 'wisata air'),
                              ));
                        },
                        child: const SizedBox(
                          width: 90,
                          child: Column(
                            children: [
                              Icon(Icons.beach_access),
                              SizedBox(height: 8),
                              Text('Wisata air')
                            ],
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const KategoriScreen(kategori: 'budaya'),
                              ));
                        },
                        child: const SizedBox(
                          width: 90,
                          child: Column(
                            children: [
                              Icon(Icons.house),
                              SizedBox(height: 8),
                              Text('Budaya')
                            ],
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const KategoriScreen(kategori: 'hotel'),
                              ));
                        },
                        child: const SizedBox(
                          width: 90,
                          child: Column(
                            children: [
                              Icon(Icons.bed),
                              SizedBox(height: 8),
                              Text('Hotel')
                            ],
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const KategoriScreen(
                                    kategori: 'kebun binatang'),
                              ));
                        },
                        child: const SizedBox(
                          width: 90,
                          child: Column(
                            children: [
                              Icon(Icons.place),
                              SizedBox(height: 8),
                              Text('Zoo')
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                const Text(
                  'Populer',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () {},
                        child: Stack(
                          alignment: Alignment.bottomRight,
                          children: [
                            Stack(
                              alignment: Alignment.bottomLeft,
                              children: [
                                Stack(
                                  alignment: Alignment.bottomLeft,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: Container(
                                        width: 160,
                                        height: 200,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        child: Image.network(
                                          'https://cdn.pixabay.com/photo/2019/11/12/12/14/wood-bridge-4620943_960_720.jpg',
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(
                                          bottom: 50, left: 10),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 4),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: Colors.blue,
                                      ),
                                      child: const Text(
                                        'Palembang',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  margin: const EdgeInsets.only(
                                      bottom: 10, left: 10),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 4),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.blue,
                                  ),
                                  child: const Row(
                                    children: [
                                      Icon(
                                        Icons.star,
                                        color: Colors.yellow,
                                      ),
                                      Text(
                                        '4.1',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.favorite,
                                color: Colors.red,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 10),
                      InkWell(
                        onTap: () {},
                        child: Stack(
                          alignment: Alignment.bottomRight,
                          children: [
                            Stack(
                              alignment: Alignment.bottomLeft,
                              children: [
                                Stack(
                                  alignment: Alignment.bottomLeft,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: Container(
                                        width: 160,
                                        height: 200,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        child: Image.network(
                                          'https://cdn.pixabay.com/photo/2019/11/12/12/14/wood-bridge-4620943_960_720.jpg',
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(
                                          bottom: 50, left: 10),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 4),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: Colors.blue,
                                      ),
                                      child: const Text(
                                        'Palembang',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  margin: const EdgeInsets.only(
                                      bottom: 10, left: 10),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 4),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.blue,
                                  ),
                                  child: const Row(
                                    children: [
                                      Icon(
                                        Icons.star,
                                        color: Colors.yellow,
                                      ),
                                      Text(
                                        '4.1',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.favorite,
                                color: Colors.red,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 10),
                      InkWell(
                        onTap: () {},
                        child: Stack(
                          alignment: Alignment.bottomRight,
                          children: [
                            Stack(
                              alignment: Alignment.bottomLeft,
                              children: [
                                Stack(
                                  alignment: Alignment.bottomLeft,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: Container(
                                        width: 160,
                                        height: 200,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        child: Image.network(
                                          'https://cdn.pixabay.com/photo/2019/11/12/12/14/wood-bridge-4620943_960_720.jpg',
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(
                                          bottom: 50, left: 10),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 4),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: Colors.blue,
                                      ),
                                      child: const Text(
                                        'Palembang',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  margin: const EdgeInsets.only(
                                      bottom: 10, left: 10),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 4),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.blue,
                                  ),
                                  child: const Row(
                                    children: [
                                      Icon(
                                        Icons.star,
                                        color: Colors.yellow,
                                      ),
                                      Text(
                                        '4.1',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.favorite,
                                color: Colors.red,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 10),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Rekomendasi',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () {},
                        child: Stack(
                          alignment: Alignment.bottomRight,
                          children: [
                            Stack(
                              alignment: Alignment.bottomLeft,
                              children: [
                                Stack(
                                  alignment: Alignment.bottomLeft,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: Container(
                                        width: 160,
                                        height: 200,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        child: Image.network(
                                          'https://cdn.pixabay.com/photo/2019/11/12/12/14/wood-bridge-4620943_960_720.jpg',
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(
                                          bottom: 50, left: 10),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 4),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: Colors.blue,
                                      ),
                                      child: const Text(
                                        'Palembang',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  margin: const EdgeInsets.only(
                                      bottom: 10, left: 10),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 4),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.blue,
                                  ),
                                  child: const Row(
                                    children: [
                                      Icon(
                                        Icons.star,
                                        color: Colors.yellow,
                                      ),
                                      Text(
                                        '4.1',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.favorite,
                                color: Colors.red,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 10),
                      InkWell(
                        onTap: () {},
                        child: Stack(
                          alignment: Alignment.bottomRight,
                          children: [
                            Stack(
                              alignment: Alignment.bottomLeft,
                              children: [
                                Stack(
                                  alignment: Alignment.bottomLeft,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: Container(
                                        width: 160,
                                        height: 200,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        child: Image.network(
                                          'https://cdn.pixabay.com/photo/2019/11/12/12/14/wood-bridge-4620943_960_720.jpg',
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(
                                          bottom: 50, left: 10),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 4),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: Colors.blue,
                                      ),
                                      child: const Text(
                                        'Palembang',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  margin: const EdgeInsets.only(
                                      bottom: 10, left: 10),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 4),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.blue,
                                  ),
                                  child: const Row(
                                    children: [
                                      Icon(
                                        Icons.star,
                                        color: Colors.yellow,
                                      ),
                                      Text(
                                        '4.1',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.favorite,
                                color: Colors.red,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 10),
                    ],
                  ),
                ),
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
