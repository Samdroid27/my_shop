import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart.dart';

class CartProduct extends StatelessWidget {
  final String id;
  final String productId;
  final String title;
  final int quantity;
  final double price;

  CartProduct(
      {@required this.title,
      @required this.price,
      @required this.quantity,
      @required this.id,
      @required this.productId});

  Widget sweepContainer(BuildContext ctx, IconData icon, Alignment alignment) {
    return Container(
      color: Theme.of(ctx).errorColor,
      child: Icon(
        icon,
        color: Colors.white,
        size: 40,
      ),
      alignment: alignment,
      padding: EdgeInsets.only(right: 20),
    );
  }

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Cart>(context);

    return Dismissible(
      key: ValueKey(id),
      background:
          sweepContainer(context, Icons.delete_sweep, Alignment.centerLeft),
      secondaryBackground:
          sweepContainer(context, Icons.delete_outline, Alignment.centerRight),
      confirmDismiss: (direction) {
        if (direction == DismissDirection.startToEnd) {
          return showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
              title: Text('Are you Sure?'),
              content: Text(
                'Do you want to remove product from cart?',
                softWrap: true,
              ),
              actions: <Widget>[
                FlatButton(
                  child: Text('NO'),
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                ),
                FlatButton(
                  child: Text('YES'),
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                )
              ],
            ),
          );
        }
        else{
          return Future.value(true);
        }
      },
      onDismissed: (direction) {
        if (direction == DismissDirection.startToEnd) {
          product.removeItem(productId);
        } else {
          product.removeItem(productId);
          if (quantity > 1) {
            product.addItem(productId, price, title, quantity - 1);
          }
        }
      },
      child: Card(
        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
        child: Padding(
          padding: EdgeInsets.all(8),
          child: ListTile(
            leading: CircleAvatar(
              child: FittedBox(child: Text('₹$price')),
            ),
            title: Text(title),
            subtitle: Text('x $quantity'),
            trailing: Text('Total: ${price * quantity}'),
          ),
        ),
      ),
    );
  }
}
