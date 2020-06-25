import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mobileminer/product.dart';
import 'package:mobileminer/mainscreen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:mobileminer/user.dart';

class InfoScreen extends StatefulWidget {
  final Product product;
  final User user;
  const InfoScreen({Key key, this.product, this.user}) : super(key: key);

  @override
  _InfoScreenState createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  double screenHeight, screenWidth;
  List productdata;
  int quantity = 1;
  String cartquantity = "0";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Product's Info",
          style: TextStyle(fontFamily: 'Solway',color: Colors.white),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.exit_to_app,
              color: Colors.white,
            ),
            onPressed: () {
              _onBackPress();
            },
          ),
        ],
        backgroundColor: Colors.indigo,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(height: 10),
            CachedNetworkImage(
              fit: BoxFit.fill,
              width: 200,
              imageUrl:
                  "https://justminedb.com/mobileminer/productimage/${widget.product.imagename}",
              placeholder: (context, url) => new CircularProgressIndicator(),
              errorWidget: (context, url, error) => new Icon(Icons.error),
            ),
            SizedBox(
              height: 15,
            ),
            Text(widget.product.name.toUpperCase(),
                style: TextStyle(fontFamily: 'Solway',
                  color: Colors.black,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                )),
            SizedBox(
              height: 15,
            ),
            Center(child:
            Container( width: 370,
            child: Card(
                child: Table(
                    border: TableBorder.all(color: Colors.black),
                    children: [
                  TableRow(children: [
                    TableCell(
                        child: Container(
                            alignment: Alignment.center,
                            height: 30,
                            child: Text(
                              'Price',
                              style: TextStyle(fontFamily: 'Solway',
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ))),
                    TableCell(
                      child: Container(
                        alignment: Alignment.center,
                        height: 30,
                        child: SingleChildScrollView(
                            child: Text('RM ' + widget.product.price,
                                style: TextStyle(fontFamily: 'Solway',
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black))),
                      ),
                    ),
                  ]),
                 
                  TableRow(children: [
                    TableCell(
                        child: Container(
                            alignment: Alignment.center,
                            height: 30,
                            child: Text('Brand',
                                style: TextStyle(fontFamily: 'Solway',
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black)))),
                    TableCell(
                        child: Container(
                            alignment: Alignment.center,
                            height: 30,
                            child: Text(widget.product.type,
                                style: TextStyle(fontFamily: 'Solway',
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black)))),
                  ]),
                ])),),),
           
          ],
        ),
      ),
    );
  }

  Future<bool> _onBackPress() async {
    Navigator.pop(
        context,
        MaterialPageRoute(
          builder: (context) => MainScreen(),
        ));
    return Future.value(false);
  }
}
