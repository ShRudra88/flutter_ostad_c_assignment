import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class Item {
  String name;
  String color;
  String size;
  double price;
  int quantity;

  Item({
    required this.name,
    required this.color,
    required this.size,
    required this.price,
    this.quantity = 0,
  });
}

class CartItem {
  Item item;
  int quantity;

  CartItem(this.item, this.quantity);
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Item> items = [
    Item(name: 'Shirt', color: 'Red', size: 'M', price: 20.0),
    Item(name: 'Pant', color: 'Blue', size: 'L', price: 25.0),
    Item(name: 'Lungi', color: 'Green', size: 'S', price: 15.0),
  ];

  List<CartItem> cart = [];

  Map<Item, int> productCount = {};

  void addToCart(Item item) {
    setState(() {
      int index = cart.indexWhere((cartItem) => cartItem.item == item);
      if (index != -1) {
        cart[index].quantity++;
      } else {
        cart.add(CartItem(item, 1));
      }
      updateProductCount();
    });
  }

  void removeFromCart(Item item) {
    setState(() {
      int index = cart.indexWhere((cartItem) => cartItem.item == item);
      if (index != -1) {
        if (cart[index].quantity > 1) {
          cart[index].quantity--;
        } else {
          cart.removeAt(index);
        }
      }
      updateProductCount();
    });
  }

  void updateProductCount() {
    productCount.clear();
    for (CartItem cartItem in cart) {
      productCount[cartItem.item] = cartItem.quantity;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Bag'),
      ),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          Item item = items[index];
          int quantityInCart = productCount[item] ?? 0;
          return ListTile(
            leading: Image.asset('assets/${item.name.toLowerCase()}.jpg'),
            title: Text(item.name),
            subtitle: Text('Color: ${item.color}, Size: ${item.size}, Price: \$${item.price.toStringAsFixed(2)}'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.remove),
                  onPressed: () => removeFromCart(item),
                ),
                Text(quantityInCart.toString()),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () => addToCart(item),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          final snackBar = SnackBar(
            content: Text('Congratulations! Your total amount is \$${calculateTotalPrice().toStringAsFixed(2)}'),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        },
        label: Text('CHECK OUT'),
        icon: Icon(Icons.shopping_cart),
      ),
      // Show the total cost here
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Total: \$${calculateTotalPrice().toStringAsFixed(2)}', style: TextStyle(fontSize: 20)),
          ],
        ),
      ),
    );
  }

  double calculateTotalPrice() {
    double total = 0;
    for (CartItem cartItem in cart) {
      total += cartItem.item.price * cartItem.quantity;
    }
    return total;
  }

  @override
  void initState() {
    super.initState();
    updateProductCount();
  }
}
