import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import '../extra/generated/i18n.dart' as location_picker;
import '../extra/google_map_location_picker.dart';

import '../screens/mapScreen.dart';
import 'package:dropdownfield/dropdownfield.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/material.dart' ;
import '../screens/home.dart';
import 'package:provider/provider.dart';
import '../states/app_state.dart';

class HomeFloatingActionButton extends StatefulWidget {
  @override
  _HomeFloatingActionButtonState createState() =>
      _HomeFloatingActionButtonState();
}

List<String> categories = [
  'Dry Food Supplements',
  'Bags & Luggages',
  'Fashion',
  'Health and Beauty',
  'Home Appliances',
  'Documents',
  'Acessories(no battery)',
  'Acessories(with battery)',
  'Books & Collectibles',
  'Computers & Laptops',
  'Home Decor',
  'Toys',
  'Watches',
  'Pet Acessories',
  'Jewelry',
];

class _HomeFloatingActionButtonState extends State<HomeFloatingActionButton> {
  LocationResult _pickedLocation;

  Future<void> _selectOnMap() async {
    final selectedLocation = await Navigator.of(context).push<LatLng>(
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (ctx) => MapScreen(
          isSelecting: true,
        ),
      ),
    );
    if (selectedLocation == null) {
      return;
    }
    // _showPreview(selectedLocation.latitude, selectedLocation.longitude);
    // widget.onSelectPlace(selectedLocation.latitude, selectedLocation.longitude);
  }

  Future<void> _selectOnTheMap() async {
    LocationResult result = await LocationPicker.pickLocation(
      context,
      "AIzaSyAjV3xAsNS9y5s19sUP3epXJ4nB0cfrF8I",
//                      mapStylePath: 'assets/mapStyle.json',
      myLocationButtonEnabled: true,
      layersButtonEnabled: true,
//                      resultCardAlignment: Alignment.bottomCenter,
    );
    print("result = $result");
    setState(() => _pickedLocation = result);
  }

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);

    final _sendersPhoneFocusNode = FocusNode();
    final _sendersAddressFocusNode = FocusNode();
    final _quantityFocusNode = FocusNode();
    final _categoryFocusNode = FocusNode();
    final _descriptionFocusNode = FocusNode();
    bool _validate = false;

    String _selectedPickupType = null;

    return RaisedButton(
      shape: new RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(18.0),
          side: BorderSide(color: Colors.blue)),
      onPressed: () {
        setState(() {
          appState.destinationController.text.isEmpty
              ? _validate = true
              : _validate = false;
          if (_validate == true) {
            // Navigator.of(context)
            //     .pushNamed(PickupEntryDetails.routeName);
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return Container(
                    child: AlertDialog(
                      title: Row(
                        children: <Widget>[
                          IconButton(
                            icon: Icon(Icons.arrow_back),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                          SizedBox(
                            width: 30,
                          ),
                          Text('Pick-up location '),
                          Divider(
                            color: Colors.black,
                          )
                        ],
                      ),
                      content: Container(
                        width: double.maxFinite,
                        height: 400.0,
                        child: Form(
                          child: ListView(children: <Widget>[
                            Divider(),
                            TextFormField(
                              decoration:
                                  InputDecoration(labelText: 'Sender\'s Name'),
                              textInputAction: TextInputAction.next,
                              // focusNode: _sendersNameFocusNode,

                              onFieldSubmitted: (_) {
                                FocusScope.of(context)
                                    .requestFocus(_sendersPhoneFocusNode);
                              },
                              validator: (value) {
                                return;
                              },
                            ),
                            TextFormField(
                              decoration:
                                  InputDecoration(labelText: 'Sender\'s Phone'),
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.number,
                              focusNode: _sendersPhoneFocusNode,
                              onFieldSubmitted: (_) {
                                FocusScope.of(context)
                                    .requestFocus(_sendersAddressFocusNode);
                              },
                              validator: (value) {
                                return;
                              },
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            Text(
                              'How do you want to specify where to send the package?',
                              style: TextStyle(color: Colors.black38),
                            ),
                            SizedBox(
                              height: 25,
                            ),
                            DropdownButton<String>(
                              value: _selectedPickupType,
                              icon: Icon(Icons.arrow_downward),
                              hint: Text('Specify Pickup'),
                              iconSize: 24,
                              elevation: 16,
                              style: TextStyle(color: Colors.black),
                              // underline: Container(
                              //   height: 2,
                              //   color: Colors.black,
                              // ),
                              onChanged: (value) {
                                _selectedPickupType = value;
                                switch (value) {
                                  case "Specify on map":
                                    _selectOnTheMap();
                                    break;
                                  case "Others":
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => MapScreen()),
                                    );
                                    break;
                                  case "Female":
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => MapScreen()),
                                    );
                                    break;
                                }
                              },
                              items: _dropDownItem(),
                            ),
                            // _selectedPickupType == "Ghana Post Digital Address" ?
                            TextFormField(
                              decoration:
                                  InputDecoration(labelText: 'Place Name'),
                              focusNode: _sendersAddressFocusNode,
                              textInputAction: TextInputAction.next,
                              onFieldSubmitted: (_) {
                                FocusScope.of(context)
                                    .requestFocus(_categoryFocusNode);
                              },
                              validator: (value) {
                                return;
                              },
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                FlatButton(
                                  child: Text(
                                    'NEXT >>',
                                    style: TextStyle(color: Colors.blue),
                                  ),
                                  onPressed: () {
                                    dialogEntry(context, _quantityFocusNode,
                                        _descriptionFocusNode);
                                  },
                                )
                              ],
                            )
                          ]),
                        ),
                      ),
                    ),
                  );
                });
          }
        });
        //  Navigator.of(context).pushNamed(PickupEntryDetails.routeName);
      },
      color: Colors.blue,
      textColor: Colors.white,
      child: Icon(Icons.add),
    );
  }
}

Future dialogEntry(BuildContext context, FocusNode _quantityFocusNode,
    FocusNode _descriptionFocusNode) {
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return Container(
          child: AlertDialog(
            title: Row(
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                SizedBox(
                  width: 30,
                ),
                Text('Item\'s Information'),
                Divider(
                  color: Colors.black,
                )
              ],
            ),
            content: Container(
              width: double.maxFinite,
              height: 400.0,
              child: Form(
                child: ListView(children: <Widget>[
                  Divider(),
                  SizedBox(
                    height: 20,
                  ),
                  DropDownField(
                    // value: formData['Category'],
                    icon: Icon(Icons.category),
                    required: true,
                    hintText: 'Choose a category',
                    labelText: 'Item Category *',
                    items: categories,

                    strict: false,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Quantity'),
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.number,
                    focusNode: _quantityFocusNode,
                    onFieldSubmitted: (_) {
                      FocusScope.of(context)
                          .requestFocus(_descriptionFocusNode);
                    },
                    validator: (value) {
                      return;
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Description'),
                    maxLines: 3,
                    keyboardType: TextInputType.multiline,
                    focusNode: _descriptionFocusNode,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter a description.';
                      }
                      if (value.length < 10) {
                        return 'Should be at least 10 characters long.';
                      } else {
                        return null;
                      }
                    },
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      FlatButton(
                        child: Text(
                          'NEXT >>',
                          style: TextStyle(color: Colors.blue),
                        ),
                        onPressed: () {
                          showDialog(context: context);
                        },
                      )
                    ],
                  ),
                ]),
              ),
            ),
          ),
        );
      });
}

List<DropdownMenuItem<String>> _dropDownItem() {
  List<String> ddl = [
    "My current location (GPS)",
    "Ghana Post Digital Address",
    "Specify on map"
  ];
  return ddl
      .map((value) => DropdownMenuItem(
            value: value,
            child: Text(value),
          ))
      .toList();
}
