import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/edit_product_screen.dart';
import '../providers/products_provider.dart';

class UserProductItem extends StatelessWidget {
  final String title;
  final String imageUrl;
  final String id;

  UserProductItem({@required this.title, @required this.imageUrl,@required this.id});

  @override
  Widget build(BuildContext context) {
    final scaffold = Scaffold.of(context);
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(imageUrl),
      ),
      title: Text(
        title,
        textAlign: TextAlign.left,
      ),
      trailing: Container(
        width: 100,
        child: Row(children: <Widget>[
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              Navigator.of(context).pushNamed(
                EditProductScreen.routeName,
                arguments: id
              );
            },
            color: Theme.of(context).primaryColor,
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () async{
              try{
                await Provider.of<ProductsProvider>(context,listen: false).deleteProduct(id);
              }catch(error){
                scaffold.showSnackBar(SnackBar(
                  content:Text('Deleting failed!')
                ));
              }
              
            },
            color: Theme.of(context).errorColor,
          ),
        ]),
      ),
    );
  }
}
