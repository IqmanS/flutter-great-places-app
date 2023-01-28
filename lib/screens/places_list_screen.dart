import 'package:flutter/material.dart';
import 'package:great_places_app/models/place.dart';
import 'package:great_places_app/providers/great_places.dart';
import 'package:great_places_app/screens/add_place_screen.dart';
import 'package:provider/provider.dart';

class PlacesListScreen extends StatelessWidget {
  static const routeName = "/places-list";
  const PlacesListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final greatPlacesData = Provider.of<GreatPlaces>(context, listen: false);
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColorLight,
      appBar: AppBar(
        title: const Text("Your Places"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(AddPlaces.routeName);
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: FutureBuilder(
        future: greatPlacesData.fetchAndSetItems(),
        builder: (context, snapshot) => snapshot.connectionState ==
                ConnectionState.waiting
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Consumer<GreatPlaces>(
                builder: (context, value, child) =>
                    greatPlacesData.items.isEmpty
                        ? const Center(
                            child: Text("None added yet"),
                          )
                        : ListView.builder(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 4),
                            itemCount: greatPlacesData.items.length,
                            itemBuilder: (context, index) {
                              final Place place = greatPlacesData.items[index];
                              return Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16)),
                                child: ListTile(
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 4, vertical: 12),
                                  onTap: () {},
                                  minLeadingWidth: 100,
                                  leading: CircleAvatar(
                                      backgroundImage: FileImage(place.image),
                                      radius: 40),
                                  title: Text(place.title),
                                  trailing: IconButton(
                                    icon: const Icon(Icons.expand_circle_down),
                                    onPressed: () {},
                                  ),
                                ),
                              );
                            },
                          ),
              ),
      ),
    );
  }
}
