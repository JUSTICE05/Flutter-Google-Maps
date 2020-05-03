import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as prefix0;
import 'package:flutter_google_places/flutter_google_places.dart';
// import 'package:flutter/material.dart' as prefix0;
// import 'package:flutter/material.dart' as prefix0;
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:provider/provider.dart';
import 'package:carri_plus/states/app_state.dart';
import '../widgets/app_drawer.dart';
import './pickup_entry_details_screen.dart';
import 'package:dropdownfield/dropdownfield.dart';
import 'package:flutter/services.dart';
import '../widgets/locationCheckService.dart';
import '../widgets/homeScreenFloatingActionButton.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Map());
  }
}

class Map extends StatefulWidget {
  @override
  _MapState createState() => _MapState();
}

class _MapState extends State<Map> {
  final _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  // Map<String, dynamic> formData;

  _PickupEntryDetailsState() {
    // formData = {
    //   'categories': 'Dry Food & Supplements',
    // };
  }

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    return Scaffold(
      drawer: appState.initialPosition == null
          ? null
          : SafeArea(
              child: appState.initialPosition == null ? null : AppDrawer()),
      body: SafeArea(
        child: 
        appState.initialPosition == null
            ? LocationCheckService()
            : Stack(
                children: <Widget>[
                  GoogleMap(
                    initialCameraPosition: CameraPosition(
                        target: appState.initialPosition, zoom: 15.0),
                    onMapCreated: appState.onCreated,
                    myLocationEnabled: true,
                    mapType: MapType.normal,
                    compassEnabled: true,
                    markers: appState.markers,
                    onCameraMove: appState.onCameraMove,
                    polylines: appState.polyLines,
                    myLocationButtonEnabled: true,
                    zoomGesturesEnabled: true,
                    // minMaxZoomPreference: MinMaxZoomPreference(),
                  ),
                  Positioned(
                    top: 20,
                    left: 15,
                    height: 1,
                    child: IconButton(
                      icon: Icon(
                        Icons.dehaze,
                        size: 30,
                      ),
                      onPressed: () => _scaffoldKey.currentState.openDrawer(),
                    ),
                  ),
                ],
              ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton:
          appState.initialPosition == null ? null : HomeFloatingActionButton(),
    );
  }
}
