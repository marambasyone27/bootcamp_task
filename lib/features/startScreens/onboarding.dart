import 'package:bootcamp_task/features/login/views/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  final PageController pageController = PageController();
  bool isLast = false;

  List<String> images = [
    'https://cdn.dummyjson.com/product-images/beauty/essence-mascara-lash-princess/1.webp',
    'https://cdn.dummyjson.com/product-images/beauty/red-nail-polish/1.webp',
    'https://cdn.dummyjson.com/product-images/fragrances/gucci-bloom-eau-de/3.webp',
    'https://cdn.dummyjson.com/product-images/groceries/ice-cream/1.webp',
     "https://cdn.dummyjson.com/product-images/groceries/kiwi/1.webp"
  ];

  List<String> title = [
    "Essence Mascara Lash Princess",
    "Red Nail Polish",
    "Gucci Bloom Eau de",
    "Ice Cream",
    "Kiwi"
  ];

  List<String> descriptions = [
    "The Essence Mascara Lash Princess is a popular mascara known for its volumizing and lengthening effects.",
    "The Red Nail Polish offers a rich and glossy red hue for vibrant and polished nails.",
    "Gucci Bloom by Gucci is a floral and captivating fragrance.",
    "Creamy and delicious ice cream, available in various flavors.",
    "Nutrient-rich kiwi, perfect for snacking or adding a tropical twist to your dishes.",
  ];

  void goToLogin() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => LoginScreen()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        actions: [
          TextButton(
            onPressed: goToLogin,
            child: const Text(
              "Skip",
              style: TextStyle(
                color: Colors.pink,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          )
        ],
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: PageView.builder(
                  controller: pageController,
                  itemCount: images.length,
                  onPageChanged: (index) {
                    setState(() {
                      isLast = index == images.length - 1;
                    });
                  },
                  itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(screen.width * 0.05),
                          child: Container(
                            height: screen.height * 0.5,
                            width: screen.width * 0.9,
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: const Color.fromARGB(255, 248, 225, 235),
                                  blurRadius: 8,
                                  offset: Offset(0, 4),
                                ),
                              ],
                              image: DecorationImage(
                                image: NetworkImage(images[index]),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: screen.height * 0.03),
                        Text(
                          title[index],
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: screen.width * 0.06,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                            fontFamily: 'RobotoMono',
                          ),
                        ),
                        SizedBox(height: screen.height * 0.02),
                        Text(
                          descriptions[index],
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: screen.width * 0.045,
                            color: Colors.grey,
                            fontFamily: 'RobotoMono',
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SmoothPageIndicator(
                controller: pageController,
                count: descriptions.length,
                effect: const ExpandingDotsEffect(
                  dotColor: Colors.grey,
                  activeDotColor: Colors.pink,
                  dotHeight: 10,
                  dotWidth: 10,
                ),
              ),
              SizedBox(height: screen.height * 0.07),
            ],
          ),
          if (isLast)
            SafeArea(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: EdgeInsets.only(bottom: screen.height * 0.05),
                  child: ElevatedButton(
                    onPressed: goToLogin,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.pink,
                      padding: EdgeInsets.symmetric(
                        horizontal: screen.width * 0.2,
                        vertical: screen.height * 0.015,
                      ),
                    ),
                    child: Text(
                      "Get Start (Login)",
                      style: TextStyle(
                        fontSize: screen.width * 0.045,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'RobotoMono',
                      ),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
