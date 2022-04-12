import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/add_place_screen.dart';
import 'package:provider/provider.dart';
import '../providers/great_places.dart';
import 'dart:io';
import '../providers/great_places.dart';
import './place_detail_screen.dart';

class PlacesListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Places'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(AddPlaceScreen.routeName);
            },
          ),
        ],
      ),
      body: FutureBuilder(
        future:
            Provider.of<GreatPlaces>(context, listen: false).fechAndSetPlaces(),
        builder: (ctx, snapshot) => snapshot.connectionState ==
                ConnectionState.waiting
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Consumer<GreatPlaces>(
                builder: (ctx, greatPlaces, ch) => greatPlaces.items.isEmpty
                    ? ch as Widget
                    : ListView.builder(
                        itemCount: greatPlaces.items.length,
                        itemBuilder: (ctx, index) => ListTile(
                            onTap: () {
                              Navigator.of(context).pushNamed(
                                  PlaceDetailScreen.routeName,
                                  arguments: [greatPlaces.items[index].id]);
                            },
                            title:
                                Text(greatPlaces.items[index].title as String),
                            subtitle: Text(greatPlaces
                                .items[index].location?.address as String),
                            leading: CircleAvatar(
                              backgroundImage: FileImage(
                                  greatPlaces.items[index].image as File),
                            )),
                      ),
                child: Center(
                    child: const Text("Got no places yet,start adding some!")),
              ),
      ),
    );
  }
}
