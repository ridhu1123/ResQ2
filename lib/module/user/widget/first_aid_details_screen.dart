import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resq_application/module/admin/controller/admin_home_controller.dart';


class ProductDetailPage extends StatefulWidget {
  final String image;
  final String rate;
  final int count;
  final String id;
  const ProductDetailPage({super.key,required this.image,required this.rate,required this.count,required this.id});

  @override
  ProductDetailPageState createState() => ProductDetailPageState();
}

class ProductDetailPageState extends State<ProductDetailPage> {
  int quantity = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("First Aid Detail",style: TextStyle(color: Colors.white),),
        // centerTitle: true,
        foregroundColor: Colors.white,
        backgroundColor:Color(0xff0C3B2E) ,
      ),
      body: Consumer<AdminHomeController>(
        builder: (context,controller,_) {
          return
          controller.buyLoad?
          Center(
            child: CircularProgressIndicator(),
          )
          : Column(
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
                      "₹ ${widget.rate}",
                      style: TextStyle(fontSize: 20, color: Colors.green),
                    ),
                  ],
                ),
              ),
          
              Spacer(),
          
              // 3. Bottom Cart Section
            widget.count==0?
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 5)],
                ),
                child: Center(child: Text('Out of stock',style: TextStyle(color: Colors.red,fontSize: 20),)),
            )
            :  Container(
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
                    controller.buyLoad?
                    CircularProgressIndicator()
                    :ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding:
                            EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                        backgroundColor: Color(0xff0C3B2E),
                      ),
                      onPressed: () {
                       controller.changeFirsAidCount(changeCount: quantity,id:widget.id ).whenComplete(() {
                          controller.fetchAllFirstAids();
                          quantity=1;
                        },);
                        // ScaffoldMessenger.of(context).showSnackBar(
                        //   SnackBar(
                        //     content: Text(
                        //         "Bought $quantity bottle${quantity > 1 ? 's' : ''} of water!"),
                        //   ),
                        // );
                      },
                      child: Text("Buy",style: TextStyle(color: Colors.white),),
                    )
                  ],
                ),
              ),
            ],
          );
        }
      ),
    );
  }
}
