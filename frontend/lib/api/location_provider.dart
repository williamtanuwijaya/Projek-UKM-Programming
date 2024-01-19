import 'package:ukm_project/api/load_location.dart';
import 'package:ukm_project/models/location_data.dart' as locationData;

locationData.LocationData curLocation = locationData.LocationData(
    city: "Loading...", province: 'Loading...', latitude: 0.0, longitude: 0.0);

locationData.LocationData getCurLocation() {
  LoadLocation();
  return curLocation;
}
