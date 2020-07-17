import 'dart:convert';

import 'package:flutter/material.dart';
import 'order.dart';
import 'package:http/http.dart' as http;

class OrderDetailScreen extends StatefulWidget {
  final Order order;

  const OrderDetailScreen({Key key, this.order}) : super(key: key);
  @override
  _OrderDetailScreenState createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {
  List _orderdetails;
  String titlecenter = "Loading...";
  double screenHeight, screenWidth;

  @override
  void initState() {
    super.initState();
    _loadOrderDetails();
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Order Details',
          style: TextStyle(
            fontFamily: 'Solway',
          ),
        ),
        backgroundColor: Colors.indigo,
      ),
      body: Center(
        child: Container(
          width: 360, height: 450,
          child: Card(
            elevation: 10,
            child: Center(
              child: Column(children: <Widget>[
                
                Row(children: <Widget>[
                  Padding(
                    padding: EdgeInsets.fromLTRB(30, 10, 0, 0),
                    child: Text(
                      'Order ID: ' + widget.order.orderid,
                      textAlign: TextAlign.start,
                      style: TextStyle(fontFamily: 'Solway'),
                    ),
                  )
                ]),
                Row(children: <Widget>[
                  Padding(
                    padding: EdgeInsets.fromLTRB(30, 10, 0, 0),
                    child: Text(
                      'Bill ID: ' + widget.order.billid,
                      textAlign: TextAlign.start,
                      style: TextStyle(fontFamily: 'Solway'),
                    ),
                  ),
                ]),
                Row(children: <Widget>[
                  Padding(
                    padding: EdgeInsets.fromLTRB(30, 10, 0, 0),
                    child: Text(
                      'Total Amount: RM ' + widget.order.total + ".00",
                      textAlign: TextAlign.end,
                      style: TextStyle(fontFamily: 'Solway'),
                    ),
                  ),
                ]),
                SizedBox(height: 50,),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 1),
                  child: Table(
                    defaultColumnWidth: FlexColumnWidth(1),
                    columnWidths: {
                      0: FlexColumnWidth(0.1),
                      1: FlexColumnWidth(0.1),
                    },
                    children: [
                      TableRow(
                        children: [
                          TableCell(
                            child: Container(
                                alignment: Alignment.centerLeft,
                                height: 30,
                                child: Text("   Item ",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Solway',
                                        color: Colors.black))),
                          ),
                          TableCell(
                            child: Container(
                                alignment: Alignment.centerLeft,
                                height: 30,
                                child: Text(
                                  "            Quantity ",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Solway',
                                      color: Colors.black),
                                )),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                _orderdetails == null
                    ? Flexible(
                        child: Container(
                            child: Center(
                                child: Text(
                        titlecenter,
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Solway',
                            fontSize: 22,
                            fontWeight: FontWeight.bold),
                      ))))
                    : Expanded(
                        child: ListView.builder(
                            itemCount: _orderdetails == null
                                ? 0
                                : _orderdetails.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                  padding: EdgeInsets.fromLTRB(10, 1, 10, 1),
                                  child: InkWell(
                                      onTap: null,
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 40.0, vertical: 1),
                                        child: Table(
                                          border: TableBorder(
                                              bottom: BorderSide(
                                            color: Colors.blue,
                                            width: 1,
                                          )),
                                          defaultColumnWidth:
                                              FlexColumnWidth(1),
                                          columnWidths: {
                                            0: FlexColumnWidth(0.1),
                                            1: FlexColumnWidth(0.1),
                                          },
                                          children: [
                                            TableRow(
                                              children: [
                                                TableCell(
                                                  child: Container(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    height: 40,
                                                    child: Text(
                                                      _orderdetails[index]
                                                          ['name'],
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontFamily: 'Solway',
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                TableCell(
                                                  child: Container(
                                                    alignment: Alignment.center,
                                                    height: 30,
                                                    child: Text(
                                                      '     ' +
                                                          _orderdetails[index]
                                                              ['cquantity'],
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontFamily: 'Solway',
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      )));
                            }))
              ]),
            ),
          ),
        ),
      ),
    );
  }

  _loadOrderDetails() async {
    String urlLoadJobs =
        "https://justminedb.com/mobileminer/php/load_carthistory.php";
    await http.post(urlLoadJobs, body: {
      "orderid": widget.order.orderid,
    }).then((res) {
      print(res.body);
      if (res.body == "nodata") {
        setState(() {
          _orderdetails = null;
          titlecenter = "No Previous Payment";
        });
      } else {
        setState(() {
          var extractdata = json.decode(res.body);
          _orderdetails = extractdata["carthistory"];
        });
      }
    }).catchError((err) {
      print(err);
    });
  }
}
