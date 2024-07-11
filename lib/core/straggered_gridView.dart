// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class StraggeredScreen extends StatelessWidget {
  const StraggeredScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> imageUrl = [
      'https://images.pexels.com/photos/1563256/pexels-photo-1563256.jpeg?cs=srgb&dl=pexels-rickyrecap-1563256.jpg&fm=jpg',
      'https://static.vecteezy.com/system/resources/thumbnails/030/222/669/small_2x/a-majestic-city-skyline-during-the-golden-hour-ai-generative-free-photo.jpg',
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS-2T3jXMr-_yrtKeRvKmx8VDVExeBSwi9l6O6xBSY5eo2WXcIntdZUCmNRP1OaaaET_go&usqp=CAU',
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRYfd1eKt5U6PSl8UJbCkG28FHajI4wEcuIgE_E57wMnRGUIc1xjpF9Rr7Z1wqQRcsX3xo&usqp=CAU',
      'https://as2.ftcdn.net/v2/jpg/04/14/56/09/500_F_414560920_3966xNY3WuPpIywWna5vUbjsWyqdNKVG.jpg',
      'https://burst.shopifycdn.com/photos/city-road-with-tracks-at-night.jpg?width=925&format=pjpg&exif=0&iptc=0',
      'https://images.unsplash.com/photo-1518567785273-817cd1486ed8?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1yZWxhdGVkfDEyfHx8ZW58MHx8fHx8&w=1000&q=80',
      'https://images.pexels.com/photos/1563256/pexels-photo-1563256.jpeg?cs=srgb&dl=pexels-rickyrecap-1563256.jpg&fm=jpg',
      'https://static.vecteezy.com/system/resources/thumbnails/030/222/669/small_2x/a-majestic-city-skyline-during-the-golden-hour-ai-generative-free-photo.jpg',
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS-2T3jXMr-_yrtKeRvKmx8VDVExeBSwi9l6O6xBSY5eo2WXcIntdZUCmNRP1OaaaET_go&usqp=CAU',
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRYfd1eKt5U6PSl8UJbCkG28FHajI4wEcuIgE_E57wMnRGUIc1xjpF9Rr7Z1wqQRcsX3xo&usqp=CAU',
      'https://as2.ftcdn.net/v2/jpg/04/14/56/09/500_F_414560920_3966xNY3WuPpIywWna5vUbjsWyqdNKVG.jpg',
      'https://burst.shopifycdn.com/photos/city-road-with-tracks-at-night.jpg?width=925&format=pjpg&exif=0&iptc=0',
      'https://images.unsplash.com/photo-1518567785273-817cd1486ed8?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1yZWxhdGVkfDEyfHx8ZW58MHx8fHx8&w=1000&q=80',
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Staggered GridView'),
      ),
      body: MasonryGridView.builder(
        itemCount: imageUrl.length,
        gridDelegate: const SliverSimpleGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2),
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.all(2.0),
          child: ClipRRect(
            borderRadius:
                BorderRadius.circular(5.0),
            child: Image.network(
              imageUrl[index],
              fit: BoxFit.cover, 
            ),
          ),
        ),
      ),
    );
  }
}
