import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(home: FourScreens(), theme: ThemeData(brightness: Brightness.light, primarySwatch: Colors.purple)));

class FourScreens extends StatefulWidget {
  @override
  _FourScreensState createState() => _FourScreensState();
}

class _FourScreensState extends State<FourScreens> {
  int screen = 1, friendIndex = 0;
  final friends = ['Ayesha', 'Sara', 'Eman', 'Fatima'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple.shade50,
      appBar: AppBar(title: Text('Beautiful UI', style: TextStyle(fontWeight: FontWeight.bold))),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (screen == 1) Text('Ayesha Sadiqa', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.deepPurple)),
            if (screen == 2) ElevatedButton(style: ElevatedButton.styleFrom(padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))), onPressed: () {}, child: Text('Elevated Button', style: TextStyle(fontSize: 18))),
            if (screen == 3) Column(children: [Text('Ayesha Sadiqa', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.deepPurple)), SizedBox(height: 10), ElevatedButton(style: ElevatedButton.styleFrom(padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))), onPressed: () {}, child: Text('Elevated Button', style: TextStyle(fontSize: 18)))]),
            if (screen == 4) Column(children: [Text('Friends List', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.deepPurple)), SizedBox(height: 10), ElevatedButton(style: ElevatedButton.styleFrom(padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))), onPressed: () => setState(() => friendIndex = (friendIndex + 1) % friends.length), child: Text(friends[friendIndex], style: TextStyle(fontSize: 18))) ]),
            SizedBox(height: 30),
            Wrap(
              spacing: 10,
              children: List.generate(4, (i) => ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: const Color.fromARGB(255, 58, 68, 183), padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                onPressed: () => setState(() => screen = i + 1), 
                child: Text('Screen ${i + 1}', style: TextStyle(color: Colors.white)),
              ))
            )
          ],
        ),
      ),
    );
  }
}