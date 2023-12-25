import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_subm1_localjson/models/restaurant.dart';
import 'package:flutter_subm1_localjson/screens/restaurant_detail_screen.dart';

class RestaurantListPage extends StatefulWidget {
  const RestaurantListPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _RestaurantListPageState createState() => _RestaurantListPageState();
}

class _RestaurantListPageState extends State<RestaurantListPage> {
  List<Restaurant> restaurants = [];

  @override
  void initState() {
    super.initState();
    _loadDataFromJson();
  }

  Future<void> _loadDataFromJson() async {
    String jsonData = await DefaultAssetBundle.of(context)
        .loadString('assets/restaurant_data.json');
    Map<String, dynamic> data = jsonDecode(jsonData);
    List<dynamic> restaurantData = data['restaurants'];
    setState(() {
      restaurants = restaurantData
          .map((restaurantJson) => Restaurant.fromJson(restaurantJson))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Restaurant List'),
      ),
      body: ListView.builder(
        itemCount: restaurants.length,
        itemBuilder: (context, index) {
          Restaurant restaurant = restaurants[index];
          return Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: ListTile(
              title: Text(restaurant.name),
              subtitle: Row(
                children: [
                  const Icon(Icons.location_city),
                  const SizedBox(width: 4),
                  Text(restaurant.city),
                ],
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.star, color: Colors.yellow),
                  Text(restaurant.rating.toString()),
                ],
              ),
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.network(
                  restaurant.pictureId,
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        RestaurantDetailPage(restaurant: restaurant),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
