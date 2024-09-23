import 'package:flutter/material.dart';
import 'package:flutter_application_1/data/data_source/signup_data_source.dart';
import 'package:flutter_application_1/ui/widgets/card_info_user.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: FutureBuilder(
        future: SignupDataSource.getUserData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.connectionState == ConnectionState.done) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Name',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                CardInfoUser(text: snapshot.data?.name),
                SizedBox(
                  height: 10,
                ),
                const Text(
                  'Phone',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                CardInfoUser(text: snapshot.data?.phone.toString()),
                SizedBox(
                  height: 10,
                ),
                const Text(
                  'Email',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                CardInfoUser(text: snapshot.data?.email),
              ],
            );
          } else {
            return Text('cant fetch user data');
          }
        },
      ),
    );
  }
}
