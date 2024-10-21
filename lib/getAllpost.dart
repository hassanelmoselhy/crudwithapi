import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Getallpost extends StatefulWidget {
  const Getallpost({super.key});

  @override
  State<Getallpost> createState() => _GetallpostState();
}

class _GetallpostState extends State<Getallpost> {
  List<Map<String, dynamic>> products = [];

  @override
  void initState() {
    super.initState();
    fetchPosts();
  }

  Future<void> fetchPosts() async {
    final response = await http.get(Uri.parse('https://dummyjson.com/products'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        products = List<Map<String, dynamic>>.from(data['products']);
      });
    } else {
      throw Exception('Failed to load products');
    }
  }

  // Function to handle deletion of a product
  void deleteProduct(int index) {
    setState(() {
      products.removeAt(index); // Remove the product from the list
    });
  }

  // Function to handle editing the product title
  void editProductTitle(int index) {
    TextEditingController _controller = TextEditingController(text: products[index]['title']);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit Title'),
          content: TextField(
            controller: _controller,
            decoration: const InputDecoration(hintText: "Enter new title"),
          ),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  products[index]['title'] = _controller.text; // Update the title
                });
                Navigator.pop(context);
              },
              child: const Text('Save'),
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
        title: const Text('Get All Posts'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: products.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(products[index]['title']),
                      ),
                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit, color: Colors.blue),
                            onPressed: () {
                              editProductTitle(index); // Function to edit title
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () {
                              deleteProduct(index); // Function to delete item
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.info, color: Colors.green),
                            onPressed: () {
                              // You can add any other functionality for the third icon here
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                  subtitle: Text(products[index]['description']),
                );
              },
            ),
    );
  }
}
