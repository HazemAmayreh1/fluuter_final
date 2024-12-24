import 'package:flutter/material.dart';
import 'package:sqllite/database_provider.dart';

class DetailsPage extends StatelessWidget {
 
  int id ; 
  DetailsPage(this.id, {super.key} );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product Details'),
      ),
      body:FutureBuilder(
        future: DatabaseProvider.db.getProduct(id),
         builder: (context , snapshot){
          if(snapshot.hasData){
              return Text(snapshot.data.toString(),style: TextStyle(fontSize: 26),);
          }
           else if (snapshot.hasError){
            return Text('error ${snapshot.error}');
          }
          else{
           return  CircularProgressIndicator();
          }

         }
      
         ) ,
    );
  }
}