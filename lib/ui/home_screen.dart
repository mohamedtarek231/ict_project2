import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/data/data_source/product_data_source.dart';
import 'package:flutter_application_1/ui/login_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    ProductDataSource.getProductsData().then((v) {
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            'Hello ${FirebaseAuth.instance.currentUser?.email ?? 'not found'}'),
        actions: [
          IconButton(
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                  (route) => false,
                );
              },
              icon: const Icon(Icons.logout))
        ],
      ),
      body: ProductDataSource.isLoading
          ? const Center(child: CircularProgressIndicator())
          : ProductDataSource.isError
              ? const Center(
                  child: Text('failed to fetch data'),
                )
              : ProductDataSource.ListOfProduct.isEmpty
                  ? const Center(
                      child: Text('no data found'),
                    )
                  : ListView.builder(
                      itemCount: ProductDataSource.ListOfProduct.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: Image.network(
                            ProductDataSource.ListOfProduct[index].image ?? '',
                            width: 50,
                            height: 100,
                          ),
                          title: Text(
                            ProductDataSource.ListOfProduct[index].title ??
                                'no title',
                            maxLines: 1,
                          ),
                          subtitle: Text(
                            ProductDataSource
                                    .ListOfProduct[index].description ??
                                'no description',
                            maxLines: 2,
                          ),
                          trailing: Text(
                              '${ProductDataSource.ListOfProduct[index].price ?? 0.0}'),
                        );
                      },
                    ),
    );
  }
}
