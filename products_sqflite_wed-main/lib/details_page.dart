import 'package:flutter/material.dart';
import 'database_provider.dart';

class DetailsPage extends StatelessWidget {
  const DetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product details'),
      ),
      body: FutureBuilder(
        future: DatabaseProvider.instance.getProduct(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Text(
              snapshot.data.toString(),
              style: TextStyle(fontSize: 23),
            );
          } else {
            return CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
