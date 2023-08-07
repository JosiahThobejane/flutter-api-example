import 'dart:convert';

import 'package:flutter/material.dart';

import '../settings/settings_view.dart';
import 'sample_item.dart';
import 'sample_item_details_view.dart';
import 'package:http/http.dart' as http;

/// Displays a list of SampleItems.
class SampleItemListView extends StatefulWidget {

  static const routeName = '/';

  @override
  State<SampleItemListView> createState() => _SampleItemListViewState();
}

class _SampleItemListViewState extends State<SampleItemListView> {

  List<SampleItem> cars = [];
  String restApiUrl = "https://64ce0c480c01d81da3ee771e.mockapi.io/cars";

  _getAllCars() async {
    try {
      Uri carsApi = Uri.parse(restApiUrl);

      http.Response carsResponse = await http.get(carsApi);

      if(carsResponse.statusCode == 200) {
        Iterable carsIterable = jsonDecode(carsResponse.body);
        cars = carsIterable.map((car) => SampleItem.fromJson(car)).toList();
        print(cars.length);
      }

      setState(() {
        
      });
    } catch (error) {
      print(error);
    }
  }

  _deleteCar(String id) async {
    try {
      Uri carsApi = Uri.parse("https://64ce0c480c01d81da3ee771e.mockapi.io/cars/$id");

      http.Response carsResponse = await http.delete(carsApi);
      SampleItem deletedCar = SampleItem.fromJson(jsonDecode(carsResponse.body));

      print(deletedCar.manufacturer);

      setState(() {
        
      });
    } catch (error) {
      print(error);
    }
  }

  @override
  void initState() {
    _getAllCars();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sample Items'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              // Navigate to the settings page. If the user leaves and returns
              // to the app after it has been killed while running in the
              // background, the navigation stack is restored.
              Navigator.restorablePushNamed(context, SettingsView.routeName);
            },
          ),
        ],
      ),

      // To work with lists that may contain a large number of items, it’s best
      // to use the ListView.builder constructor.
      //
      // In contrast to the default ListView constructor, which requires
      // building all Widgets up front, the ListView.builder constructor lazily
      // builds Widgets as they’re scrolled into view.
      body: ListView.builder(
        // Providing a restorationId allows the ListView to restore the
        // scroll position when a user leaves and returns to the app after it
        // has been killed while running in the background.
        restorationId: 'sampleItemListView',
        itemCount: cars.length,
        itemBuilder: (BuildContext context, int index) {
          SampleItem car = cars[index];

          return ListTile(
            title: Text(car.model),
            leading: Text(car.color),
            onTap: () {
              // Navigate to the details page. If the user leaves and returns to
              // the app after it has been killed while running in the
              // background, the navigation stack is restored.
              // Navigator.restorablePushNamed(
              //   context,
              //   SampleItemDetailsView.routeName,
              // );

              _deleteCar(car.id);
            }
          );
        },
      ),
    );
  }
}
