import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';

import '../../providers/check_out_provider.dart';

class LocationScreen extends StatefulWidget {
  LocationScreen({Key? key}) : super(key: key);

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  late LatLng initialCameraLocation = LatLng(20.5937, 78.9629);
  late GoogleMapController googleMapController;
  Location _location = Location();
  late LocationData setLocation;
  late CheckoutProvider checkoutProvider;

  void onMapCreated(GoogleMapController controller) {
    googleMapController = controller;
    _location.onLocationChanged.listen((event) {
      googleMapController.animateCamera(CameraUpdate.newCameraPosition(
          CameraPosition(
              target: LatLng(event.latitude!, event.longitude!), zoom: 15)));
    });
  }

  @override
  Widget build(BuildContext context) {
    CheckoutProvider checkoutProvider = Provider.of<CheckoutProvider>(context);

    return Scaffold(
        body: SafeArea(
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            GoogleMap(
              initialCameraPosition:
                  CameraPosition(target: initialCameraLocation, zoom: 15),
              myLocationButtonEnabled: true,
              onMapCreated: onMapCreated,
              myLocationEnabled: true,
              mapType: MapType.normal,
              mapToolbarEnabled: true,
              zoomControlsEnabled: true,
              minMaxZoomPreference: MinMaxZoomPreference(1.5, 20.8),
              // onCameraMove: (CameraPosition position) {
              //   _locationProvider.onCameraMove(position);
              // },
            ),
            Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: 50,
                  width: double.infinity,
                  margin:
                      EdgeInsets.only(right: 80, left: 20, bottom: 40, top: 40),
                  child: MaterialButton(
                    onPressed: () async {
                      await _location.getLocation().then((value) {
                        setState(() {
                          checkoutProvider.setLocation = value;
                        });
                      });
                      Navigator.of(context).pop();
                    },
                    color: Color.fromARGB(255, 8, 82, 143),
                    child: Text(
                      "Set Location",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontFamily: "Circular"),
                    ),
                    shape: StadiumBorder(),
                  ),
                )),
            Center(
              child: Container(
                height: 50,
                margin: EdgeInsets.only(bottom: 40),
                child: Image.asset("assets/images/map_marker.png"),
              ),
            ),
          ],
        ),
      ),
    ));
  }

  @override
  void dispose() {
   
    googleMapController.dispose();
    super.dispose();
  }
}
