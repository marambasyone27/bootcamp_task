import 'package:bootcamp_task/core/routing/routes.dart';
import 'package:bootcamp_task/features/home/screens/home_screen.dart';
import 'package:bootcamp_task/features/home/screens/product_discreption.dart';
import 'package:bootcamp_task/features/login/views/login_screen.dart';
import 'package:bootcamp_task/features/startScreens/onboarding.dart';
import 'package:bootcamp_task/features/startScreens/splash_screen.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  Route generateRoute(RouteSettings settings){
    switch(settings.name){
      case Routes.splashScreen:
       return MaterialPageRoute(builder: (_)=> SplashScreen());
       case Routes.onboardingScreen:
       return MaterialPageRoute(builder: (_)=> Onboarding());
       case Routes.homeScreen:
       return MaterialPageRoute(builder: (_)=> HomeScreen(username: '',));
       case Routes.productDiscreption:
       return MaterialPageRoute(builder: (_)=> ProductDiscreption());
       case Routes.loginScreen:
       return MaterialPageRoute(builder: (_)=> LoginScreen());
       default:
    return MaterialPageRoute(builder: 
    (_)=> Scaffold(
      body: Center(
        child: Text('No route defined for ${settings.name}'),
      ),
    )
    );
    }
    
  }
}