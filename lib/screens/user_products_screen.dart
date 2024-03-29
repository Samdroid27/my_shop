import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/products_provider.dart';
import '../widgets/user_product_item.dart';
import '../widgets/drawer_cart_screen.dart';
import './edit_product_screen.dart';

class UserProductScreen extends StatelessWidget {
  static const routeName = '/UserProductScreen';

  Future<void> _refreshProducts(BuildContext context) async {
    await Provider.of<ProductsProvider>(context,listen: false).fetchAndSetProducts(true);
  }

  @override
  Widget build(BuildContext context) {
    //  final productsData = Provider.of<ProductsProvider>(context);
  
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Products'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(EditProductScreen.routeName);
            },
          )
        ],
      ),
      drawer: DrawerCartScreen(),
      body: FutureBuilder(
        future: _refreshProducts(context),
        builder: (ctx, snapshot) =>
            snapshot.connectionState == ConnectionState.waiting
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : RefreshIndicator(
                    onRefresh: () => _refreshProducts(context),
                    child: Consumer<ProductsProvider>(
                      builder: (ctx, productsData, _) => Padding(
                        padding: EdgeInsets.all(8),
                        child: ListView.builder(
                          itemCount: productsData.items.length,
                          itemBuilder: (ctx, i) => Column(
                            children: <Widget>[
                              UserProductItem(
                                title: productsData.items[i].title,
                                imageUrl: productsData.items[i].imageUrl,
                                id: productsData.items[i].id,
                              ),
                              Divider()
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
      ),
    );
  }
}
