import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/products_provider.dart';
import './product_item.dart';

class ProductsGrid extends StatelessWidget {

  final bool showFavs;

  ProductsGrid(this.showFavs);
 
  @override
  Widget build(BuildContext context) {
   final productsData = Provider.of<ProductsProvider>(context);
   final products= showFavs ? productsData.favoriteItems : productsData.items;

    return GridView.builder(
      padding: const EdgeInsets.all(10),
      itemBuilder: (ctx,i) => ChangeNotifierProvider.value(
        value: products[i],                                   //Automatically cleans data when not in use
        //create: (c)=> products[i],
        child: ProductItem(
          // title: products[i].title,
          // id: products[i].id,
          // imageUrl: products[i].imageUrl,
        ),
      ) ,
      itemCount: products.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3/2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10
      ),
    );
  }
}