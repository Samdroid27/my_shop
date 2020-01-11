import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/order_item.dart';

class OrderProduct extends StatefulWidget {

  final OrderItem order;

  OrderProduct(this.order);

  @override
  _OrderProductState createState() => _OrderProductState();
}

class _OrderProductState extends State<OrderProduct> {

  var _expanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          ListTile(
            title: Text('₹${widget.order.amount}'),
            subtitle: Text(DateFormat('dd/MM/yyyy hh:mm').format(widget.order.dateTime)),
            trailing: IconButton(
              splashColor: Colors.black54,
              icon: Icon(_expanded ? Icons.expand_less : Icons.expand_more),
              onPressed: (){
                setState(() {
                  _expanded = !_expanded;
                });
              },
            ),
          ),
          if(_expanded) Container(
            padding: EdgeInsets.symmetric(horizontal: 15,vertical: 4),
            height: min(widget.order.products.length *20.0 + 10.0, 100),
            child:ListView.builder(
              itemCount: widget.order.products.length,
              itemBuilder: (ctx,i)=> Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(widget.order.products[i].title,style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold)),
                  Text('x${widget.order.products[i].quantity} (₹${widget.order.products[i].price})',style: TextStyle(fontSize: 18,color: Colors.grey),)
                ],
              ),
            )
          )
        ],
      ),
    );
  }
}