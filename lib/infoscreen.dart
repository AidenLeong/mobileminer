import 'package:flutter/material.dart';
import 'package:mobileminer/editproduct.dart';
import 'package:mobileminer/product.dart';
import 'package:mobileminer/user.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:http/http.dart' as http;

class InfoScreen extends StatefulWidget {
  final Product product;
  final User user;
  const InfoScreen({Key key, this.product, this.user}) : super(key: key);

  @override
  _InfoScreenState createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  final GlobalKey<ScaffoldState> _scaffold = new GlobalKey<ScaffoldState>();
  bool _visible = false;
  double screenHeight, screenWidth;
  List productdata;
  int quantity = 1;
  String cartquantity = "0";
  String admin = "admin@gmail.com";
  @override
  void initState() {
    super.initState();
    if (widget.user.email == admin){
      _visible = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      key: _scaffold,
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Product's Info",
          style: TextStyle(fontFamily: 'Solway', color: Colors.white),
        ),
        backgroundColor: Colors.indigo,
        actions: <Widget>[
          Visibility(
                visible: _visible,
                child: IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      setState(() {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) => EditProduct(
                                      product: widget.product,
                                    )));
                      });
                    }),
              ),
        ],
      ),
      body: SingleChildScrollView(
        child: Card(
          elevation: 10,
          child: Column(
            children: <Widget>[
              SizedBox(height: 10),
              Image.network(
                'http://justminedb.com/mobileminer/productimage1/${widget.product.id}.jpg',
              ),
              SizedBox(
                height: 15,
              ),
              Text(widget.product.name.toUpperCase(),
                  style: TextStyle(
                    fontFamily: 'Solway',
                    color: Colors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  )),
              SizedBox(
                height: 15,
              ),
              Row(children: <Widget>[
                Expanded(
                  child: MaterialButton(
                    height: 45,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6.0)),
                    elevation: 10,
                    onPressed: () {
                      _addtocart();
                    },
                    child: Text(
                      "Add to cart",
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Solway',
                      ),
                    ),
                    color: Colors.indigo,
                  ),
                ),
                new IconButton(
                  icon: Icon(Icons.add_shopping_cart),
                  onPressed: () {
                    _addtocart();
                  },
                ),
                new IconButton(
                  icon: Icon(Icons.favorite_border),
                  onPressed: () {},
                ),
              ]),
              Row(
                children: <Widget>[
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Rating: ",
                    style: TextStyle(
                        fontFamily: 'Solway',
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  Icon(
                    Icons.star,
                    color: Colors.yellow,
                  ),
                  Icon(
                    Icons.star,
                    color: Colors.yellow,
                  ),
                  Icon(
                    Icons.star,
                    color: Colors.yellow,
                  ),
                  Icon(
                    Icons.star,
                    color: Colors.yellow,
                  ),
                  Icon(
                    Icons.star,
                    color: Colors.yellow,
                  ),
                ],
              ),
              Center(
                child: Container(
                  width: 370,
                  child: Card(
                      elevation: 10,
                      child: Table(children: [
                        TableRow(children: [
                          TableCell(
                              child: Container(
                                  alignment: Alignment.center,
                                  height: 30,
                                  child: Text(
                                    'Price',
                                    style: TextStyle(
                                        fontFamily: 'Solway',
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                  ))),
                          TableCell(
                            child: Container(
                              alignment: Alignment.center,
                              height: 30,
                              child: SingleChildScrollView(
                                  child: Text('RM ' + widget.product.price,
                                      style: TextStyle(
                                          fontFamily: 'Solway',
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
                                      style: TextStyle(
                                          fontFamily: 'Solway',
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black)))),
                          TableCell(
                              child: Container(
                                  alignment: Alignment.center,
                                  height: 30,
                                  child: Text(widget.product.type,
                                      style: TextStyle(
                                          fontFamily: 'Solway',
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black)))),
                        ]),
                        TableRow(children: [
                          TableCell(
                              child: Container(
                                  alignment: Alignment.center,
                                  height: 50,
                                  child: Text('OS',
                                      style: TextStyle(
                                          fontFamily: 'Solway',
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black)))),
                          TableCell(
                              child: Container(
                                  alignment: Alignment.center,
                                  height: 50,
                                  child: Text(widget.product.os,
                                      style: TextStyle(
                                          fontFamily: 'Solway',
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black)))),
                        ]),
                        TableRow(children: [
                          TableCell(
                              child: Container(
                                  alignment: Alignment.center,
                                  height: 50,
                                  child: Text('Battery',
                                      style: TextStyle(
                                          fontFamily: 'Solway',
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black)))),
                          TableCell(
                              child: Container(
                                  alignment: Alignment.center,
                                  height: 50,
                                  child: Text(widget.product.battery,
                                      style: TextStyle(
                                          fontFamily: 'Solway',
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black)))),
                        ]),
                        TableRow(children: [
                          TableCell(
                              child: Container(
                                  alignment: Alignment.center,
                                  height: 150,
                                  child: Text('Sensor',
                                      style: TextStyle(
                                          fontFamily: 'Solway',
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black)))),
                          TableCell(
                              child: Container(
                                  alignment: Alignment.center,
                                  height: 150,
                                  child: Text(widget.product.sensor,
                                      style: TextStyle(
                                          fontFamily: 'Solway',
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black)))),
                        ]),
                        TableRow(children: [
                          TableCell(
                              child: Container(
                                  alignment: Alignment.center,
                                  height: 50,
                                  child: Text('Memory',
                                      style: TextStyle(
                                          fontFamily: 'Solway',
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black)))),
                          TableCell(
                              child: Container(
                                  alignment: Alignment.center,
                                  height: 50,
                                  child: Text(widget.product.memory,
                                      style: TextStyle(
                                          fontFamily: 'Solway',
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black)))),
                        ]),
                        TableRow(children: [
                          TableCell(
                              child: Container(
                                  alignment: Alignment.center,
                                  height: 30,
                                  child: Text('Weight',
                                      style: TextStyle(
                                          fontFamily: 'Solway',
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black)))),
                          TableCell(
                              child: Container(
                                  alignment: Alignment.center,
                                  height: 30,
                                  child: Text(widget.product.weight + "g",
                                      style: TextStyle(
                                          fontFamily: 'Solway',
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black)))),
                        ]),
                      ])),
                ),
              ),
              
            ],
          ),
        ),
      ),
    );
  }

  _addtocart() {
    quantity = 1;
    showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, newSetState) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0))),
              title: new Text(
                "Add " + widget.product.name + " to Cart?",
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
                                    (int.parse(widget.product.quantity) - 2)) {
                                  quantity++;
                                } else {
                                  final snackBar = SnackBar(
                                    content: Text('Quantity not available'),
                                    action: SnackBarAction(
                                      label: 'close',
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
                      _addCart();
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

  void _addCart() {
    try {
      int cquantity = int.parse(widget.product.name);
      print(cquantity);
      print(widget.product.id);
      print(widget.user.email);
      if (cquantity > 0) {
        ProgressDialog pr = new ProgressDialog(context,
            type: ProgressDialogType.Normal, isDismissible: true);
        pr.style(message: "Add to cart...");
        pr.show();
        String urlLoadJobs =
            "https://justminedb.com/mobileminer/php/insert_cart.php";
        http.post(urlLoadJobs, body: {
          "email": widget.user.email,
          "id": widget.product.id,
          "quantity": quantity.toString(),
        }).then((res) {
          print(res.body);
          if (res.body == "failed") {
            final snackBar = SnackBar(
              content: Text('Failed to add cart'),
              action: SnackBarAction(
                label: 'close',
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
              content: Text('Cart Added'),
              action: SnackBarAction(
                label: 'close',
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
          content: Text('Out of stock'),
          action: SnackBarAction(
            label: 'close',
            onPressed: () {},
          ),
        );

        _scaffold.currentState.showSnackBar(snackBar);
      }
    } catch (e) {
      final snackBar = SnackBar(
        content: Text('Failed to add cart'),
        action: SnackBarAction(
          label: 'close',
          onPressed: () {},
        ),
      );

      _scaffold.currentState.showSnackBar(snackBar);
    }
  }
}
