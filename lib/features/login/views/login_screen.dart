import 'package:bootcamp_task/core/routing/routes.dart';
import 'package:bootcamp_task/features/home/screens/home_screen.dart';
import 'package:bootcamp_task/features/login/cubit/login_States.dart';
import 'package:bootcamp_task/features/login/cubit/login_cubit.dart';
import 'package:bootcamp_task/features/login/widgets/custom_TextFormField.dart';
import 'package:bootcamp_task/features/login/widgets/custom_button.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
bool isPasswordVisible = false;

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return BlocProvider(
      create: (context) => LoginCubit(Dio()),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) {
          if (state is LoginSuccessSate) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                duration: const Duration(seconds: 2),
                backgroundColor: Colors.pinkAccent,
                content: const Text(
                  "Great Login Successful",
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.bold),
                ),
              ),
            );
            Future.delayed(const Duration(seconds: 4), () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                    builder: (context) => HomeScreen(
                          username: usernameController.text,
                        )),
                (route) => false,
              );
            });
          } else if (state is LoginLoadingState) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                backgroundColor: Colors.pinkAccent,
                content: Text(
                  "Please wait",
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.bold),
                ),
              ),
            );
          } else if (state is LoginErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: Colors.pinkAccent,
                content: Text(
                  state.errorMessage.isNotEmpty
                      ? state.errorMessage
                      : "OOPS Login failed, try again",
                  style: const TextStyle(
                      color: Colors.white,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.bold),
                ),
              ),
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
            body: SafeArea(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(
                  vertical: screenSize.height * 0.04,
                  horizontal: screenSize.width * 0.06,
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: screenSize.height * 0.01),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          'Login Account',
                          style: TextStyle(
                            fontFamily: 'Pacifico',
                            fontWeight: FontWeight.bold,
                            fontSize: screenSize.width * 0.07,
                          ),
                        ),
                      ),
                      SizedBox(height: screenSize.height * 0.01),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Please log in first to start shopping in Trendy Store',
                          style: TextStyle(
                            fontSize: screenSize.width * 0.035,
                            color: Colors.grey,
                            fontFamily: 'RobotoMono',
                          ),
                        ),
                      ),
                      SizedBox(height: screenSize.height * 0.04),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Email or Username',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: screenSize.width * 0.045,
                            fontFamily: 'RobotoMono',
                          ),
                        ),
                      ),
                      SizedBox(height: screenSize.height * 0.015),
                      TextFormField(
                        controller: usernameController,
                        decoration: InputDecoration(
                          prefixIcon:
                              const Icon(Icons.face, color: Colors.pinkAccent),
                          contentPadding: EdgeInsets.symmetric(
                            vertical: screenSize.height * 0.025,
                            horizontal: screenSize.width * 0.05,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide:
                                const BorderSide(color: Color(0xFFF5A9C2)),
                          ),
                          disabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: const BorderSide(
                                color: Color.fromARGB(255, 236, 144, 175)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: const BorderSide(color: Colors.pink),
                          ),
                          label: const Text('*Username*'),
                          labelStyle: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.brown,
                          ),
                          hintText: 'Enter your Username or Email',
                          hintStyle: const TextStyle(color: Colors.grey),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Username is required';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: screenSize.height * 0.035),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Password',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: screenSize.width * 0.045,
                            fontFamily: 'RobotoMono',
                          ),
                        ),
                      ),
                      SizedBox(height: screenSize.height * 0.015),
                      TextFormField(
                        obscureText: !isPasswordVisible,
                        controller: passwordController,
                        decoration: InputDecoration(
                          label: const Text('*Password*'),
                          labelStyle: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.brown,
                          ),
                          prefixIcon:
                              const Icon(Icons.lock, color: Colors.pinkAccent),
                          contentPadding: EdgeInsets.symmetric(
                            vertical: screenSize.height * 0.025,
                            horizontal: screenSize.width * 0.05,
                          ),
                          disabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: const BorderSide(
                                color: Color.fromARGB(255, 236, 144, 175)),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide:
                                const BorderSide(color: Color(0xFFF5A9C2)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: const BorderSide(color: Colors.pink),
                          ),
                          hintText: 'Create your password',
                          hintStyle: const TextStyle(color: Colors.grey),
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                isPasswordVisible = !isPasswordVisible;
                              });
                            },
                            icon: Icon(
                              isPasswordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Colors.pinkAccent,
                            ),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Password is required';
                          } else if (value.length < 8) {
                            return 'Password must be at least 8 characters';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: screenSize.height * 0.015),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {
                            showModalBottomSheet(
                              context: context,
                              backgroundColor:
                                  const Color.fromARGB(255, 234, 219, 224),
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(25)),
                              ),
                              builder: (BuildContext context) {
                                return Padding(
                                  padding: const EdgeInsets.all(20),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        'Forget Password',
                                        style: TextStyle(
                                          fontFamily: 'Pacifico',
                                          fontWeight: FontWeight.bold,
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.06,
                                        ),
                                      ),
                                      SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.01),
                                      Text(
                                        'Enter your Email or Phone number',
                                        style: TextStyle(
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.035,
                                          color: Colors.grey,
                                          fontFamily: 'RobotoMono',
                                        ),
                                      ),
                                      SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.02),
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          'Email or Phone number',
                                          style: TextStyle(
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.05,
                                            color: Colors.black,
                                            fontFamily: 'RobotoMono',
                                          ),
                                        ),
                                      ),
                                      custom_textFormField(
                                        controller: emailController,
                                        screenSize: screenSize,
                                        hintText:
                                            ' Enter yourphone number or Email',
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'email is required';
                                          }
                                          return null;
                                        },
                                        label: '*Email*',
                                      ),
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.pink,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(30),
                                          ),
                                        ),
                                        onPressed: () {},
                                        child: const Text(
                                          'Send code',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                          child: Text(
                            'Forgot Password?',
                            style: TextStyle(
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.037,
                              color: Colors.pink,
                              fontFamily: 'RobotoMono',
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: screenSize.height * 0.04),
                      state is LoginLoadingState
                          ? const Center(child: CircularProgressIndicator())
                          : SizedBox(
                              width: double.infinity,
                              height: screenSize.height * 0.07,
                              child: custom_button(
                                usernameController: usernameController,
                                passwordController: passwordController,
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    context.read<LoginCubit>().login(
                                          username: usernameController.text,
                                          password: passwordController.text,
                                        );
                                  }
                                },
                                text: 'Sign In',
                              ),
                            ),
                      SizedBox(height: screenSize.height * 0.05),
                      const Text(
                        'Or Using Other method',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                          fontFamily: 'RobotoMono',
                        ),
                      ),
                      SizedBox(height: screenSize.height * 0.025),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.network(
                            'https://i.pinimg.com/736x/8c/03/0b/8c030bd6bd7ee87ad41485e3c7598dd4.jpg',
                            width: 30,
                            height: 30,
                          ),
                          const SizedBox(width: 10),
                          const Text(
                            'Sign In With Google',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: screenSize.height * 0.025),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.network(
                            'https://i.pinimg.com/736x/1e/0f/37/1e0f37ff0a7161dbebf7550685b8b668.jpg',
                            width: 30,
                            height: 30,
                          ),
                          const SizedBox(width: 10),
                          const Text(
                            'Sign In With Facebook',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: screenSize.height * 0.04),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
