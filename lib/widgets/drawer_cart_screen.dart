import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/orders_screen.dart';
import '../screens/user_products_screen.dart';
import '../providers/auth.dart';

class DrawerCartScreen extends StatelessWidget {

  Widget listTileBuilder({String title, IconData icon , Function handler}){
    return ListTile(
          leading: Icon(icon),
          title: Text(title),
          onTap: handler,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child:Column(
        children: <Widget>[
          AppBar(
          title: Text('Hello World'),
          automaticallyImplyLeading: false,
        ),
        Divider(),
        listTileBuilder(title: 'My Shop',icon: Icons.shop,handler: (){
          Navigator.of(context).pushReplacementNamed('/');
        }),
        Divider(),
        listTileBuilder(
          title: 'My Orders',
          icon: Icons.payment,
          handler: (){
            Navigator.of(context).pushReplacementNamed(OrdersScreen.routeName);
          }
        ),
        Divider(),
        listTileBuilder(
          title: 'Manage Products',
          icon: Icons.edit,
          handler: (){
            Navigator.of(context).pushReplacementNamed(UserProductScreen.routeName);
          }
        ),
        Divider(),
        listTileBuilder(
          title: 'logout',
          icon: Icons.exit_to_app,
          handler: (){
            Navigator.of(context).pop();                  //To close Drawer
            Navigator.of(context).pushReplacementNamed('/');
            Provider.of<Auth>(context,listen: false).logout();
          }
        )
        ],
      ) 
    );

  }
}