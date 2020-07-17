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
import 'profilescreen.dart';
import 'adminscreen.dart';
import 'mainscreen.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoder/geocoder.dart';
import 'paymentscreen.dart';
import 'package:toast/toast.dart';
import 'package:intl/intl.dart';

class CartScreen extends StatefulWidget {
  final User user;

  const CartScreen({Key key, this.user}) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  List cartData;
  double screenHeight, screenWidth;

  double _totalprice = 0.0;
  final GlobalKey<ScaffoldState> _scaffold = new GlobalKey<ScaffoldState>();
  TextEditingController _walletEditingController = new TextEditingController();
  String server = "https://justminedb.com/mobileminer";
  int _currentIndex = 0;
  String curaddress;
  GoogleMapController gmcontroller;
  MarkerId markerId1 = MarkerId("12");
  Set<Marker> markers = Set();
  double latitude, longitude;
  String label;
  double deliveryfee = 0.0;
  int option;
  double amountpayable, amountwithdev;
  String titlecenter = "Loading cart...";
  int groupValue, walletValue;
  String admin = 'admin@gmail.com';
  double remain;

  Position _currentPosition;
  Completer<GoogleMapController> _controller = Completer();
  CameraPosition _home;
  CameraPosition _userpos;
  double deliverycharge;

  String i = "0";
  @override
  void initState() {
    super.initState();
    _loadCart();
    _getLocation();
    print(widget.user.email);
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
                          itemCount: cartData == null ? 1 : cartData.length + 2,
                          itemBuilder: (context, index) {
                            if (index == cartData.length) {
                              return Column(children: <Widget>[
                                InkWell(
                                  onLongPress: () => {print("Delete")},
                                  child: Card(
                                    elevation: 10,
                                    child: Column(
                                      children: <Widget>[
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Container(
                                            child: Column(children: <Widget>[
                                          Row(children: <Widget>[
                                            new Radio(
                                              value: 0,
                                              groupValue: groupValue,
                                              onChanged: (int e) =>
                                                  something(e),
                                            ),
                                            new Text(
                                              'Standard Delivery (Arrived in 10 - 15 days)',
                                              style: new TextStyle(
                                                fontSize: 14.0,
                                                fontFamily: 'Solway',
                                              ),
                                            ),
                                          ]),
                                          Row(children: <Widget>[
                                            new Radio(
                                              value: 1,
                                              groupValue: groupValue,
                                              onChanged: (int e) =>
                                                  something(e),
                                            ),
                                            new Text(
                                              'Express Delivery (Arrived in 3 - 5 days)',
                                              style: new TextStyle(
                                                fontSize: 14.0,
                                                fontFamily: 'Solway',
                                              ),
                                            ),
                                          ]),
                                        ]))
                                      ],
                                    ),
                                  ),
                                ),
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
                                                      alignment:
                                                          Alignment.centerLeft,
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
                                                                _totalprice
                                                                    .toStringAsFixed(
                                                                        2) ??
                                                            "0.0",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontFamily:
                                                                'Solway',
                                                            color:
                                                                Colors.black)),
                                                  ),
                                                ),
                                              ]),
                                              TableRow(children: [
                                                TableCell(
                                                  child: Container(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      height: 20,
                                                      child: Text(
                                                          "Delivery Fee",
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
                                                                deliveryfee
                                                                    .toStringAsFixed(
                                                                        2) ??
                                                            "0.0",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontFamily:
                                                                'Solway',
                                                            color:
                                                                Colors.black)),
                                                  ),
                                                ),
                                              ]),
                                            ])),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Card(
                                      child: Row(
                                        children: <Widget>[
                                          FlatButton(
                                            color: Colors.blue,
                                            onPressed: () => {_loadMapDialog()},
                                            child: Icon(
                                              MdiIcons.locationEnter,
                                              color: Colors.white,
                                            ),
                                          ),
                                          Container(
                                            width: 280,
                                            height: 100,
                                            alignment: Alignment.center,
                                            child: Column(
                                              children: <Widget>[
                                                Row(children: <Widget>[
                                                  SizedBox(
                                                    width: 20,
                                                    height: 40,
                                                  ),
                                                  Text("Current Address:",
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontFamily: "Solway",
                                                        color: Colors.black,
                                                      )),
                                                ]),
                                                Row(
                                                  children: <Widget>[
                                                    SizedBox(
                                                      width: 14,
                                                    ),
                                                    Text("  "),
                                                    Flexible(
                                                      child: Text(
                                                        curaddress ??
                                                            "Address not set",
                                                        maxLines: 3,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: TextStyle(
                                                          color: Colors.black,
                                                          fontFamily: "Solway",
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
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
                                                      "http://justminedb.com/mobileminer/productimage1/${cartData[index]['id']}.jpg",
                                                  placeholder: (context, url) =>
                                                      new CircularProgressIndicator(),
                                                  errorWidget:
                                                      (context, url, error) =>
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
                                                              color:
                                                                  Colors.black),
                                                        ),
                                                        SizedBox(
                                                          height: 10,
                                                        ),
                                                        Text(
                                                          "Quantity: " +
                                                              cartData[index]
                                                                  ['cquantity'],
                                                          style: TextStyle(
                                                            color: Colors.black,
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
                                                                cartData[index][
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
                                                      MainAxisAlignment.center,
                                                  children: <Widget>[
                                                    IconButton(
                                                      icon: Icon(
                                                          Icons.arrow_drop_up),
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
              Card(
                child: Column(
                  children: <Widget>[
                    Row(children: <Widget>[
                      Text(
                        "My Wallet",
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Solway',
                            fontSize: 20),
                      ),
                    ]),
                    Table(children: [
                      TableRow(children: [
                        TableCell(
                          child: Container(
                            height: 50,
                            alignment: Alignment.center,
                            child: Row(children: <Widget>[
                              SizedBox(
                                width: 15,
                              ),
                              new Radio(
                                value: 2,
                                groupValue: walletValue,
                                onChanged: (int a) => walletOption(a),
                              ),
                              new Text(
                                'Use All',
                                style: new TextStyle(
                                  fontSize: 14.0,
                                  fontFamily: 'Solway',
                                ),
                              ),
                            ]),
                          ),
                        ),
                        TableCell(
                          child: Container(
                              height: 33,
                              alignment: Alignment.bottomCenter,
                              child: Text(
                                "RM" + widget.user.wallet,
                                style: new TextStyle(
                                  fontSize: 14.0,
                                  fontFamily: 'Solway',
                                ),
                              )),
                        ),
                      ]),
                      TableRow(children: [
                        TableCell(
                          child: Container(
                            height: 50,
                            alignment: Alignment.center,
                            child: Row(children: <Widget>[
                              SizedBox(
                                width: 15,
                              ),
                              new Radio(
                                value: 3,
                                groupValue: walletValue,
                                onChanged: (int a) => walletOption(a),
                              ),
                              new Text(
                                'Use some',
                                style: new TextStyle(
                                  fontSize: 14.0,
                                  fontFamily: 'Solway',
                                ),
                              ),
                            ]),
                          ),
                        ),
                        TableCell(
                          child: Container(
                            height: 50,
                            alignment: Alignment.center,
                            child: TextFormField(
                              style: TextStyle(
                                  color: Colors.black, fontFamily: 'Solway'),
                              controller: _walletEditingController,
                              keyboardType: TextInputType.number,
                              textInputAction: TextInputAction.next,
                              decoration: new InputDecoration(
                                hintText: "RM",
                                contentPadding: const EdgeInsets.all(5),
                                fillColor: Colors.black,
                                border: new OutlineInputBorder(
                                  borderRadius: new BorderRadius.circular(5.0),
                                  borderSide: new BorderSide(),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ])
                    ]),
                  ],
                ),
              ),
              Card(
                child: Column(
                  children: <Widget>[
                    Table(children: [
                      TableRow(children: [
                        TableCell(
                          child: Container(
                            height: 50,
                            alignment: Alignment.center,
                            child: Text(
                                "Total Amount:" +
                                        '\n' +
                                        'RM ' +
                                        amountpayable.toStringAsFixed(2) ??
                                    "0.0",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Solway',
                                    color: Colors.black)),
                          ),
                        ),
                        TableCell(
                          child: MaterialButton(
                              color: Colors.blue,
                              height: 50,
                              elevation: 10,
                              onPressed: () {
                                setState(() {
                                  if (double.parse(widget.user.wallet) <
                                      amountpayable) {
                                    final snackBar = SnackBar(
                                      content: Text('Invalid Value!'),
                                      action: SnackBarAction(
                                        label: 'Close',
                                        textColor: Colors.white,
                                        onPressed: () {},
                                      ),
                                    );

                                    _scaffold.currentState
                                        .showSnackBar(snackBar);
                                  }
                                  if (walletValue == 2) {
                                    print(remain);
                                    _payusingwallet(remain);
                                  }
                                  if (walletValue == 3) {
                                    print(remain);
                                    _payusingwallet(remain);
                                  } else {
                                    makePayment();
                                  }
                                });
                              },
                              child: Text("Check Out",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Solway',
                                      color: Colors.white))),
                        ),
                      ])
                    ]),
                  ],
                ),
              ),
            ],
          ))),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        onTap: (value) {
          _currentIndex = value;
          setState(() {
            switch (_currentIndex) {
              case 0:
                if (widget.user.email == admin) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => AdminScreen(
                                user: widget.user,
                              )));
                } else {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => MainScreen(
                                user: widget.user,
                              )));
                }
                break;
              case 1:
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => CartScreen(
                              user: widget.user,
                            )));

                break;
              case 2:
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => ProfileScreen(
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
      ),
    );
  }

  Future<bool> _onBackPressed() {
    return Navigator.push(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => MainScreen(
                  user: widget.user,
                )));
  }

  void something(int e) {
    setState(() {
      if (e == 0) {
        groupValue = 0;
        _updatePayment();
      } else if (e == 1) {
        groupValue = 1;
        _updatePayment();
      }
    });
  }

  void walletOption(int a) {
    setState(() {
      if (a == 2) {
        walletValue = 2;
        i = widget.user.wallet;
        _updatePayment2(i);
      } else if (a == 3) {
        walletValue = 3;
        _updatePayment2(_walletEditingController.text);
      }
    });
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
        widget.user.quantity = "0";
        if (widget.user.email == admin) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => AdminScreen(
                        user: widget.user,
                      )));
        } else {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => MainScreen(
                        user: widget.user,
                      )));
        }
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
            label: 'Close',
            textColor: Colors.white,
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
      "id": cartData[index]['id'],
      "quantity": quantity.toString()
    }).then((res) {
      print(res.body);
      if (res.body == "success") {
        _loadCart();
        final snackBar = SnackBar(
          content: Text('Item Added!'),
          action: SnackBarAction(
            label: 'Close',
            textColor: Colors.white,
            onPressed: () {},
          ),
        );

        _scaffold.currentState.showSnackBar(snackBar);
      } else {
        final snackBar = SnackBar(
          content: Text('Failed'),
          action: SnackBarAction(
            label: 'Close',
            textColor: Colors.white,
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
                      "id": cartData[index]['id'],
                    }).then((res) {
                  print(res.body);

                  if (res.body == "success") {
                    _loadCart();
                    final snackBar = SnackBar(
                      content: Text('Item deleted!'),
                      action: SnackBarAction(
                        label: 'Close',
                        textColor: Colors.white,
                        onPressed: () {},
                      ),
                    );

                    _scaffold.currentState.showSnackBar(snackBar);
                  } else {
                    final snackBar = SnackBar(
                      content: Text('Failed'),
                      action: SnackBarAction(
                        label: 'Close',
                        textColor: Colors.white,
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

  _getLocation() async {
    final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
    _currentPosition = await geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    //debugPrint('location: ${_currentPosition.latitude}');
    final coordinates =
        new Coordinates(_currentPosition.latitude, _currentPosition.longitude);
    var addresses =
        await Geocoder.local.findAddressesFromCoordinates(coordinates);
    var first = addresses.first;
    setState(() {
      curaddress = first.addressLine;
      if (curaddress != null) {
        latitude = _currentPosition.latitude;
        longitude = _currentPosition.longitude;
        return;
      }
    });

    print("${first.featureName} : ${first.addressLine}");
  }

  _getLocationfromlatlng(double lat, double lng, newSetState) async {
    final Geolocator geolocator = Geolocator()
      ..placemarkFromCoordinates(lat, lng);
    _currentPosition = await geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    //debugPrint('location: ${_currentPosition.latitude}');
    final coordinates = new Coordinates(lat, lng);
    var addresses =
        await Geocoder.local.findAddressesFromCoordinates(coordinates);
    var first = addresses.first;
    newSetState(() {
      curaddress = first.addressLine;
      if (curaddress != null) {
        latitude = _currentPosition.latitude;
        longitude = _currentPosition.longitude;
        return;
      }
    });
    setState(() {
      curaddress = first.addressLine;
      if (curaddress != null) {
        latitude = _currentPosition.latitude;
        longitude = _currentPosition.longitude;
        return;
      }
    });

    print("${first.featureName} : ${first.addressLine}");
  }

  _loadMapDialog() {
    try {
      if (_currentPosition.latitude == null) {
        Toast.show("Location not available. Please wait...", context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
        _getLocation(); //_getCurrentLocation();
        return;
      }
      _controller = Completer();
      _userpos = CameraPosition(
        target: LatLng(latitude, longitude),
        zoom: 14.4746,
      );

      markers.add(Marker(
          markerId: markerId1,
          position: LatLng(latitude, longitude),
          infoWindow: InfoWindow(
            title: 'Current Location',
            snippet: 'Delivery Location',
          )));

      showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(
            builder: (context, newSetState) {
              return AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20.0))),
                title: Text(
                  "Set Your Location",
                  style: TextStyle(color: Colors.black, fontFamily: "Solway"),
                ),
                titlePadding: EdgeInsets.fromLTRB(20, 10, 0, 5),
                //content: Text(curaddress),
                actions: <Widget>[
                  Text(
                    curaddress,
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  Container(
                    height: screenHeight / 2 ?? 600,
                    width: screenWidth ?? 360,
                    child: GoogleMap(
                        mapType: MapType.normal,
                        initialCameraPosition: _userpos,
                        markers: markers.toSet(),
                        onMapCreated: (controller) {
                          _controller.complete(controller);
                        },
                        onTap: (newLatLng) {
                          _loadLoc(newLatLng, newSetState);
                        }),
                  ),
                  MaterialButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0)),
                      //minWidth: 200,
                      height: 30,
                      child: Text(
                        'Close',
                        style: TextStyle(fontFamily: "Solway"),
                      ),
                      color: Colors.blue,
                      textColor: Colors.white,
                      elevation: 10,
                      onPressed: () {
                        setState(() {
                          {
                            markers.clear();
                            Navigator.of(context).pop(false);
                            final snackBar = SnackBar(
                              content: Text(
                                'The location is set!',
                                style: TextStyle(fontFamily: "Solway"),
                              ),
                              action: SnackBarAction(
                                label: 'Close',
                                textColor: Colors.white,
                                onPressed: () {},
                              ),
                            );

                            _scaffold.currentState.showSnackBar(snackBar);
                          }
                        });
                      }),
                ],
              );
            },
          );
        },
      );
    } catch (e) {
      print(e);
      return;
    }
  }

  void _loadLoc(LatLng loc, newSetState) async {
    newSetState(() {
      print("insetstate");
      markers.clear();
      latitude = loc.latitude;
      longitude = loc.longitude;
      _getLocationfromlatlng(latitude, longitude, newSetState);
      _home = CameraPosition(
        target: loc,
        zoom: 14,
      );
      markers.add(Marker(
          markerId: markerId1,
          position: LatLng(latitude, longitude),
          infoWindow: InfoWindow(
            title: 'New Location',
            snippet: 'New Delivery Location',
          )));
    });
    _userpos = CameraPosition(
      target: LatLng(latitude, longitude),
      zoom: 14.4746,
    );
    _newhomeLocation();
  }

  Future<void> _newhomeLocation() async {
    gmcontroller = await _controller.future;
    gmcontroller.animateCamera(CameraUpdate.newCameraPosition(_home));
    //Navigator.of(context).pop(false);
    //_loadMapDialog();
  }

  void _updatePayment() {
    amountwithdev = 0.0;
    setState(() {
      if (groupValue == 0) {
        deliveryfee = _totalprice * 0.1;
      }
      if (groupValue == 1) {
        deliveryfee = _totalprice * 0.15;
      }

      amountwithdev = deliveryfee + _totalprice;
      amountpayable = amountwithdev;

      print("Dev Charge:" + deliveryfee.toStringAsFixed(3));
      print(amountwithdev);
    });
  }

  void _updatePayment2(String usewallet) {
    setState(() {
      if (walletValue == 2) {
        amountpayable = amountwithdev - double.parse(usewallet);
        if (amountpayable < 0) {
          remain = double.parse(widget.user.wallet) - (amountwithdev);
          print(remain);
          amountpayable = 0;
        }
      } else {
        amountpayable = amountwithdev;
      }
      if (walletValue == 3) {
        if (double.parse(usewallet) > double.parse(widget.user.wallet)) {
          final snackBar = SnackBar(
            content: Text('Invalid Value!'),
            action: SnackBarAction(
              label: 'Close',
              textColor: Colors.white,
              onPressed: () {},
            ),
          );

          _scaffold.currentState.showSnackBar(snackBar);
        } else {
          amountpayable = amountwithdev - double.parse(usewallet);
          remain = double.parse(widget.user.wallet) - double.parse(usewallet);
          widget.user.wallet = remain.toStringAsFixed(2);
        }
      }
    });
  }

  Future<void> makePayment() async {
    var now = new DateTime.now();
    var formatter = new DateFormat('ddMMyyyyhhmmss-');
    String orderid = formatter.format(now) + randomAlphaNumeric(10);
    print(remain);
    widget.user.wallet = remain.toStringAsFixed(2);
    await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => PaymentScreen(
                  user: widget.user,
                  val: amountpayable.toStringAsFixed(2),
                  orderid: orderid,
                )));
    widget.user.wallet = remain.toStringAsFixed(2);
    _loadCart();
    _loadUserData();
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
                        label: 'Close',
                        textColor: Colors.white,
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

  Future<void> _payusingwallet(double newamount) async {
    if(walletValue == 3){
    
    ProgressDialog pr = new ProgressDialog(context,
        type: ProgressDialogType.Normal, isDismissible: true);
    
    pr.style(message: "Updating cart...");
    pr.show();
    String urlPayment = server + "/php/paymentsc.php";
    await http.post(urlPayment, body: {
      "userid": widget.user.email,
      "amount": amountpayable.toStringAsFixed(2),
      "orderid": generateOrderid(),
      "newwl": newamount.toStringAsFixed(2)
    }).then((res) {
      print(res.body);
      pr.hide();
    }).catchError((err) {
      print(err);
    });
      makePayment();
    }
   else{
    ProgressDialog pr = new ProgressDialog(context,
        type: ProgressDialogType.Normal, isDismissible: true);
    
    pr.style(message: "Updating cart...");
    pr.show();
    String urlPayment = server + "/php/paymentsc.php";
    await http.post(urlPayment, body: {
      "userid": widget.user.email,
      "amount": amountpayable.toStringAsFixed(2),
      "orderid": generateOrderid(),
      "newwl": newamount.toStringAsFixed(2)
    }).then((res) {
      print(res.body);
      pr.hide();
    }).catchError((err) {
      print(err);
    });
   }
  }

  void _loadUserData() async {
    String urlLoadJobs = server + "/php/load_userdata.php";
    await http.post(urlLoadJobs, body: {
      "email": widget.user.email,
    }).then((res) {
      if (res.body == "nodata") {
        setState(() {});
      } else {
        setState(() {
          widget.user.wallet = res.body;
        });
      }
    }).catchError((err) {
      print(err);
    });
  }

  String generateOrderid() {
    var now = new DateTime.now();
    var formatter = new DateFormat('ddMMyyyyhhmmss-');
    String orderid = formatter.format(now) + randomAlphaNumeric(10);
    return orderid;
  }
}
