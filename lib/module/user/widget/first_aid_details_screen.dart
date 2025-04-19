import 'package:flutter/material.dart';


class ProductDetailPage extends StatefulWidget {
  final String image;
  const ProductDetailPage({super.key,required this.image});

  @override
  ProductDetailPageState createState() => ProductDetailPageState();
}

class ProductDetailPageState extends State<ProductDetailPage> {
  int quantity = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Product Detail"),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: Column(
        children: [
          // 1. Big Image
          Container(
            width: double.infinity,
            height: 250,
            child: Image.asset(
              widget.image, // Example water image
              fit: BoxFit.cover,
            ),
          ),

          // 2. Description and Price
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Fresh Mineral Water",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text(
                  "Clean and refreshing mineral water. Stay hydrated all day long.",
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 12),
                Text(
                  "\$1.50 per bottle",
                  style: TextStyle(fontSize: 20, color: Colors.green),
                ),
              ],
            ),
          ),

          Spacer(),

          // 3. Bottom Cart Section
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 5)],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Quantity control
                Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.remove),
                      onPressed: () {
                        if (quantity > 1) {
                          setState(() {
                            quantity--;
                          });
                        }
                      },
                    ),
                    Text(
                      quantity.toString(),
                      style: TextStyle(fontSize: 18),
                    ),
                    IconButton(
                      icon: Icon(Icons.add),
                      onPressed: () {
                        setState(() {
                          quantity++;
                        });
                      },
                    ),
                  ],
                ),

                // Buy Button
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding:
                        EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                    backgroundColor: Colors.blueAccent,
                  ),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                            "Bought $quantity bottle${quantity > 1 ? 's' : ''} of water!"),
                      ),
                    );
                  },
                  child: Text("Buy",style: TextStyle(color: Colors.white),),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
