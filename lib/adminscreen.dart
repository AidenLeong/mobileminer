import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:mobileminer/profilescreen.dart';
import 'package:mobileminer/newproduct1.dart';
import 'package:mobileminer/product.dart';
import 'package:mobileminer/user.dart';
import 'package:mobileminer/cartscreen.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'infoscreen.dart';
import 'package:carousel_pro/carousel_pro.dart';

class AdminScreen extends StatefulWidget {
  final User user;
  const AdminScreen({Key key, this.user}) : super(key: key);

  @override
  _AdminScreenState createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  final GlobalKey<ScaffoldState> _scaffold = new GlobalKey<ScaffoldState>();
  GlobalKey<RefreshIndicatorState> refreshKey;
  int _currentIndex = 0;
  String cartquantity = "0";
  String titlecenter = "Loading...";
  List productdata;
  double screenHeight, screenWidth;
  String server = "https://justminedb.com/mobileminer";
  int quantity = 1;

  @override
  void initState() {
    super.initState();
    refreshKey = GlobalKey<RefreshIndicatorState>();
    _loadData();
    print(widget.user.email);
  }

  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    Widget imageCarousel = new Container(
      height: 200.0,
      child: new Carousel(
        boxFit: BoxFit.cover,
        images: [
          AssetImage('assets/images/01.jpg'),
          AssetImage('assets/images/02.jpg'),
          AssetImage('assets/images/03.jpg'),
          AssetImage('assets/images/04.jpg'),
        ],
        autoplay: true,
        
        dotSize: 4.0,
      ),
    );

    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        key: _scaffold,
        resizeToAvoidBottomPadding: false,
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(
            "Admin Mode",
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'Solway',
            ),
          ),
          backgroundColor: Colors.indigo,
        ),
        body: RefreshIndicator(
          key: refreshKey,
          color: Colors.black,
          onRefresh: () async {
            await refreshList();
          },
          child: new ListView(children: <Widget>[
            imageCarousel,
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    height: screenHeight / 1.75,
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      color: Colors.white,
                      elevation: 5,
                      child: Row(mainAxisSize: MainAxisSize.min, children: <
                          Widget>[
                        productdata == null
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
                                child: GridView.count(
                                    crossAxisCount: 2,
                                    childAspectRatio:
                                        (screenWidth / screenHeight) / 0.71,
                                    children: List.generate(productdata.length,
                                        (index) {
                                      return Container(
                                          child: Card(
                                              elevation: 0.5,
                                              child: Padding(
                                                padding: EdgeInsets.all(5),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: <Widget>[
                                                    GestureDetector(
                                                      onTap: () =>
                                                          _onProductDetail(
                                                              index),
                                                      child: Container(
                                                        height:
                                                            screenHeight / 5.9,
                                                        width:
                                                            screenWidth / 3.5,
                                                        child: ClipRect(
                                                            child:
                                                                CachedNetworkImage(
                                                          fit: BoxFit.fill,
                                                          imageUrl: server +
                                                              "/productimage1/${productdata[index]['id']}.jpg",
                                                          placeholder: (context,
                                                                  url) =>
                                                              new CircularProgressIndicator(),
                                                          errorWidget: (context,
                                                                  url, error) =>
                                                              new Icon(
                                                                  Icons.error),
                                                        )),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 5,
                                                    ),
                                                    Text(
                                                        productdata[index]
                                                            ['name'],
                                                        maxLines: 1,
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontFamily:
                                                                'Solway',
                                                            color:
                                                                Colors.black)),
                                                    Text(
                                                      "RM " +
                                                          productdata[index]
                                                              ['price'],
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.black,
                                                        fontFamily: 'Solway',
                                                      ),
                                                    ),
                                                    Text(
                                                      "Brand: " +
                                                          productdata[index]
                                                              ['type'],
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontFamily: 'Solway',
                                                      ),
                                                    ),
                                                    MaterialButton(
                                                      shape:
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10.0)),
                                                      minWidth: 100,
                                                      height: 30,
                                                      child: Text(
                                                        'Add to Cart',
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontFamily: 'Solway',
                                                        ),
                                                      ),
                                                      color: Colors.blue,
                                                      elevation: 0,
                                                      onPressed: () {
                                                        _addtocartdialog(index);
                                                      },
                                                    ),
                                                  ],
                                                ),
                                              )));
                                    })))
                      ]),
                    ),
                  ),
                ],
              ),
            ),
          ]),
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          type: BottomNavigationBarType.fixed,
          onTap: (value) {
            _currentIndex = value;
            setState(() {
              switch (_currentIndex) {
                case 0:
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => AdminScreen(
                                user: widget.user,
                              )));
                  break;
                case 1:
                  if (cartquantity == '0') {
                    final snackBar = SnackBar(
                      content: Text('Cart Empty',
                          style: TextStyle(fontFamily: "Solway")),
                      action: SnackBarAction(
                        label: 'Close',
                        textColor: Colors.white,
                        onPressed: () {},
                      ),
                    );

                    _scaffold.currentState.showSnackBar(snackBar);
                  } else {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => CartScreen(
                                  user: widget.user,
                                )));

                    _loadData();
                    _loadCartQuantity();
                  }
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
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => NewProduct1()));
          },
          child: Icon(Icons.add),
          backgroundColor: Colors.blueGrey,
        ),
      ),
    );
  }

  void _loadData() async {
    String urlLoadJobs = server + "/php/load_products.php";
    await http.post(urlLoadJobs, body: {}).then((res) {
      if (res.body == "nodata") {
        cartquantity = "0";
        titlecenter = "No product found";
        setState(() {
          productdata = null;
        });
      } else {
        setState(() {
          var extractdata = json.decode(res.body);
          productdata = extractdata["products"];
          cartquantity = widget.user.quantity;
        });
      }
    }).catchError((err) {
      print(err);
    });
  }

  void _loadCartQuantity() async {
    String urlLoadJobs = server + "/php/load_cartquantity.php";
    await http.post(urlLoadJobs, body: {
      "email": widget.user.email,
    }).then((res) {
      if (res.body == "nodata") {
      } else {
        widget.user.quantity = res.body;
      }
    }).catchError((err) {
      print(err);
    });
  }

  _onProductDetail(int index) async {
    print(productdata[index]['name']);
    Product product = new Product(
      id: productdata[index]['id'],
      name: productdata[index]['name'],
      price: productdata[index]['price'],
      quantity: productdata[index]['quantity'],
      type: productdata[index]['type'],
      weight: productdata[index]['weight'],
      sensor: productdata[index]['sensor'],
      battery: productdata[index]['battery'],
      os: productdata[index]['os'],
      memory: productdata[index]['memory'],
    );

    await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => InfoScreen(
                  product: product,
                  user: widget.user,
                )));
    _loadData();
  }

  void _addtoCart(int index) {
    try {
      int cquantity = int.parse(productdata[index]["quantity"]);
      print(cquantity);
      print(productdata[index]["id"]);
      print(widget.user.email);
      if (cquantity > 0) {
        ProgressDialog pr = new ProgressDialog(context,
            type: ProgressDialogType.Normal, isDismissible: true);
        pr.style(message: "Add to cart...");
        pr.show();
        String urlLoadJobs = server + "/php/insert_cart.php";
        http.post(urlLoadJobs, body: {
          "email": widget.user.email,
          "id": productdata[index]["id"],
          "quantity": quantity.toString(),
        }).then((res) {
          print(res.body);
          if (res.body == "failed") {
            final snackBar = SnackBar(
              content: Text('Failed to add cart',
                  style: TextStyle(fontFamily: "Solway")),
              action: SnackBarAction(
                label: 'Close',
                textColor: Colors.white,
                onPressed: () {},
              ),
            );

            _scaffold.currentState.showSnackBar(snackBar);
            pr.hide();
            return;
          } else {
            List respond = res.body.split(",");
            setState(() {
              cartquantity = respond[1];
              widget.user.quantity = cartquantity;
            });
            final snackBar = SnackBar(
              content:
                  Text('Cart Added', style: TextStyle(fontFamily: "Solway")),
              action: SnackBarAction(
                label: 'Close',
                textColor: Colors.white,
                onPressed: () {},
              ),
            );

            _scaffold.currentState.showSnackBar(snackBar);
          }
          pr.hide();
        }).catchError((err) {
          print(err);
          pr.hide();
        });
        pr.hide();
      } else {
        final snackBar = SnackBar(
          content: Text('Out of stock', style: TextStyle(fontFamily: "Solway")),
          action: SnackBarAction(
            label: 'Close',
            textColor: Colors.white,
            onPressed: () {},
          ),
        );

        _scaffold.currentState.showSnackBar(snackBar);
      }
    } catch (e) {
      final snackBar = SnackBar(
        content:
            Text('Failed to add cart', style: TextStyle(fontFamily: "Solway")),
        action: SnackBarAction(
          label: 'Close',
          textColor: Colors.white,
          onPressed: () {},
        ),
      );

      _scaffold.currentState.showSnackBar(snackBar);
    }
  }

  _addtocartdialog(int index) {
    quantity = 1;
    showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, newSetState) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0))),
              title: new Text(
                "Add " + productdata[index]['name'] + " to Cart?",
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'Solway',
                ),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    "Select quantity of product",
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Solway',
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          FlatButton(
                            onPressed: () => {
                              newSetState(() {
                                if (quantity > 1) {
                                  quantity--;
                                }
                              })
                            },
                            child: Icon(
                              MdiIcons.minus,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            quantity.toString(),
                            style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'Solway',
                            ),
                          ),
                          FlatButton(
                            onPressed: () => {
                              newSetState(() {
                                if (quantity <
                                    (int.parse(productdata[index]['quantity']) -
                                        2)) {
                                  quantity++;
                                } else {
                                  final snackBar = SnackBar(
                                    content: Text('Quantity not available',
                                        style: TextStyle(fontFamily: "Solway")),
                                    action: SnackBarAction(
                                      label: 'Close',
                                      textColor: Colors.white,
                                      onPressed: () {},
                                    ),
                                  );

                                  _scaffold.currentState.showSnackBar(snackBar);
                                }
                              })
                            },
                            child: Icon(
                              MdiIcons.plus,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
              actions: <Widget>[
                MaterialButton(
                    onPressed: () {
                      _addtoCart(index);
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
            );
          });
        });
  }

  Future<bool> _onBackPressed() {
    return showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: new Text(
              'Are you sure?',
              style: TextStyle(
                fontFamily: 'Solway',
              ),
            ),
            content: new Text(
              'Do you want to exit an App',
              style: TextStyle(
                fontFamily: 'Solway',
              ),
            ),
            actions: <Widget>[
              MaterialButton(
                  onPressed: () {
                    SystemChannels.platform.invokeMethod('SystemNavigator.pop');
                  },
                  child: Text(
                    "Exit",
                    style: TextStyle(
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
                      fontFamily: 'Solway',
                    ),
                  )),
            ],
          ),
        ) ??
        false;
  }

  Future<Null> refreshList() async {
    await Future.delayed(Duration(seconds: 2));
    _loadData();
    return null;
  }
}
