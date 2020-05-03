import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:carri_plus/states/app_state.dart';
import 'screens/home.dart';
import 'screens/pickup_entry_details_screen.dart';


void main() {
  return runApp(MultiProvider(providers: [
      ChangeNotifierProvider.value(value: AppState(),)
  ],
  child: MyApp(),));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Carr+',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Carri+'),
      routes: {
            PickupEntryDetails.routeName: (ctx) => PickupEntryDetails(),
          }
    );
  }
}


