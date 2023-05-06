import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geocoding/geocoding.dart';
import 'package:kangsayur_seller/ui/auth/register/sandi_register.dart';
import 'package:kangsayur_seller/ui/bottom_navigation/bottom_navigation.dart';
import 'package:kangsayur_seller/ui/bottom_navigation/item/dashboard.dart';
import 'package:location/location.dart' as loc;
import '../../../Constants/app_constants.dart';
import 'package:latlong2/latlong.dart';

import '../../../common/color_value.dart';
import '../../widget/main_button.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {

  String? _currentAddress;
  LatLng _currentPosition = AppConstants.myLocation;
  final List<Marker> _markers = [];
  Marker? _currentMarker;

  void _handleTap(tapPosition, LatLng tappedPoint) async {
    _currentPosition = tappedPoint;
    setState(() {
      _markers.clear();
      _markers.add(
        Marker(
          point: tappedPoint,
          builder: (context) => const Icon(
            Icons.location_pin,
            size: 50,
            color: ColorValue.primaryColor,
          ),
        ),
      );
    });

    // Mendapatkan alamat berdasarkan koordinat marker
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
          _currentPosition.latitude, _currentPosition.longitude);

      if (placemarks.isNotEmpty) {
        Placemark currentPlacemark = placemarks[0];
        String formattedAddress =
            "${currentPlacemark.street}, ${currentPlacemark.locality}, ${currentPlacemark.administrativeArea} ${currentPlacemark.postalCode}, ${currentPlacemark.country}";
        setState(() {
          _currentAddress = formattedAddress;
        });
      }
    } catch (e) {
      print(e);
    }
  }


  void _getAddressFromLatLng() async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(_currentPosition.latitude, _currentPosition.longitude);

      if (placemarks.isNotEmpty) {
        Placemark currentPlacemark = placemarks[0];
        String formattedAddress = "${currentPlacemark.street}, ${currentPlacemark.locality}, ${currentPlacemark.administrativeArea} ${currentPlacemark.postalCode}, ${currentPlacemark.country}";
        setState(() {
          _currentAddress = formattedAddress;
        });
      }
    } catch (e) {
      print(e);
    }
  }

  void _getCurrentLocation() async {
    final location = loc.Location();
    bool serviceEnabled;
    loc.PermissionStatus permissionGranted;
    loc.LocationData locationData;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == loc.PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != loc.PermissionStatus.granted) {
        return;
      }
    }

    locationData = await location.getLocation();
    setState(() {
      _currentPosition = LatLng(locationData.latitude!, locationData.longitude!);
    });
    _getAddressFromLatLng();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getAddressFromLatLng();
    _getCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pinpoint Lokasi",
          style: TextStyle(color: Colors.black, fontSize: 18),),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => KataSandiRegister()),
                  (Route<dynamic> route) => false),
        ),
        backgroundColor: Colors.white,
      ),
      body: Stack(
        children: [
          FlutterMap(
            options: MapOptions(
              center: AppConstants.myLocation,
              zoom: 14.0,
              onTap: _handleTap,
            ),
            children: [
              TileLayer(
                urlTemplate: AppConstants.mapBoxStyleId,
                additionalOptions: const {
                  'accessToken': AppConstants.mapBoxAccessToken,
                  'id': 'mapbox.mapbox-streets-v8',
                  'mapStyleId': AppConstants.mapBoxStyleId
                },
              ),
              MarkerLayer(
                markers: [
                  Marker(
                  width: 80.0,
                    height: 80.0,
                    point: _currentPosition,
                    builder: (ctx) => const Icon(
                      Icons.location_pin,
                      size: 50,
                      color: ColorValue.primaryColor,
                    ),
                  ),
                ],
              )
            ],
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(16.0),
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Alamat: $_currentAddress',
                    style: Theme.of(context).textTheme.subtitle1!.copyWith(
                      fontWeight: FontWeight.w800,
                      color: ColorValue.neutralColor,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Latitude: ${_currentPosition.latitude.toStringAsFixed(6)}',
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Longitude: ${_currentPosition.longitude.toStringAsFixed(6)}',
                  ),
                  const SizedBox(height: 15),
                  main_button("Daftar", context, onPressed: (){
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (context) => BottomNavigation()),
                            (Route<dynamic> route) => false);
                  }),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
