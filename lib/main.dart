import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class Item {
  String title;
  String description;

  Item({required this.title, required this.description});
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Editable List',
      home: EditableListScreen(),
    );
  }
}

class EditableListScreen extends StatefulWidget {
  @override
  _EditableListScreenState createState() => _EditableListScreenState();
}

class _EditableListScreenState extends State<EditableListScreen> {
  List<Item> items = [
    Item(title: "Item 1", description: "Description 1"),
    Item(title: "Item 2", description: "Description 2"),
  ];

  void _showEditDialog(Item item) {
    TextEditingController titleController = TextEditingController(text: item.title);
    TextEditingController descriptionController = TextEditingController(text: item.description);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit Item'),
          content: Column(
            children: [
              TextField(
                controller: titleController,
                decoration: InputDecoration(labelText: 'Title'),
              ),
              TextField(
                controller: descriptionController,
                decoration: InputDecoration(labelText: 'Description'),
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                setState(() {
                  item.title = titleController.text;
                  item.description = descriptionController.text;
                });
                Navigator.of(context).pop();
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }

  void _showDeleteDialog(Item item) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete Item'),
          content: Text('Are you sure you want to delete this item?'),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  items.remove(item);
                });
                Navigator.of(context).pop();
              },
              child: Text('Delete'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Editable List'),
      ),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(items[index].title),
            subtitle: Text(items[index].description),
            onLongPress: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Options'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          _showEditDialog(items[index]);
                        },
                        child: Text('Edit'),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          _showDeleteDialog(items[index]);
                        },
                        child: Text('Delete'),
                      ),
                    ],
                  );
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add new item
          Item newItem = Item(title: " New Item", description: "Description");
          setState(() {
            items.add(newItem);
          });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
