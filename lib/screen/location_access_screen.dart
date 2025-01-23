// import 'package:flutter/material.dart';
// import 'package:location/location.dart';



// class LocationPage extends StatefulWidget {
//   @override
//   _LocationPageState createState() => _LocationPageState();
// }
//
// class _LocationPageState extends State<LocationPage> {
//   Location location = new Location();
//   bool? _serviceEnabled;
//   PermissionStatus? _permissionGranted;
//   LocationData? _locationData;
//
//   @override
//   void initState() {
//     super.initState();
//     _checkPermissions();  // Check location permissions on startup
//   }
//
//   Future<void> _checkPermissions() async {
//     // Check if the location service is enabled
//     _serviceEnabled = await location.serviceEnabled();
//     if (!_serviceEnabled!) {
//       // Request the user to enable the location service if it's disabled
//       _serviceEnabled = await location.requestService();
//       if (!_serviceEnabled!) {
//         // If the user denies enabling location services, exit the function
//         return;
//       }
//     }
//
//     // Check for location permission
//     _permissionGranted = await location.hasPermission();
//     if (_permissionGranted == PermissionStatus.denied) {
//       // Request permission if it's denied
//       _permissionGranted = await location.requestPermission();
//       if (_permissionGranted != PermissionStatus.granted) {
//         // If permission is still denied, exit the function
//         return;
//       }
//     }
//
//     // Fetch the location
//     _locationData = await location.getLocation();
//
//     // Navigate to the login page once the location is fetched
//     // Navigator.pushReplacement(
//     //   context,
//     //   MaterialPageRoute(builder: (context) => ()),
//     // );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//     /*  appBar: AppBar(title: Text("Location Permission")),
//       body: Center(
//         child: CircularProgressIndicator(),  // Display a loading indicator while checking permissions
//       ),*/
//     );
//   }
// }
//
//
