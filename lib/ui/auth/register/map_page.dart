import 'dart:convert';
import 'dart:core';
import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geocoding/geocoding.dart';
import 'package:kangsayur_seller/bloc/bloc/register_bloc.dart';
import 'package:kangsayur_seller/bloc/state/register_state.dart';
import 'package:kangsayur_seller/model/register_model.dart';
import 'package:kangsayur_seller/ui/auth/register/sandi_register.dart';
import 'package:kangsayur_seller/ui/bottom_navigation/bottom_navigation.dart';
import 'package:kangsayur_seller/ui/bottom_navigation/item/dashboard.dart';
import 'package:location/location.dart' as loc;
import 'package:shared_preferences/shared_preferences.dart';
import '../../../Constants/app_constants.dart';
import 'package:latlong2/latlong.dart';
import 'package:http/http.dart' as http;
import '../../../bloc/bloc/device_token_bloc.dart';
import '../../../bloc/event/device_token_event.dart';
import '../../../bloc/event/register_event.dart';
import '../../../common/color_value.dart';
import '../../../firebase/firebase_messaging.dart';
import '../../../repository/device_token_repository.dart';
import '../../../repository/register_repository.dart';
import '../../widget/main_button.dart';
import 'package:image/image.dart' as img;


class MapScreen extends StatefulWidget {
  MapScreen({Key? key, required this.namaPemilik, required this.emailPemilik, required this.noHpPemilik, required this.alamatPemilik, required this.sandi, required this.namaToko, required this.alamatToko, required this.deskripsiToko, required this.jamBuka, required this.jamTutup, required this.image}) : super(key: key);
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
  File? image;

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {

  String? _currentAddress;
  LatLng _currentPosition = AppConstants.myLocation;
  final List<Marker> _markers = [];
  Marker? _currentMarker;
  TextEditingController _searchController = TextEditingController();
  List<String> _searchResults = [];


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

  Future<void> _searchMapboxAddress(String query) async {
    if (query.isEmpty) {
      setState(() {
        _searchResults.clear();
      });
      return;
    }

    const apiKey = AppConstants.mapBoxAccessToken;
    final apiUrl = 'https://api.mapbox.com/geocoding/v5/mapbox.places/$query.json?access_token=$apiKey';

    try {
      final response = await http.get(Uri.parse(apiUrl));
      final data = json.decode(response.body);

      final List<String> results = [];

      for (var feature in data['features']) {
        String address = feature['place_name'];
        results.add(address);
      }

      setState(() {
        _searchResults = results;
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> _selectAddress(String address) async {
    List<Location> locations = await locationFromAddress(address);
    setState(() {
      _currentPosition = LatLng(locations[0].latitude, locations[0].longitude);
      _currentAddress = address;
      _markers.clear();
      _markers.add(
        Marker(
          point: _currentPosition,
          builder: (context) => const Icon(
            Icons.location_pin,
            size: 50,
            color: ColorValue.primaryColor,
          ),
        ),
      );
    });
    mapController.move(_currentPosition, 14.0);
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
      timeString += (time.isNotEmpty) ? '$time, ' : '';
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

  Future<File> compressImage(File imageFile) async {
    final tempDir = await Directory.systemTemp.createTemp();
    final tempFilePath = '${tempDir.path}/${DateTime.now().millisecondsSinceEpoch}.jpg';

    img.Image? image = img.decodeImage(imageFile.readAsBytesSync());

    while (image!.length > 2 * 1024 * 1024) {
      image = img.copyResize(image, width: image.width ~/ 2, height: image.height ~/ 2);
    }

    final compressedImageFile = File(tempFilePath)
      ..writeAsBytesSync(img.encodeJpg(image, quality: 80));

    return compressedImageFile;
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getAddressFromLatLng();
    _getCurrentLocation();
    print(widget.image!.path.split('/').last);
    mapController = MapController(); // Initialize the mapController
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pinpoint Lokasi",
          style: TextStyle(color: Colors.black, fontSize: 18),),
        leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.pop(context)
        ),
        backgroundColor: Colors.white,
      ),
      body: BlocProvider(
        create: (context) => RegisterPageBloc(registerRepository: RegisterRepository()),
        child: BlocConsumer<RegisterPageBloc, RegisterPageState>(
          listener: (context, state) {},
          builder: (context, state){
            if(state is InitialRegisterPageState) {
              return buildInitailLayout(context);
            } else if(state is RegisterPageLoading) {
              return buildLoadingLayout(context);
            } else if(state is RegisterPageLoaded) {
              return buildLoadedLayout();
            } else if(state is RegisterPageError) {
              return buildInitailLayout(context);
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
      )
    );
  }

  Widget buildInitailLayout(BuildContext context) => Stack(
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
        top: 0,
        left: 0,
        right: 0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(8)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 5.0,
                    spreadRadius: 0.0,
                    offset: Offset(0.0, 1.0), // shadow direction: bottom right
                  )
                ],
              ),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Cari alamat...',
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  border: InputBorder.none,
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () {
                      _searchController.clear();
                      setState(() {
                        _searchResults.clear();
                      });
                    },
                  )
                ),
                onChanged: _searchMapboxAddress,
                //icon clear textfield
              ),
            ),
            if (_searchResults.isNotEmpty)
              // Tampilkan hasil pencarian alamat
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                height: 200,
                width: double.infinity,
                color: Colors.white,
                child: ListView.builder(
                  itemCount: _searchResults.length,
                  itemBuilder: (context, index) {
                    String address = _searchResults[index];
                    return ListTile(
                      title: Text(address),
                      onTap: () {
                        _searchController.text = address;
                        _selectAddress(address);
                        setState(() {
                          _searchResults.clear();
                        });
                      },
                    );
                  },
                ),
              ),
          ],
        ),
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
              main_button("Daftar", context, onPressed: () async {
                // String? deviceToken = await FirebaseNotificationManager.getToken();
                // print('Device Token: $deviceToken');
                File? selectedImage = await compressImage(widget.image!);

                BlocProvider.of<RegisterPageBloc>(context).add(RegisterButtonPressed(
                  email: convertToText(widget.emailPemilik),
                  password: convertToText(widget.sandi),
                  ownerName: convertToText(widget.namaPemilik),
                  phoneNumber: convertToText(widget.noHpPemilik),
                  ownerAddress: convertToText(widget.alamatPemilik),
                  storeName: convertToText(widget.namaToko),
                  description: convertToText(widget.deskripsiToko),
                  storeAddress: convertToText(widget.alamatToko),
                  storeLongitude: _currentPosition.longitude.toDouble().toString(),
                  storeLatitude: _currentPosition.latitude.toDouble().toString(),
                  open: convertToTimeString(widget.jamBuka).toString(),
                  close: convertToTimeString(widget.jamTutup).toString(),
                  photo: selectedImage,
                ));

                // if(deviceToken != null){
                //   BlocProvider(
                //     create: (context) => DeviceTokenPageBloc(deviceTokenPageRepository: DeviceTokenRepository())..add(SendDeviceToken(
                //       email: widget.emailPemilik.text,
                //       password: widget.sandi.text,
                //       deviceToken: deviceToken,
                //     )),
                //   );
                //   BlocProvider.of<RegisterPageBloc>(context).add(RegisterButtonPressed(
                //     email: convertToText(widget.emailPemilik),
                //     password: convertToText(widget.sandi),
                //     ownerName: convertToText(widget.namaPemilik),
                //     phoneNumber: convertToText(widget.noHpPemilik),
                //     ownerAddress: convertToText(widget.alamatPemilik),
                //     storeName: convertToText(widget.namaToko),
                //     description: convertToText(widget.deskripsiToko),
                //     storeAddress: convertToText(widget.alamatToko),
                //     storeLongitude: _currentPosition.longitude.toDouble().toString(),
                //     storeLatitude: _currentPosition.latitude.toDouble().toString(),
                //     open: convertToTimeString(widget.jamBuka).toString(),
                //     close: convertToTimeString(widget.jamTutup).toString(),
                //     photo: selectedImage,
                //   ));
                // }
              }),
            ],
          ),
        ),
      ),
    ],
  );

  Widget buildLoadingLayout(BuildContext context) => const Center(
    child: CircularProgressIndicator(),
  );

  Widget buildLoadedLayout() => Center(
    child: Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Selamat Datang',
            style: Theme.of(context).textTheme.headline5!.copyWith(
              fontWeight: FontWeight.bold,
              color: ColorValue.secondaryColor,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 30,
          ),
          Text(
            'Anda telah berhasil masuk',
            style: Theme.of(context).textTheme.subtitle1!.copyWith(
              fontWeight: FontWeight.w800,
              color: const Color(0xff1E1E1E),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 30,
          ),
          Container(
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const BottomNavigation()));
              },
              style: ElevatedButton.styleFrom(
                primary: ColorValue.primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
              ),
              child: Text(
                'Lanjutkan',
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
