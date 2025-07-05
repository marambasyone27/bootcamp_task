import 'package:bootcamp_task/features/cart/screens/cart_screen.dart';
import 'package:bootcamp_task/features/home/cubit/productStates.dart';
import 'package:bootcamp_task/features/home/cubit/product_cubit.dart';
import 'package:bootcamp_task/features/home/screens/product_discreption.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.username});
  final String username;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  final PageController pageController = PageController();
  List<bool> isFavouriteList = [];

  final imageUrls = [
   // 'https://i.pinimg.com/736x/53/2a/a0/532aa0cb218cd4af414357640fac9580.jpg',
    'https://i.pinimg.com/originals/78/3f/94/783f940d3c83a4ab4f4857a4db53f18e.gif',
    'https://i.pinimg.com/736x/33/58/4c/33584cbfb7612f178a7621f22db91d3a.jpg',
    'https://i.pinimg.com/736x/c3/33/c5/c333c5d423db81805d13bab294eababd.jpg',
    'https://i.pinimg.com/736x/82/ff/70/82ff70603fbbefaa39d4f54d966bc216.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return BlocProvider(
      create: (context) => ProductCubit(Dio())..getAllProducts(),
      child: BlocConsumer<ProductCubit, Productstates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              actions: [
                Padding(
                  padding: EdgeInsets.only(right: screenSize.width * 0.06),
                  child: Row(
                    children: const [
                      Icon(Icons.search),
                      SizedBox(width: 7),
                      Icon(Icons.notification_add_sharp),
                    ],
                  ),
                )
              ],
              title: 

Row(
  crossAxisAlignment: CrossAxisAlignment.center,
  children: [
    Padding(
      padding:  EdgeInsets.only(top:screenSize.height * 0.01),
      child: CircleAvatar(
        radius: screenSize.width * 0.08,
        backgroundImage: NetworkImage(
          'https://i.pinimg.com/736x/83/5b/f2/835bf20a25dd4a78d9e9a8ffccda2dd8.jpg',
        ),
      ),
    ),

    SizedBox(width: screenSize.width * 0.04),
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Hi ${widget.username}',
          style: TextStyle(
            fontFamily: 'Pacifico',
            fontWeight: FontWeight.bold,
            fontSize: screenSize.width * 0.05,
          ),
        ),
        SizedBox(height: screenSize.height * 0.005),
        Text(
          "Let's go Shopping",
          style: TextStyle(
            fontSize: screenSize.width * 0.035,
            color: Colors.grey,
            fontFamily: 'RobotoMono',
          ),
        ),
      ],
    ),
  ],
),

            ),
             bottomNavigationBar: Container(
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
              child: BottomNavigationBar(
                currentIndex: _currentIndex,
                elevation: 8.0,
                type: BottomNavigationBarType.fixed,
                backgroundColor: Colors.transparent,
                iconSize: 28.0,
                selectedItemColor: Colors.white,
                unselectedItemColor: const Color.fromARGB(255, 237, 144, 175),
                selectedIconTheme:
                    const IconThemeData(size: 30, color: Colors.white),
                unselectedIconTheme: const IconThemeData(
                  size: 24,
                  color: const Color.fromARGB(255, 237, 144, 175),
                ),
                selectedFontSize: 20.0,
                unselectedFontSize: 12.0,
                selectedLabelStyle: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: 'RobotoMono',
                ),
                unselectedLabelStyle: const TextStyle(
                  fontWeight: FontWeight.w400,
                  fontFamily: 'RobotoMono',
                ),
                showSelectedLabels: true,
                showUnselectedLabels: true,
                mouseCursor: SystemMouseCursors.click,
                enableFeedback: true,
                landscapeLayout: BottomNavigationBarLandscapeLayout.centered,
                useLegacyColorScheme: false,
                items: [
                  BottomNavigationBarItem(
                      icon: Icon(Icons.home), label: 'Home'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.favorite_border_outlined),
                      label: 'Favorites'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.shopping_cart), label: 'Cart'),
                ],
                onTap: (index) {
                  setState(() {
                    _currentIndex = index;
                  });
                  if (index == 2) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const CartScreen()),
                      );
                    }
                },
              ),
            ),

            body: Builder(
              builder: (context) {
                if (state is ProductLoadingState) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is ProductErrorState) {
                  return Center(
                    child: Text(
                      state.errorMessage.isNotEmpty
                          ? state.errorMessage
                          : "OOPS, something went wrong, try again",
                      style: const TextStyle(
                        color: Colors.red,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                } else if (state is ProductSuccessState) {
                  final products = state.allProducts;
                  if (isFavouriteList.length != products.length) {
                    isFavouriteList = List<bool>.filled(products.length, false);
                  }

                  return SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        children: [
                          SizedBox(
                            height: screenSize.height * 0.25,
                            width: screenSize.width,
                            child: PageView.builder(
                              controller: pageController,
                              itemCount: imageUrls.length,
                              itemBuilder: (context, index) => Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Colors.black12,
                                        blurRadius: 8,
                                        offset: Offset(0, 4),
                                      ),
                                    ],
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: Image.network(
                                      imageUrls[index],
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),
                          SmoothPageIndicator(
                            controller: pageController,
                            count: imageUrls.length,
                            effect: const ExpandingDotsEffect(
                              dotColor: Colors.grey,
                              activeDotColor: Colors.pink,
                              dotHeight: 10,
                              dotWidth: 10,
                            ),
                          ),
                          SizedBox(height: screenSize.height * 0.03),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'New Arrivals🔥',
                                style: TextStyle(
                                  fontFamily: 'Pacifico',
                                  fontWeight: FontWeight.bold,
                                  fontSize: screenSize.width * 0.07,
                                ),
                              ),
                              Text(
                                'See All',
                                style: TextStyle(
                                  fontFamily: 'Pacifico',
                                  fontWeight: FontWeight.bold,
                                  fontSize: screenSize.width * 0.04,
                                  color: Colors.red,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: screenSize.height * 0.03),
                          GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            padding: const EdgeInsets.all(5),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 0.85,
                              crossAxisSpacing: 12,
                              mainAxisSpacing: 12,
                            ),
                            itemCount: products.length,
                            itemBuilder: (context, index) {
                              final product = products[index];
                              return GestureDetector(
                                onTap: () {
                                   Navigator.push(context, MaterialPageRoute(builder: (context) => ProductDiscreption(
                                    title: product.title,
                                    imageUrl: product.imageUrl,
                                    price: product.price,
                                    description: product.description,
                                    rating: product.rating,
                                    discountPercentage: product.discountPercentage,
                                    category: product.category,
                                    )));
                                },
                                child: Card(
                                  shadowColor: Colors.pink.withOpacity(0.5),
                                  surfaceTintColor:
                                      const Color.fromARGB(255, 215, 47, 103),
                                  color: Colors.white,
                                  elevation: 5,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Column(
                                    children: [
                                      Stack(
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            child: CachedNetworkImage(
                                              imageUrl: product.imageUrl ??
                                                  'https://via.placeholder.com/150',
                                              width: double.infinity,
                                              height: screenSize.height * 0.13,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          Align(
                                            alignment: Alignment.topRight,
                                            child: IconButton(
                                              icon: Icon(
                                                isFavouriteList[index]
                                                    ? Icons.favorite
                                                    : Icons.favorite_border_outlined,
                                                color: isFavouriteList[index]
                                                    ? Colors.red
                                                    : Colors.pinkAccent,
                                              ),
                                              onPressed: () {
                                                setState(() {
                                                  isFavouriteList[index] =
                                                      !isFavouriteList[index];
                                                });
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                      Text(
                                        product.title ?? 'No title',
                                        style: TextStyle(
                                          fontFamily: 'Pacifico',
                                          fontSize: screenSize.width * 0.04,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black87,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Text(
                                        product.category ?? 'No category',
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: screenSize.width * 0.04,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.grey,
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            '${product.price?.toStringAsFixed(2) ?? '0.00'} \$',
                                            style: TextStyle(
                                              fontFamily: 'Lobster',
                                              fontSize: screenSize.width * 0.04,
                                              fontWeight: FontWeight.bold,
                                              color: const Color.fromARGB( 255, 215, 47, 103),
                                            ),
                                          ),
                                          SizedBox(width: screenSize.width * 0.04),
                                           Text(
                                                            '${product.rating?.toStringAsFixed(1) ?? '0.0'} ⭐',
                                                            style:
                                                                TextStyle(
                                                              fontSize:screenSize.width * 0.04,
                                                              color: Colors.amber,
                                                            ),
                                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                          
                        ],
                      ),
                    ),
                  );
                } else {
                  return const SizedBox.shrink();
                }
              },
            ),
          );
        },
      ),
    );
  }
}
