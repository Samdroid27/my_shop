import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../providers/orders.dart';
import '../widgets/order_product.dart';
import '../widgets/drawer_cart_screen.dart';

class OrdersScreen extends StatelessWidget {
  static const routeName = '/OrdersScreen';

 @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Your Orders'),
        ),
        drawer: DrawerCartScreen(),
        body: FutureBuilder(
          future:
              Provider.of<Orders>(context, listen: false).fetchAndSetOrders(),
          builder: (ctx, dataSnapshot) {
            if (dataSnapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else {
              if (dataSnapshot.error != null) {
                return Center(
                  child: Text('An error occured'),
                );
              } else {
                return Consumer<Orders>(
                  builder: (ctx, ordersData, child) => ListView.builder(
                    itemCount: ordersData.orders.length,
                    itemBuilder: (ctx, i) => OrderProduct(ordersData.orders[i]),
                  ),
                );
              }
            }
          },
        ));
  }
}
