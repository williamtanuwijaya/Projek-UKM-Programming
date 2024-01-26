import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:location/location.dart';
import 'package:ukm_project/api/location_provider.dart';
import 'package:ukm_project/models/location_data.dart' as locationData;

class LoadLocation {
  locationData.LocationData currentLocation = locationData.LocationData(
      city: "Loading...",
      province: 'Loading...',
      latitude: 0.0,
      longitude: 0.0);
  Location location = Location();

  LoadLocation() {
    fetchLocationData();
  }

  Future<void> fetchLocationData() async {
    try {
      locationData.LocationData result = await getCurrentLocation();
      currentLocation = result;
      curLocation = currentLocation;
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

  locationData.LocationData getCurrentLocationData() {
    return currentLocation;
  }
}
