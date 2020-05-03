import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as prefix0;
import 'package:flutter/services.dart';
import 'package:dropdownfield/dropdownfield.dart';

class PickupEntryDetails extends StatefulWidget {
  static const routeName = '/pickup_entry_details';

  @override
  _PickupEntryDetailsState createState() => _PickupEntryDetailsState();
}

class _PickupEntryDetailsState extends State<PickupEntryDetails> {
  final _formKey = GlobalKey<FormState>();
  Map<String, dynamic> formData;

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

  _PickupEntryDetailsState() {
    formData = {
      'categories': 'Dry Food & Supplements',
    };
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Pickup Details'),),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          child: ListView(
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(labelText: 'Sender\'s Name'),
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) {},
                validator: (value) {
                  return;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Sender\'s Phone'),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                onFieldSubmitted: (_) {},
                validator: (value) {
                  return;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Sender\'s Address'),
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) {},
                validator: (value) {
                  return;
                },
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                children: <Widget>[
                  Text(
                    'Item\'s Information',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              DropDownField(
                value: formData['Category'],
                icon: Icon(Icons.category),
                required: true,
                hintText: 'Choose a category',
                labelText: 'Item Category *',
                items: categories,
                strict: false,
              ),
              prefix0.SizedBox(
                height: 15,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Quantity'),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                onFieldSubmitted: (_) {},
                validator: (value) {
                  return;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Description'),
                maxLines: 3,
                keyboardType: TextInputType.multiline,
                // focusNode: _descriptionFocusNode,
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
              SizedBox(height: 15,),
              RaisedButton(
                shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(18.0),
                    side: BorderSide(color: Colors.blue)),
                onPressed: () {
                  Navigator.of(context).pushNamed(PickupEntryDetails.routeName);
                },
                color: Colors.blue,
                textColor: Colors.white,
                child: Text("Generate Pickup".toUpperCase(),
                    style: TextStyle(fontSize: 14)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
