import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:provider/provider.dart';

import '../models/place.dart';
import '../states/app_state.dart';

const kGoogleApiKey = "AIzaSyAjV3xAsNS9y5s19sUP3epXJ4nB0cfrF8I";

class MapScreen extends StatefulWidget {
  final PlaceLocation initialLocation;
  final bool isSelecting;

  MapScreen({
    this.initialLocation =
        const PlaceLocation(latitude: 37.422, longitude: -122.084),
    this.isSelecting = false,
  });

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  LatLng _pickedLocation;

  void _selectLocation(LatLng position) {
    setState(() {
      _pickedLocation = position;
    });
  }

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    var destinationController = TextEditingController();
    final homeScaffoldKey = GlobalKey<ScaffoldState>();
    
    return Scaffold(
      key: homeScaffoldKey,
      appBar: AppBar(
        title: Text('Your Map'),
        actions: <Widget>[
          if (widget.isSelecting)
            IconButton(
              icon: Icon(Icons.check),
              onPressed: _pickedLocation == null
                  ? null
                  : () {
                      Navigator.of(context).pop(_pickedLocation);
                    },
            ),
        ],
      ),
      body: Stack(children: <Widget>[
        GoogleMap(
          initialCameraPosition: CameraPosition(
            target: appState.initialPosition,
            zoom: 15.0,
          ),
          onTap: widget.isSelecting ? _selectLocation : null,
          markers: (_pickedLocation == null && widget.isSelecting)
              ? null
              : {
                  Marker(
                    markerId: MarkerId('m1'),
                    position: _pickedLocation ??
                        LatLng(
                          widget.initialLocation.latitude,
                          widget.initialLocation.longitude,
                        ),
                  ),
                },
        ),
        Positioned(
          top: 50.0,
          right: 15.0,
          left: 15.0,
          child: Container(
            height: 50.0,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(3.0),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    color: Colors.grey,
                    offset: Offset(1.0, 5.0),
                    blurRadius: 10,
                    spreadRadius: 3)
              ],
            ),
            child: TextField(
              controller: destinationController,
              onTap: () async {
                Prediction p = await PlacesAutocomplete.show(
                    context: context,
                    apiKey: "AIzaSyAjV3xAsNS9y5s19sUP3epXJ4nB0cfrF8I",
                    language: "en",
                    components: [Component(Component.country, "gh")]);
                //  displayPrediction(p, homeScaffoldKey.currentState);

                // if (p != null) {
                //   // get detail (lat/lng)
                //   PlacesDetailsResponse detail =
                //       await _places.getDetailsByPlaceId(p.placeId);
                //   final lat = detail.result.geometry.location.lat;
                //   final lng = detail.result.geometry.location.lng;

                //   // scaffold.showSnackBar(
                //   //   SnackBar(content: Text("${p.description} - $lat/$lng")),
                //   // );

                //   setState(() {
                //     destinationController.text = "${p.description}";
                //   });
                //   print(p.description);
                // }
                 displayPrediction(p, homeScaffoldKey.currentState);
              },
              cursorColor: Colors.black,
              // controller: appState.destinationController,
              textInputAction: TextInputAction.go,
              onSubmitted: (value) {
                appState.sendRequest(value);
              },
              decoration: InputDecoration(
                icon: Container(
                  margin: EdgeInsets.only(left: 20, top: 5),
                  width: 10,
                  height: 10,
                  child: Icon(
                    Icons.local_taxi,
                    color: Colors.black,
                  ),
                ),
                hintText: "Pickup Location?",
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(left: 15.0, top: 16.0),
              ),
            ),
          ),
        ),
      ]),
    );
  }
}

GoogleMapsPlaces _places = GoogleMapsPlaces(apiKey: kGoogleApiKey);

Future<Null> displayPrediction(Prediction p, ScaffoldState scaffold) async {
  if (p != null) {
    // get detail (lat/lng)
    PlacesDetailsResponse detail = await _places.getDetailsByPlaceId(p.placeId);
    final lat = detail.result.geometry.location.lat;
    final lng = detail.result.geometry.location.lng;

    scaffold.showSnackBar(
      SnackBar(content: Text("${p.description} - $lat/$lng")),
    );
  }
}
