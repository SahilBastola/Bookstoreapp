import 'package:ebuy/model/product.dart';
import 'package:ebuy/repository/product_repo.dart';
import 'package:ebuy/screen/productdetail.dart';
import 'package:flutter/material.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({Key? key}) : super(key: key);

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  final List<bool> _isFavorite = [];
  final List<bool> _isAddedToCart = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 3,
        backgroundColor: const Color.fromARGB(255, 7, 64, 164),
        title: const Row(
          children: [
            SizedBox(width: 10), // Add spacing between logo and title
            Text(
              'Products',
              style: TextStyle(
                color: Color.fromARGB(255, 20, 19, 19),
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          const Text(
            "Explore Products",
            style: TextStyle(
                fontSize: 24, fontWeight: FontWeight.bold, color: Colors.blue),
          ),
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: Container(
              // margin: const EdgeInsets.symmetric(vertical: 12),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.horizontal(),
                color: Color.fromARGB(172, 237, 230, 230),
              ),
              child: FutureBuilder<List<Product>>(
                future: ProductRepositoryImpl().getAllProduct(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return const Center(child: Text('Error fetching data'));
                  } else if (snapshot.hasData) {
                    return GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.75,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                      ),
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        final product = snapshot.data![index];
                        _isFavorite.add(false);
                        _isAddedToCart.add(false);

                        return InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => ProductDetailsView(
                                  product.img ?? "",
                                  product.title ?? "",
                                  product.desc ?? "",
                                  "${product.price}",
                                  product.Author ?? "",
                                  product.productid ?? "",
                                ),
                              ),
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: const Color.fromARGB(255, 221, 219, 219),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Stack(
                                    children: [
                                      Image.network(
                                        product.img ?? "",
                                        fit: BoxFit.cover,
                                        height: 500,
                                        width: 200,
                                      ),
                                      Align(
                                        alignment: Alignment.topRight,
                                        child: IconButton(
                                          onPressed: () {
                                            setState(() {
                                              _isFavorite[index] =
                                                  !_isFavorite[index];
                                            });
                                          },
                                          icon: Icon(
                                            _isFavorite[index]
                                                ? Icons.favorite
                                                : Icons.favorite_border,
                                            color: _isFavorite[index]
                                                ? Colors.red
                                                : Colors.black,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  product.title ?? "",
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  "Rs ${product.price ?? ""}",
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.black,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        // Implement your "Add to Cart" functionality
                                        setState(() {
                                          _isAddedToCart[index] = true;
                                        });
                                        _showCartAddedDialog(context);
                                      },
                                      icon: Icon(
                                        Icons.shopping_cart_outlined,
                                        color: _isAddedToCart[index]
                                            ? Colors.green
                                            : Colors.black,
                                      ),
                                    ),
                                    Text(
                                      "Add to Cart",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: _isAddedToCart[index]
                                            ? Colors.green
                                            : Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  } else {
                    return const Center(child: Text('No products available'));
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showCartAddedDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Added to Cart"),
          content: const Text("The item has been added to your cart."),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }
}
