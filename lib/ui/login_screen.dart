import 'package:flutter/material.dart';
import 'package:flutter_application_1/data/data_source/login_data_source.dart';
import 'package:flutter_application_1/ui/buttom_navigation_bar.dart';
import 'package:flutter_application_1/ui/signup_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: emailController,
                decoration: const InputDecoration(
                    labelText: 'Email', border: OutlineInputBorder()),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Email is required';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: passwordController,
                decoration: const InputDecoration(
                    labelText: 'Password', border: OutlineInputBorder()),
                validator: (value) {
                  if (value!.length < 6) {
                    return 'password must be at least 6 characters';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 20,
              ),
              if (!LoginDataSource.isLoading)
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(15),
                        backgroundColor: Colors.blue,
                        disabledBackgroundColor: Colors.black26,
                        foregroundColor: Colors.white,
                        disabledForegroundColor: Colors.black26),
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        setState(() {});
                        LoginDataSource.Login(
                                email: emailController.text,
                                password: passwordController.text)
                            .then((v) {
                          if (v) {
                            Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                builder: (context) =>
                                    const CustomBottomNavigationBar(),
                              ),
                              (route) => false,
                            );
                          } else {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: const Text('Error'),
                                  content: Text(LoginDataSource.errorMessage),
                                  actions: [
                                    TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text('ok'))
                                  ],
                                );
                              },
                            );
                          }
                          setState(() {});
                        });
                      }
                    },
                    child: const Text('Login'))
              else
                const Center(child: CircularProgressIndicator()),
              const SizedBox(
                height: 20,
              ),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const SignupScreen(),
                    ));
                  },
                  child: const Text('Create an account'))
            ],
          ),
        ),
      ),
    );
  }
}
