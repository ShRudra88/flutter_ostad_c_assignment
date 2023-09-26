import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class Product {
  final String name;
  final double price;
  int quantity = 0;

  Product({required this.name, required this.price});
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Product List'),
        ),
        body: ProductList(),
      ),
    );
  }
}

class ProductList extends StatefulWidget {
  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  List<Product> products = [
    Product(name: 'Product 1', price: 10.0),
    Product(name: 'Product 2', price: 15.0),
    Product(name: 'Product 3', price: 20.0),
    Product(name: 'Product 4', price: 25.0),
    Product(name: 'Product 5', price: 30.0),
    Product(name: 'Product 6', price: 35.0),
    Product(name: 'Product 7', price: 39.0),
    Product(name: 'Product 8', price: 45.0),
    Product(name: 'Product 9', price: 45.0),
    Product(name: 'Product 10', price: 56.0),
    Product(name: 'Product 11', price: 72.0),
    Product(name: 'Product 12', price: 22.0),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return ListTile(
            title: Text(product.name),
            subtitle: Text('\$${product.price.toStringAsFixed(2)}'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('${product.quantity}'),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    setState(() {
                      product.quantity++;
                      if (product.quantity == 5) {
                        _showCongratulationsDialog(product.name);
                      }
                    });
                  },
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => CartPage(products: products),
            ),
          );
        },
        child: Icon(Icons.shopping_cart),
      ),
    );
  }

  void _showCongratulationsDialog(String productName) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Congratulations!'),
          content: Text('You\'ve bought 5 $productName!'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}

class CartPage extends StatelessWidget {
  final List<Product> products;

  CartPage({required this.products});

  @override
  Widget build(BuildContext context) {
    int totalQuantity = products.fold(0, (sum, product) => sum + product.quantity);

    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
      ),
      body: Center(
        child: Text('Total Products: $totalQuantity'),
      ),
    );
  }
}
