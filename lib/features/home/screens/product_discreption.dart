import 'package:bootcamp_task/features/cart/cubit/cart_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductDiscreption extends StatelessWidget {
  const ProductDiscreption({
    super.key,
    this.title,
    this.description,
    this.imageUrl,
    this.price,
    this.category,
    this.rating,
    this.discountPercentage,
  });

  final String? title;
  final String? description;
  final String? imageUrl;
  final double? price;
  final String? category;
  final double? rating;
  final double? discountPercentage;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        actions: [
          Icon(Icons.shopping_bag_sharp),
        ],
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.transparent,
        elevation: 0,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 175, 128, 111),
                Color.fromARGB(255, 215, 47, 103),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        centerTitle: true,
        title: Text(
          'Details Product',
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'Pacifico',
            fontSize: screenSize.width * 0.05,
            fontWeight: FontWeight.bold,
            shadows: const [
              Shadow(
                color: Color.fromARGB(255, 151, 30, 70),
                offset: Offset(2.0, 2.0),
                blurRadius: 3.0,
              ),
            ],
          ),
        ),
      ),
      body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: screenSize.height * 0.02),
              ClipRRect(
      borderRadius: BorderRadius.circular(25),
      child: Container(
        height: screenSize.height * 0.4,
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(imageUrl!),
            fit: BoxFit.cover,
          ),
        ),
      ),
    ),
              SizedBox(height: screenSize.height * 0.01),
          Expanded(
      child: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 8,
              offset: Offset(0, -2),
            )
          ],
        ),
        child: SingleChildScrollView(
          padding: EdgeInsets.all(screenSize.width * 0.05),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
                     Text(
                        title ?? '',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: screenSize.width * 0.045,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    
                    SizedBox(height: screenSize.height * 0.01),
                    Text(
                      "Color",
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: screenSize.width * 0.05,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                      SizedBox(height: screenSize.height * 0.01),
                        Row(
                      children: [
                    CircleAvatar(backgroundColor: Colors.black,
                       child: Icon(Icons.check , color: Colors.white,),
                      radius: screenSize.width * 0.04,
                    ),
                    SizedBox(width: screenSize.width * 0.02),
                    CircleAvatar(backgroundColor: Colors.pinkAccent,
                      radius: screenSize.width * 0.04,
                    ),
                    SizedBox(width: screenSize.width * 0.02),
                    CircleAvatar(backgroundColor: Colors.green,
                      radius: screenSize.width * 0.04,
                    ),
                       SizedBox(width: screenSize.width * 0.02),
                    CircleAvatar(backgroundColor: Colors.brown,
                      radius: screenSize.width * 0.04,
                    ), 
                      ],
                    ),
                     SizedBox(height: screenSize.height * 0.01),
                    Text(
                      "Discription",
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: screenSize.width * 0.05,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      description ?? '',
                      style: TextStyle(
                        fontSize: screenSize.width * 0.038,
                        fontFamily: 'Poppins',
                        color: Colors.grey[700],
                      ),
                    ),
                    SizedBox(height: screenSize.height * 0.02),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${discountPercentage?.toStringAsFixed(2)}% off',
                          style: TextStyle(
                            color: Colors.pink,
                            fontSize: screenSize.width * 0.055,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          ' ${rating?.toStringAsFixed(1)} ⭐',
                          style: TextStyle(
                            fontSize: screenSize.width * 0.055,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: screenSize.height * 0.03),
                    Text(
                      "Price",
                      style: TextStyle(
                        fontSize: screenSize.width * 0.04,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey[600],
                      ),
                    ),
                    SizedBox(height: screenSize.height * 0.01),
                    
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '\$ ${price?.toStringAsFixed(2)}',
                              style: TextStyle(
                                fontSize: screenSize.width * 0.055,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                             SizedBox(
                        width: screenSize.width * 0.55, 
                        height: screenSize.height * 0.06,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: EdgeInsets.symmetric(
                              horizontal: screenSize.width * 0.04,
                            ),
                          ),
                          onPressed: () {
                            context.read<CartCubit>().addItem({
                              'picture': imageUrl,
                              'title': title,
                              'price': price,
                            });
                    
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                backgroundColor: Color.fromARGB(255, 253, 157, 198),
                                content: Text(
                    "This product has been added to cart successfully ✅",
                                ),
                                duration: Duration(seconds: 2),
                              ),
                            );
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center, 
                            children: [
                              Icon(
                                Icons.shopping_cart,
                                color: Colors.white,
                              ),
                              SizedBox(width: screenSize.width * 0.02),
                              Text(
                                "Add to cart",
                                style: TextStyle(
                    color: Colors.white,
                    fontSize: screenSize.width * 0.045,
                    fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                          ],
                        ),
                  ],
                ),
              ),
      )
          )
            ],
          ),
        
      
    );
  }
}
