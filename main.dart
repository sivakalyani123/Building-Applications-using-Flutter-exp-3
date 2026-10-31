import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

// Main application
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Product Search and Filter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const ProductSearchPage(),
    );
  }
}

// Product Search Page
class ProductSearchPage extends StatefulWidget {
  const ProductSearchPage({super.key});

  @override
  State<ProductSearchPage> createState() => _ProductSearchPageState();
}

class _ProductSearchPageState extends State<ProductSearchPage> {

  // Controller for search input
  final TextEditingController searchController =
      TextEditingController();

  // Selected category
  String selectedCategory = 'All';

  // Predefined list of products
  final List<Map<String, dynamic>> products = [
    {
      'name': 'Laptop',
      'category': 'Electronics',
      'price': 55000,
    },
    {
      'name': 'Smartphone',
      'category': 'Electronics',
      'price': 25000,
    },
    {
      'name': 'Headphones',
      'category': 'Electronics',
      'price': 2500,
    },
    {
      'name': 'T-Shirt',
      'category': 'Clothing',
      'price': 800,
    },
    {
      'name': 'Jeans',
      'category': 'Clothing',
      'price': 1500,
    },
    {
      'name': 'Running Shoes',
      'category': 'Footwear',
      'price': 2200,
    },
    {
      'name': 'Backpack',
      'category': 'Accessories',
      'price': 1200,
    },
    {
      'name': 'Watch',
      'category': 'Accessories',
      'price': 3500,
    },
  ];

  // Filter products according to search and category
  List<Map<String, dynamic>> get filteredProducts {

    return products.where((product) {

      String productName =
          product['name'].toString().toLowerCase();

      String searchText =
          searchController.text.toLowerCase();

      bool matchesSearch =
          productName.contains(searchText);

      bool matchesCategory =
          selectedCategory == 'All' ||
          product['category'] == selectedCategory;

      return matchesSearch && matchesCategory;

    }).toList();
  }

  // Reset search and category
  void resetFilters() {

    setState(() {
      searchController.clear();
      selectedCategory = 'All';
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      // App bar
      appBar: AppBar(
        title: const Text(
          'Product Search & Filter',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),

      // Main body
      body: Padding(
        padding: const EdgeInsets.all(16.0),

        child: Column(
          children: [

            // Search input
            TextField(
              controller: searchController,

              onChanged: (value) {
                setState(() {});
              },

              decoration: InputDecoration(
                labelText: 'Search Product',
                hintText: 'Enter product name',
                prefixIcon: const Icon(Icons.search),

                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),

            const SizedBox(height: 15),

            // Category dropdown and reset button
            Row(
              children: [

                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: selectedCategory,

                    decoration: InputDecoration(
                      labelText: 'Select Category',

                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),

                    items: const [

                      DropdownMenuItem(
                        value: 'All',
                        child: Text('All Categories'),
                      ),

                      DropdownMenuItem(
                        value: 'Electronics',
                        child: Text('Electronics'),
                      ),

                      DropdownMenuItem(
                        value: 'Clothing',
                        child: Text('Clothing'),
                      ),

                      DropdownMenuItem(
                        value: 'Footwear',
                        child: Text('Footwear'),
                      ),

                      DropdownMenuItem(
                        value: 'Accessories',
                        child: Text('Accessories'),
                      ),
                    ],

                    onChanged: (value) {

                      setState(() {
                        selectedCategory = value!;
                      });

                    },
                  ),
                ),

                const SizedBox(width: 10),

                // Reset button
                IconButton(
                  onPressed: resetFilters,

                  icon: const Icon(
                    Icons.refresh,
                    size: 30,
                  ),

                  tooltip: 'Reset',
                ),
              ],
            ),

            const SizedBox(height: 20),

            // Number of products
            Align(
              alignment: Alignment.centerLeft,

              child: Text(
                '${filteredProducts.length} Products Found',

                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 10),

            // Product list
            Expanded(

              child: filteredProducts.isEmpty

                  ? const Center(
                      child: Text(
                        'No products found',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )

                  : ListView.builder(

                      itemCount: filteredProducts.length,

                      itemBuilder: (context, index) {

                        final product =
                            filteredProducts[index];

                        return Card(

                          margin:
                              const EdgeInsets.only(bottom: 10),

                          child: ListTile(

                            leading: CircleAvatar(
                              child: Text(
                                product['name']
                                    .toString()[0],
                              ),
                            ),

                            title: Text(
                              product['name'],
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            subtitle: Text(
                              product['category'],
                            ),

                            trailing: Text(
                              '₹${product['price']}',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}