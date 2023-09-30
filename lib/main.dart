import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: OrientationBuilder(
        builder: (context, orientation) {
          return orientation == Orientation.landscape
              ? LandscapeProfileScreen()
              : PortraitProfileScreen();
        },
      ),
    );
  }
}

class PortraitProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CircleAvatar(
              radius: 80.0,
              backgroundImage: NetworkImage('https://shorturl.at/oqMY7'),
            ),
            SizedBox(height: 16.0),
            RichText(
              text: TextSpan(
                style: TextStyle(
                  fontSize: 24.0,
                  color: Colors.black,
                ),
                children: [
                  TextSpan(
                    text: 'John Doe\n',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text: 'Designer',
                    style: TextStyle(fontSize: 18.0, color: Colors.grey),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              'Some details about John Doe',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 16.0),
            Expanded(
                child: GridView.count(
                  crossAxisCount: 3,
                  children: List.generate(
                    6,
                        (index) => Image.network(
                      'https://shorturl.at/oqMY7',
                      fit: BoxFit.cover,
                    ),
                  ),
                )
            ),
          ],
        ),
      ),
    );
  }
}

class LandscapeProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CircleAvatar(
                radius: 80.0,
                backgroundImage: NetworkImage('https://shorturl.at/oqMY7'),
              ),
              SizedBox(height: 16.0),
              RichText(
                text: TextSpan(
                  style: TextStyle(
                    fontSize: 24.0,
                    color: Colors.black,
                  ),
                  children: [
                    TextSpan(
                      text: 'John Doe\n',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text: 'Designer',
                      style: TextStyle(fontSize: 18.0, color: Colors.grey),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16.0),
              Text(
                'Some details about John Doe',
                style: TextStyle(fontSize: 16.0),
              ),
              SizedBox(height: 16.0),
              GridView.count(
                crossAxisCount: 3,
                children: List.generate(
                  6,
                      (index) => Image.network(
                    'https://shorturl.at/oqMY7', // Replace with the actual image URL
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
