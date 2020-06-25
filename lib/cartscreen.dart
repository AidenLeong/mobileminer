import 'dart:async';
import 'dart:convert';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:mobileminer/user.dart';
import 'package:http/http.dart' as http;
import 'package:progress_dialog/progress_dialog.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:random_string/random_string.dart';
import 'accountscreen.dart';
import 'mainscreen.dart';
import 'paymentscreen.dart';
import 'package:intl/intl.dart';

class WishListScreen extends StatefulWidget {
  final User user;

  const WishListScreen({Key key, this.user}) : super(key: key);

  @override
  _WishListScreenState createState() => _WishListScreenState();
}

class _WishListScreenState extends State<WishListScreen> {
  List cartData;
  double screenHeight, screenWidth;

  double _totalprice = 0.0;
  final GlobalKey<ScaffoldState> _scaffold = new GlobalKey<ScaffoldState>();
    int _currentIndex = 0;

  String curaddress;
  GoogleMapController gmcontroller;
  MarkerId markerId1 = MarkerId("12");
  Set<Marker> markers = Set();
  double latitude, longitude;
  String label;
  double deliverycharge;
  double amountpayable;
  String titlecenter = "Loading cart...";
  @override
  void initState() {
    super.initState();
    //_getCurrentLocation();
    _loadCart();
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
        key: _scaffold,
        appBar: AppBar(
            backgroundColor: Colors.indigo,
            title: Text(
              'My Cart',
              style: TextStyle(
                fontFamily: 'Solway',
              ),
            ),
            actions: <Widget>[
              IconButton(
                icon: Icon(MdiIcons.deleteEmpty),
                onPressed: () {
                  deleteAll();
                },
              ),
            ]),
        body: WillPopScope(
            onWillPop: _onBackPressed,
            child: Container(
                child: Column(
              children: <Widget>[
                cartData == null
                    ? Flexible(
                        child: Container(
                            child: Center(
                                child: Text(
                        titlecenter,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 22,
                            fontFamily: 'Solway',
                            fontWeight: FontWeight.bold),
                      ))))
                    : Expanded(
                        child: ListView.builder(
                            itemCount:
                                cartData == null ? 1 : cartData.length + 2,
                            itemBuilder: (context, index) {
                              if (index == cartData.length) {
                                return Column(children: <Widget>[
                                  InkWell(
                                    onLongPress: () => {print("Delete")},
                                    child: Card(
                                      //color: Colors.yellow,
                                      elevation: 10,
                                      child: Column(
                                        children: <Widget>[
                                          SizedBox(
                                            height: 10,
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                ]);
                              }

                              if (index == cartData.length + 1) {
                                return Container(
                                    child: Card(
                                  elevation: 10,
                                  child: Column(
                                    children: <Widget>[
                                      SizedBox(
                                        height: 10,
                                      ),
                                      SizedBox(height: 10),
                                      Container(
                                          padding:
                                              EdgeInsets.fromLTRB(50, 0, 50, 0),
                                          child: Table(
                                              defaultColumnWidth:
                                                  FlexColumnWidth(1.0),
                                              columnWidths: {
                                                0: FlexColumnWidth(7),
                                                1: FlexColumnWidth(3),
                                              },
                                              children: [
                                                TableRow(children: [
                                                  TableCell(
                                                    child: Container(
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        height: 20,
                                                        child: Text(
                                                            "Subtotal Amount ",
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontFamily:
                                                                    'Solway',
                                                                color: Colors
                                                                    .black))),
                                                  ),
                                                  TableCell(
                                                    child: Container(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      height: 20,
                                                      child: Text(
                                                          "RM" +
                                                                  amountpayable
                                                                      .toStringAsFixed(
                                                                          2) ??
                                                              "0.0",
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontFamily:
                                                                  'Solway',
                                                              color: Colors
                                                                  .black)),
                                                    ),
                                                  ),
                                                ]),
                                                TableRow(children: [
                                                  TableCell(
                                                    child: Container(
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        height: 20,
                                                        child: Text("Taxes ",
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontFamily:
                                                                    'Solway',
                                                                color: Colors
                                                                    .black))),
                                                  ),
                                                  TableCell(
                                                    child: Container(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      height: 20,
                                                      child: Text("RM 0.00",
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontFamily:
                                                                  'Solway',
                                                              color: Colors
                                                                  .black)),
                                                    ),
                                                  ),
                                                ]),
                                                TableRow(children: [
                                                  TableCell(
                                                    child: Container(
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        height: 20,
                                                        child: Text(
                                                            "Total Amount ",
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontFamily:
                                                                    'Solway',
                                                                color: Colors
                                                                    .black))),
                                                  ),
                                                  TableCell(
                                                    child: Container(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      height: 20,
                                                      child: Text(
                                                          "RM" +
                                                                  amountpayable
                                                                      .toStringAsFixed(
                                                                          2) ??
                                                              "0.0",
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontFamily:
                                                                  'Solway',
                                                              color: Colors
                                                                  .black)),
                                                    ),
                                                  ),
                                                ]),
                                              ])),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      MaterialButton(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(5.0)),
                                        minWidth: 100,
                                        height: 40,
                                        child: Text(
                                          'Check out',
                                          style: TextStyle(
                                            fontFamily: 'Solway',
                                          ),
                                        ),
                                        color: Colors.blue,
                                        textColor: Colors.white,
                                        elevation: 10,
                                        onPressed: makePayment,
                                      ),
                                    ],
                                  ),
                                ));
                              }
                              index -= 0;

                              return Container(
                                  width: 10,
                                  child: Card(
                                      elevation: 10,
                                      child: Padding(
                                          padding: EdgeInsets.all(5),
                                          child: Row(children: <Widget>[
                                            IconButton(
                                              icon: Icon(Icons.cancel),
                                              onPressed: () =>
                                                  {_deleteCart(index)},
                                            ),
                                            Column(
                                              children: <Widget>[
                                                Container(
                                                  height: screenHeight / 7,
                                                  width: screenWidth / 4,
                                                  child: ClipRect(
                                                      child: CachedNetworkImage(
                                                    fit: BoxFit.scaleDown,
                                                    imageUrl:
                                                        "http://justminedb.com/mobileminer/productimage/${cartData[index]['id']}.jpg",
                                                    placeholder: (context,
                                                            url) =>
                                                        new CircularProgressIndicator(),
                                                    errorWidget: (context, url,
                                                            error) =>
                                                        new Icon(Icons.error),
                                                  )),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              width: 20,
                                            ),
                                            Container(
                                                width: screenWidth / 3.5,
                                                child: Row(
                                                  children: <Widget>[
                                                    Flexible(
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: <Widget>[
                                                          Text(
                                                            cartData[index]
                                                                ['name'],
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    'Solway',
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 14,
                                                                color: Colors
                                                                    .black),
                                                            
                                                          ),
                                                          SizedBox(
                                                            height: 1,
                                                          ),
                                                          Text(
                                                            "Quantity: " +
                                                                cartData[index][
                                                                    'cquantity'],
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontFamily:
                                                                  'Solway',
                                                              fontSize: 14,
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            height: 10,
                                                          ),
                                                          Text(
                                                              "Total: RM" +
                                                                  cartData[
                                                                          index]
                                                                      [
                                                                      'yourprice'],
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                      'Solway',
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: 14,
                                                                  color: Colors
                                                                      .black)),
                                                        ],
                                                      ),
                                                    )
                                                  ],
                                                )),
                                            SizedBox(
                                              width: 40,
                                            ),
                                            new Column(children: <Widget>[
                                              Container(
                                                  width: 50,
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: <Widget>[
                                                      IconButton(
                                                        icon: Icon(Icons
                                                            .arrow_drop_up),
                                                        onPressed: () => {
                                                          _updateCart(
                                                              index, "add")
                                                        },
                                                      ),
                                                      Text(
                                                        cartData[index]
                                                            ['cquantity'],
                                                        style: TextStyle(
                                                          color: Colors.black,
                                                          fontFamily: 'Solway',
                                                        ),
                                                      ),
                                                      IconButton(
                                                        icon: Icon(Icons
                                                            .arrow_drop_down),
                                                        onPressed: () => {
                                                          _updateCart(
                                                              index, "remove")
                                                        },
                                                      ),
                                                    ],
                                                  )),
                                            ]),
                                          ]))));
                            })),
              ],
            ))),bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          type: BottomNavigationBarType.fixed,
          onTap: (value) {
            _currentIndex = value;
            setState(() {
              // _currentIndex = index;
              switch (_currentIndex) {
                case 0:
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => MainScreen(
                                user: widget.user,
                              )));
                  break;
                case 1:
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => WishListScreen(
                                user: widget.user,
                              )));
                 
                  break;
                case 2:
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => AccountScreen(
                                user: widget.user,
                              )));

                  break;
              }
            });
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                color: Colors.indigo,
              ),
              title: Text(
                'Home',
                style: TextStyle(
                  color: Colors.indigo,
                  fontFamily: 'Solway',
                ),
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.shopping_cart,
                color: Colors.indigo,
              ),
              title: Text(
                'Cart',
                style: TextStyle(
                  color: Colors.indigo,
                  fontFamily: 'Solway',
                ),
              ),
            ),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.person,
                  color: Colors.indigo,
                ),
                title: Text(
                  'Profile',
                  style: TextStyle(
                    color: Colors.indigo,
                    fontFamily: 'Solway',
                  ),
                )),
          ],
        ),);
  }

  Future<bool> _onBackPressed() {
    return Navigator.push(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => MainScreen(
                  user: widget.user,
                )));
  }

  void _loadCart() {
    _totalprice = 0.0;
    amountpayable = 0.0;
    ProgressDialog pr = new ProgressDialog(context,
        type: ProgressDialogType.Normal, isDismissible: false);
    pr.style(message: "Loading...");
    pr.show();
    String urlLoadJobs = "https://justminedb.com/mobileminer/php/load_cart.php";
    http.post(urlLoadJobs, body: {
      "email": widget.user.email,
    }).then((res) {
      print(res.body);
      pr.hide();
      if (res.body == "Cart Empty") {
        //Navigator.of(context).pop(false);
        widget.user.quantity = "0";
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => MainScreen(
                      user: widget.user,
                    )));
      }

      setState(() {
        var extractdata = json.decode(res.body);
        cartData = extractdata["cart"];
        for (int i = 0; i < cartData.length; i++) {
          _totalprice = double.parse(cartData[i]['yourprice']) + _totalprice;
        }
        amountpayable = _totalprice;

        print(_totalprice);
      });
    }).catchError((err) {
      print(err);
      pr.hide();
    });
    pr.hide();
  }

  _updateCart(int index, String op) {
    int curquantity = int.parse(cartData[index]['quantity']);
    int quantity = int.parse(cartData[index]['cquantity']);
    if (op == "add") {
      quantity++;
      if (quantity > (curquantity - 2)) {
        final snackBar = SnackBar(
          content: Text('Failed to add cart'),
          action: SnackBarAction(
            label: 'close',
            onPressed: () {},
          ),
        );

        _scaffold.currentState.showSnackBar(snackBar);
        return;
      }
    }
    if (op == "remove") {
      quantity--;
      if (quantity == 0) {
        _deleteCart(index);
        return;
      }
    }
    String urlLoadJobs =
        "https://justminedb.com/mobileminer/php/update_cart.php";
    http.post(urlLoadJobs, body: {
      "email": widget.user.email,
      "prodid": cartData[index]['id'],
      "quantity": quantity.toString()
    }).then((res) {
      print(res.body);
      if (res.body == "success") {
        _loadCart();
        final snackBar = SnackBar(
                        content: Text('Item Added!'),
                        action: SnackBarAction(
                          label: 'close',
                          onPressed: () {},
                        ),
                      );

                      _scaffold.currentState.showSnackBar(snackBar);
      } else {
       final snackBar = SnackBar(
                        content: Text('Failed'),
                        action: SnackBarAction(
                          label: 'close',
                          onPressed: () {},
                        ),
                      );

                      _scaffold.currentState.showSnackBar(snackBar);
      }
    }).catchError((err) {
      print(err);
    });
  }

  _deleteCart(int index) {
    showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0))),
        title: new Text(
          'Delete item?',
          style: TextStyle(
            color: Colors.black,
            fontFamily: 'Solway',
          ),
        ),
        actions: <Widget>[
          MaterialButton(
              onPressed: () {
                Navigator.of(context).pop(false);
                http.post(
                    "https://justminedb.com/mobileminer/php/delete_cart.php",
                    body: {
                      "email": widget.user.email,
                      "prodid": cartData[index]['id'],
                    }).then((res) {
                  print(res.body);

                  if (res.body == "success") {
                    _loadCart();
                      final snackBar = SnackBar(
                        content: Text('Item deleted!'),
                        action: SnackBarAction(
                          label: 'close',
                          onPressed: () {},
                        ),
                      );

                      _scaffold.currentState.showSnackBar(snackBar);
                  } else {
                    final snackBar = SnackBar(
                        content: Text('Failed'),
                        action: SnackBarAction(
                          label: 'close',
                          onPressed: () {},
                        ),
                      );

                      _scaffold.currentState.showSnackBar(snackBar);
                  }
                }).catchError((err) {
                  print(err);
                });
              },
              child: Text(
                "Yes",
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'Solway',
                ),
              )),
          MaterialButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: Text(
                "Cancel",
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'Solway',
                ),
              )),
        ],
      ),
    );
  }

  Future<void> makePayment() async {
    var now = new DateTime.now();
    var formatter = new DateFormat('ddMMyyyyhhmmss-');
    String orderid = formatter.format(now) + randomAlphaNumeric(10);
    print(orderid);
    await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => PaymentScreen(
                  user: widget.user,
                  val: _totalprice.toStringAsFixed(2),
                  orderid: orderid,
                )));
    _loadCart();
  }

  void deleteAll() {
    showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0))),
        title: new Text(
          'Delete all items?',
          style: TextStyle(
            color: Colors.black,
            fontFamily: 'Solway',
          ),
        ),
        actions: <Widget>[
          MaterialButton(
              onPressed: () {
                Navigator.of(context).pop(false);
                http.post(
                    "https://justminedb.com/mobileminer/php/delete_cart.php",
                    body: {
                      "email": widget.user.email,
                    }).then((res) {
                  print(res.body);

                  if (res.body == "success") {
                    _loadCart();
                  } else {
                    final snackBar = SnackBar(
                        content: Text('Failed'),
                        action: SnackBarAction(
                          label: 'close',
                          onPressed: () {},
                        ),
                      );

                      _scaffold.currentState.showSnackBar(snackBar);
                  }
                }).catchError((err) {
                  print(err);
                });
              },
              child: Text(
                "Yes",
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'Solway',
                ),
              )),
          MaterialButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: Text(
                "Cancel",
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'Solway',
                ),
              )),
        ],
      ),
    );
  }
}
