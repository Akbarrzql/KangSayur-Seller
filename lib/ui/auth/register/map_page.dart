import 'dart:convert';
import 'dart:core';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geocoding/geocoding.dart';
import 'package:kangsayur_seller/model/register_model.dart';
import 'package:kangsayur_seller/ui/auth/register/sandi_register.dart';
import 'package:kangsayur_seller/ui/bottom_navigation/bottom_navigation.dart';
import 'package:kangsayur_seller/ui/bottom_navigation/item/dashboard.dart';
import 'package:location/location.dart' as loc;
import 'package:shared_preferences/shared_preferences.dart';
import '../../../Constants/app_constants.dart';
import 'package:latlong2/latlong.dart';
import 'package:http/http.dart' as http;
import '../../../common/color_value.dart';
import '../../widget/main_button.dart';

class MapScreen extends StatefulWidget {
  MapScreen({Key? key, required this.namaPemilik, required this.emailPemilik, required this.noHpPemilik, required this.alamatPemilik, required this.sandi, required this.namaToko, required this.alamatToko, required this.deskripsiToko, required this.jamBuka, required this.jamTutup}) : super(key: key);
  final TextEditingController namaPemilik;
  final TextEditingController emailPemilik;
  final TextEditingController noHpPemilik;
  final TextEditingController alamatPemilik;
  final TextEditingController sandi;
  final TextEditingController namaToko;
  final TextEditingController deskripsiToko;
  final TextEditingController alamatToko;
  //jam buka tutup dari list operasioanl toko class
  List<TextEditingController> jamBuka = [];
  List<TextEditingController> jamTutup = [];

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {

  String? _currentAddress;
  LatLng _currentPosition = AppConstants.myLocation;
  final List<Marker> _markers = [];
  Marker? _currentMarker;

  var mapController = MapController();

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

    // Memindahkan peta ke lokasi pengguna atau marker
    mapController.move(_currentPosition, 14.0); // Sesuaikan level zoom jika perlu
  }

  // //list jam buka tutup
  // List<String> convertToTimeString(List<TextEditingController> controllers) {
  //   List<String> timeStrings = [];
  //   for (var controller in controllers) {
  //     String time = controller.text;
  //     time = time.replaceAll("┤", "").replaceAll("├", "");
  //     timeStrings.add(time);
  //   }
  //   return timeStrings;
  // }

  String convertToTimeString(List<TextEditingController> controllers) {
    String timeString = '';
    for (var controller in controllers) {
      String time = controller.text.replaceAll("┤", "").replaceAll("├", "");
      timeString += (time.isNotEmpty) ? time + ', ' : '';
    }
    if (timeString.isNotEmpty) {
      timeString = timeString.substring(0, timeString.length - 2);
    }
    return timeString;
  }


  String convertToText(TextEditingController controller) {
    String text = controller.text;
    text = text.replaceAll("┤", "").replaceAll("├", "");
    return text;
  }

  postRegister() async {

    var url = Uri.parse('https://kangsayur.nitipaja.online/api/auth/seller/register');
    var response = await http.post(url,
        headers: {
          'Accept': 'application/json',
        },body: {
          'email': convertToText(widget.emailPemilik),
          'password': convertToText(widget.sandi),
          'owner_name': convertToText(widget.namaPemilik),
          'phone_number': convertToText(widget.noHpPemilik),
          'owner_address': convertToText(widget.alamatPemilik),
          'store_name': convertToText(widget.namaToko),
          'description': convertToText(widget.deskripsiToko),
          'store_address': convertToText(widget.alamatToko),
          'store_longitude': _currentPosition.longitude.toDouble().toString(),
          'store_latitude': _currentPosition.latitude.toDouble().toString(),
          'open': convertToTimeString(widget.jamBuka).toString(),
          'close': convertToTimeString(widget.jamTutup).toString(),
        });


    print(response.body);
    print(response.statusCode);

    if(response.statusCode == 200) {
      RegisterModel register = registerModelFromJson(response.body);
      SharedPreferences pref = await SharedPreferences.getInstance();
      pref.setString('token', register.accesToken);
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const BottomNavigation()));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Gagal Register'),
        ),
      );
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getAddressFromLatLng();
    _getCurrentLocation();
    mapController = MapController(); // Initialize the mapController
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pinpoint Lokasi",
          style: TextStyle(color: Colors.black, fontSize: 18),),
        leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.pop(context)
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
            mapController: mapController,
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
                    postRegister();
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
