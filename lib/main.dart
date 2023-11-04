import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Photo Gallery App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: PhotoListScreen(),
    );
  }
}

class PhotoListScreen extends StatefulWidget {
  @override
  _PhotoListScreenState createState() => _PhotoListScreenState();
}

class _PhotoListScreenState extends State<PhotoListScreen> {
  List<dynamic> _photos = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _fetchPhotos();
  }

  Future<void> _fetchPhotos() async {
    try {
      final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/photos'));
      if (response.statusCode == 200) {
        setState(() {
          _photos = json.decode(response.body);
          _loading = false;
        });
      } else {
        throw Exception('Failed to load photos');
      }
    } catch (error) {
      print('Error: $error');
      setState(() {
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Photo Gallery App'),
      ),
      body: _loading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: _photos.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(_photos[index]['title']),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PhotoDetailScreen(
                    photoId: _photos[index]['id'],
                    photoUrl: _photos[index]['url'],
                    photoTitle: _photos[index]['title'],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class PhotoDetailScreen extends StatelessWidget {
  final int photoId;
  final String photoUrl;
  final String photoTitle;

  PhotoDetailScreen({
  required this.photoId,
  required this.photoUrl,
  required this.photoTitle,
});

@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: Text('Photo Details'),
    ),
    body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.network(photoUrl),
        SizedBox(height: 20),
        Text('ID: $photoId', style: TextStyle(fontSize: 18)),
        SizedBox(height: 10),
        Text('Title: $photoTitle', style: TextStyle(fontSize: 18)),
      ],
    ),
  );
}
}
