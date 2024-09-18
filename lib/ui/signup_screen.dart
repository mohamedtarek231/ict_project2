import 'package:flutter/material.dart';
import 'package:flutter_application_1/data/data_source/signup_data_source.dart';
import 'package:flutter_application_1/ui/buttom_navigation_bar.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Signup'),
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
              if (!SignupDataSource.isLoading)
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
                        SignupDataSource.signup(
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
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(SignupDataSource.errorMessage),
                              backgroundColor: Colors.red,
                            ));
                          }
                          setState(() {});
                        });
                      }
                    },
                    child: const Text('Signup'))
              else
                const Center(child: CircularProgressIndicator())
            ],
          ),
        ),
      ),
    );
  }
}
