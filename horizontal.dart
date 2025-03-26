import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
      routes: {
        '/screen1': (_) => ScreenOne(),
        '/screen2': (_) => ScreenTwo(),
        '/screen3': (_) => ScreenThree(),
      },
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('3 Screens')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () => Navigator.pushNamed(context, '/screen1'),
                child: Text('Vertical ListView')),
            ElevatedButton(
                onPressed: () => Navigator.pushNamed(context, '/screen2'),
                child: Text('Horizontal ListView')),
            ElevatedButton(
                onPressed: () => Navigator.pushNamed(context, '/screen3'),
                child: Text('Without ListView')),
          ],
        ),
      ),
    );
  }
}

class ScreenOne extends StatelessWidget {
  final List<String> internetImages = [
    'https://images.unsplash.com/photo-1506744038136-46273834b3fb', // Forest
    'https://images.unsplash.com/photo-1507525428034-b723cf961d3e', // Beach
    'https://images.unsplash.com/photo-1465146633011-14f6b58a1246', // Mountain
    'https://images.unsplash.com/photo-1500530855697-b586d89ba3ee', // River
  ];
  final List<String> localImages = [
    'assets/pic1.jpeg',
    'assets/pic2jpeg',
    'assets/pic3.jpeg',
    'assets/pic4.jpeg',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Vertical ListView')),
      body: ListView(
        children: [
          ...internetImages.map((url) => Image.network(url)),
          ...localImages.map((path) => Image.asset(path)),
        ],
      ),
    );
  }
}

class ScreenTwo extends StatelessWidget {
  final List<String> internetImages = [
    'https://images.unsplash.com/photo-1506744038136-46273834b3fb', // Forest
    'https://images.unsplash.com/photo-1507525428034-b723cf961d3e', // Beach
    'https://images.unsplash.com/photo-1465146633011-14f6b58a1246', // Mountain
    'https://images.unsplash.com/photo-1500530855697-b586d89ba3ee', // River
  ];
  final List<String> localImages = [
    'assets/pic1.jpeg',
    'assets/pic2jpeg',
    'assets/pic3.jpeg',
    'assets/pic4.jpeg',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Horizontal ListView')),
      body: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          ...internetImages.map((url) => Image.network(url, width: 150)),
          ...localImages.map((path) => Image.asset(path, width: 150)),
        ],
      ),
    );
  }
}

class ScreenThree extends StatelessWidget {
  final List<String> internetImages = [
  'https://images.unsplash.com/photo-1506744038136-46273834b3fb', // Forest
  'https://images.unsplash.com/photo-1507525428034-b723cf961d3e', // Beach
  'https://images.unsplash.com/photo-1465146633011-14f6b58a1246', // Mountain
  'https://images.unsplash.com/photo-1500530855697-b586d89ba3ee', // River
  ];
  final List<String> localImages = [
  'assets/pic1.jpeg',
  'assets/pic2jpeg',
  'assets/pic3.jpeg',
  'assets/pic4.jpeg',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('No ListView')),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: internetImages.map((url) => Image.network(url, width: 150, height: 150)).toList(),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: localImages.map((path) => Image.asset(path, width: 150, height: 150)).toList(),
          ),
        ],
      ),
    );
  }
}


