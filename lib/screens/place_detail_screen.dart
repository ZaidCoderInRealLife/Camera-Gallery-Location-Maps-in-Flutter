import 'dart:io';
import 'package:flutter_application_1/models/place.dart';

import './map_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/great_places.dart';

class PlaceDetailScreen extends StatelessWidget {
  const PlaceDetailScreen({Key? key}) : super(key: key);
  static const routeName = "/place-detail";

  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context)!.settings.arguments;
    final selectedPlace =
        Provider.of<GreatPlaces>(context, listen: false).finaById(id as String);
    return Scaffold(
      appBar: AppBar(
        title: Text(selectedPlace.title as String),
      ),
      body: Column(children: [
        Container(
          height: 250,
          width: double.infinity,
          child: Image.file(
            selectedPlace.image as File,
            fit: BoxFit.cover,
            width: double.infinity,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          selectedPlace.location!.address as String,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 20, color: Colors.grey),
        ),
        SizedBox(
          height: 10,
        ),
        FlatButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  fullscreenDialog: true,
                  builder: (builder) => MapScreen(
                        initialLocation:
                            selectedPlace.location as PlaceLocation,
                        isSelecting: false,
                      )));
            },
            child: Text("View on Map"))
      ]),
    );
  }
}
