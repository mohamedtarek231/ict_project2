import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/data/data_source/upload_products_firebase.dart';
import 'package:flutter_application_1/data/product_data_model.dart';
import 'package:flutter_application_1/ui/login_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // @override
  // void initState() {
  //   super.initState();
  //   ProductDataSource.getProductsData().then((v) {
  //     setState(() {});
  //   });
  // }

  // @override
  // void dispose() {
  //   super.dispose();
  // }

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
      body: FutureBuilder<List<ProductDataModel>>(
        future: UploadProductsFirebase().getProductsFromFirebase(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.connectionState == ConnectionState.done) {
            return snapshot.data?.length == 0
                ? const Center(
                    child: Text('Not Data Exists'),
                  )
                : ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: Image.network(
                          snapshot.data?[index].image ?? '',
                          width: 50,
                          height: 100,
                        ),
                        title: Text(
                          snapshot.data?[index].title ?? 'no Title',
                          maxLines: 1,
                        ),
                        subtitle: Text(
                          snapshot.data?[index].description ?? 'no Description',
                          maxLines: 2,
                        ),
                        trailing: Text('\$${snapshot.data?[index].price}'),
                      );
                    },
                  );
          }
          return const Text('field to fetch products');
        },
      ),
      // body: ProductDataSource.isLoading
      //     ? const Center(child: CircularProgressIndicator())
      //     : ProductDataSource.isError
      //         ? const Center(
      //             child: Text('failed to fetch data'),
      //           )
      //         : ProductDataSource.ListOfProduct.isEmpty
      //             ? const Center(
      //                 child: Text('no data found'),
      //               )
      //             : ListView.builder(
      //                 itemCount: ProductDataSource.ListOfProduct.length,
      //                 itemBuilder: (context, index) {
      //                   return ListTile(
      //                     leading: Image.network(
      //                       ProductDataSource.ListOfProduct[index].image ?? '',
      //                       width: 50,
      //                       height: 100,
      //                     ),
      //                     title: Text(
      //                       ProductDataSource.ListOfProduct[index].title ??
      //                           'no title',
      //                       maxLines: 1,
      //                     ),
      //                     subtitle: Text(
      //                       ProductDataSource
      //                               .ListOfProduct[index].description ??
      //                           'no description',
      //                       maxLines: 2,
      //                     ),
      //                     trailing: Text(
      //                         '${ProductDataSource.ListOfProduct[index].price ?? 0.0}'),
      //                   );
      //                 },
      //               ),
    );
  }
}
