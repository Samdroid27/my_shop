import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/product_detail_screen.dart';
import '../providers/product.dart';
import '../providers/cart.dart';
import '../providers/auth.dart';

class ProductItem extends StatelessWidget {

  // final String id;
  // final String title;
  // final String imageUrl;

  // ProductItem({
  //   @required this.id,
  //   @required this.title,
  //   @required this.imageUrl
  // });

  @override
  Widget build(BuildContext context) {

    final prodItem =  Provider.of<Product>(context , listen: false);
    final cart = Provider.of<Cart>(context , listen: false);
    final authData = Provider.of<Auth>(context,listen: false);
    //using Consumer Provider instead of '.of(context)'
    //it needs only a widget that listens to changes 
    // child  in Consumer is the widget that does not listens to changes
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child : GestureDetector(
          onTap: (){ 
            Navigator.of(context).pushNamed(
              ProductDetailScreen.routeName,
              arguments: prodItem.id
            );
          },
          child: Image.network(
            prodItem.imageUrl,
            fit: BoxFit.cover,
            ),
        ),
        footer: GridTileBar(
          backgroundColor: Colors.black54,
          leading:Consumer<Product>(
            builder: (ctx,prodItem,child) => IconButton(
              splashColor: Theme.of(context).accentColor,
            icon: Icon(prodItem.isFavorite ?  Icons.favorite : Icons.favorite_border),
            color: Theme.of(context).accentColor,
            onPressed: (){
              prodItem.toggleFavorite(authData.token,authData.userId);
            },
          ),
          ) ,
          title: Text(
            prodItem.title,
            textAlign: TextAlign.center,
            ),
          trailing:  IconButton(
              splashColor: Theme.of(context).accentColor,
              icon: Icon(Icons.add_shopping_cart),
              color: Theme.of(context).accentColor,
              onPressed: (){
                cart.addItem(prodItem.id, prodItem.price, prodItem.title,1);
                //Scafold.of makes connection to nearest Scaffold
                Scaffold.of(context).hideCurrentSnackBar();
                Scaffold.of(context).showSnackBar(SnackBar(
                  content: Text('Added ${prodItem.title} to Cart',),
                  duration: Duration(seconds: 2),
                  action: SnackBarAction(
                    label: 'UNDO',
                    onPressed: (){
                      cart.removeSingleItem(prodItem.id);
                    },
                  ),
                ));
              },
            ),
          ),
        ),
    );
      
  }
}