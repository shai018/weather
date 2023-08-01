import 'package:geolocator/geolocator.dart';

getlocation() async {
  bool isServiceEnabled;
  LocationPermission locationPermission;

  isServiceEnabled = await Geolocator.isLocationServiceEnabled();
  //return if service is not enabled
  if (!isServiceEnabled) {
    return Future.error("location not enabled");
  }
  //status of permission
  locationPermission = await Geolocator.checkPermission();

  if (locationPermission == LocationPermission.deniedForever) {
    return Future.error("location permission are denied forever");
  } else if (locationPermission == LocationPermission.denied) {
    //request permission
    locationPermission = await Geolocator.requestPermission();
    if (locationPermission == LocationPermission.denied) {
      return Future.error("location permission is denied");
    }
  }
}