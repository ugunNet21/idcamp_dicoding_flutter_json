import 'package:flutter/material.dart';
import 'package:flutter_subm1_localjson/models/restaurant.dart';

class RestaurantDetailPage extends StatefulWidget {
  final Restaurant restaurant;

  const RestaurantDetailPage({Key? key, required this.restaurant})
      : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _RestaurantDetailPageState createState() => _RestaurantDetailPageState();
}

class _RestaurantDetailPageState extends State<RestaurantDetailPage> {
  bool showFullDescription = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.restaurant.name),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12.0),
              child: Image.network(
                widget.restaurant.pictureId,
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Description:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            
            const SizedBox(height: 8),
            Text(
              showFullDescription
                  ? widget.restaurant.description
                  : _truncateDescription(widget.restaurant.description),
              textAlign: TextAlign.justify,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            if (!showFullDescription)
              TextButton(
                onPressed: () {
                  _showFullDescription(context);
                },
                child: const Text('Show More'),
              ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.star, color: Colors.yellow),
                const SizedBox(width: 8),
                Text(
                  '${widget.restaurant.rating}',
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(width: 16),
                const Icon(Icons.location_city, color: Colors.blue),
                const SizedBox(width: 8),
                Text(
                  widget.restaurant.city,
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
            const SizedBox(height: 8),
            const Text(
              'Menu:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            _buildMenuList(widget.restaurant.menus['foods'], 'Foods'),
            _buildMenuList(widget.restaurant.menus['drinks'], 'Drinks'),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuList(List<dynamic>? menuList, String category) {
    if (menuList == null || menuList.isEmpty) {
      return Container();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 8),
        Text(
          category,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: menuList.map((menu) => Text('- ${menu['name']}')).toList(),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  String _truncateDescription(String description) {
    const int maxCharacters = 150;
    return description.length <= maxCharacters
        ? description
        : '${description.substring(0, maxCharacters)}...';
  }

  void _showFullDescription(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Description'),
          content: Text(widget.restaurant.description),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }
}
