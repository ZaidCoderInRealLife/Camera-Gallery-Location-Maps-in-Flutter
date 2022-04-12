import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/place_detail_screen.dart';
import 'package:provider/provider.dart';

import './providers/great_places.dart';
import './screens/place_list_screen.dart';
import './screens/add_place_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => GreatPlaces(),
      child: MaterialApp(
          title: 'Great Places',
          theme: ThemeData(
            primarySwatch: Colors.indigo,
            accentColor: Colors.amber,
          ),
          home: PlacesListScreen(),
          routes: {
            PlaceDetailScreen.routeName: (ctx) => PlaceDetailScreen(),
            AddPlaceScreen.routeName: (ctx) => AddPlaceScreen(),
          }),
    );
  }
}
