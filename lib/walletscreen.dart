import 'package:flutter/material.dart';
import 'package:mobileminer/topup.dart';
import 'package:mobileminer/user.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class WalletScreen extends StatefulWidget {
  final User user;
  const WalletScreen({Key key, this.user}) : super(key: key);
  @override
  _WalletScreenState createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  TextEditingController _topUpEditingController = new TextEditingController();
  final GlobalKey<ScaffoldState> _scaffold = new GlobalKey<ScaffoldState>();
  GlobalKey<RefreshIndicatorState> refreshKey;
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
    _loadUserData();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffold,
      appBar: AppBar(
        title: Text(
          "My Wallet ",
          style: TextStyle(fontFamily: 'Solway', color: Colors.white),
        ),
        backgroundColor: Colors.indigo,
      ),
      body: RefreshIndicator(
        key: refreshKey,
        color: Colors.black,
        onRefresh: () async {
          await refreshList();
        },
        child: Column(children: <Widget>[
          Card(
            elevation: 10,
            child: Column(children: <Widget>[
              Row(
                children: <Widget>[
                  SizedBox(
                    height: 50,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Top Up',
                    style: TextStyle(
                        fontFamily: 'Solway',
                        color: Colors.black,
                        fontSize: 20),
                  ),
                ],
              ),
              Column(
                children: <Widget>[
                  Container(
                    width: 360,
                    child: TextField(
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Solway',
                      ),
                      controller: _topUpEditingController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: 'Please enter the amount',
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(left: 280),
                      child: MaterialButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                        elevation: 10,
                        child: Text(
                          "Proceed",
                          style: TextStyle(
                              fontFamily: 'Solway',
                              color: Colors.white,
                              fontSize: 14),
                        ),
                        color: Colors.blue,
                        onPressed: () {
                          _topUp(_topUpEditingController.text.toString());
                        },
                      ),
                    ),
                  ]),
                ],
              ),
              Row(
                children: <Widget>[
                  SizedBox(
                    width: 11,
                  ),
                  MaterialButton(
                    elevation: 10,
                    child: Text(
                      "RM50",
                      style: TextStyle(
                          fontFamily: 'Solway',
                          color: Colors.black,
                          fontSize: 14),
                    ),
                    onPressed: () {
                      _topUp("50");
                    },
                  ),
                  MaterialButton(
                    child: Text(
                      "RM100",
                      style: TextStyle(
                          fontFamily: 'Solway',
                          color: Colors.black,
                          fontSize: 14),
                    ),
                    onPressed: () {
                      _topUp("100");
                    },
                  ),
                  MaterialButton(
                    child: Text(
                      "RM200",
                      style: TextStyle(
                          fontFamily: 'Solway',
                          color: Colors.black,
                          fontSize: 14),
                    ),
                    onPressed: () {
                      _topUp("200");
                    },
                  ),
                  MaterialButton(
                    child: Text(
                      "RM500",
                      style: TextStyle(
                          fontFamily: 'Solway',
                          color: Colors.black,
                          fontSize: 14),
                    ),
                    onPressed: () {
                      _topUp("500");
                    },
                  ),
                ],
              ),
            ]),
          ),
          Card(
            elevation: 10,
            child: Column(children: <Widget>[
              Row(
                children: <Widget>[
                  SizedBox(
                    height: 50,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Current Balance',
                    style: TextStyle(
                        fontFamily: 'Solway',
                        color: Colors.black,
                        fontSize: 16),
                  ),
                ],
              ),
              Row(children: <Widget>[
                SizedBox(
                  width: 10,
                ),
                Text(
                  'RM ',
                  style: TextStyle(
                      fontFamily: 'Solway', color: Colors.black, fontSize: 16),
                ),
                Text(
                  widget.user.wallet,
                  style: TextStyle(
                      fontFamily: 'Solway', color: Colors.black, fontSize: 24),
                ),
              ]),
              SizedBox(height: 10),
            ]),
          ),
        ]),
      ),
    );
  }

  _topUp(String uwallet) {
    print("RM " + uwallet);
    if (uwallet.length <= 0) {
      final snackBar = SnackBar(
        content: Text(
          'Enter Correct Amount',
          style: TextStyle(fontFamily: "Solway"),
        ),
        action: SnackBarAction(
          label: 'Close',
          textColor: Colors.white,
          onPressed: () {},
        ),
      );
      _scaffold.currentState.showSnackBar(snackBar);
      return;
    }
    showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0))),
        title: new Text(
          'Top up RM' + uwallet + '?',
          style: TextStyle(fontFamily: 'Solway', color: Colors.black),
        ),
        actions: <Widget>[
          MaterialButton(
              onPressed: () {
                Navigator.of(context).pop(false);
                Navigator.of(context).pop(false);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => TopUp(
                              user: widget.user,
                              val: uwallet,
                            )));
              },
              child: Text(
                "Yes",
                style: TextStyle(fontFamily: 'Solway', color: Colors.black),
              )),
          MaterialButton(
              onPressed: () {
                Navigator.of(context).pop(false);
                _loadUserData();
              },
              child: Text(
                "No",
                style: TextStyle(fontFamily: 'Solway', color: Colors.black),
              )),
        ],
      ),
    );
  }

  Future<Null> refreshList() async {
    await Future.delayed(Duration(seconds: 2));
    _loadData();
    _loadUserData();

    return null;
  }

  void _loadData() async {
    String urlLoadJobs = server + "/php/load_userdata.php";
    await http.post(urlLoadJobs, body: {}).then((res) {
      if (res.body == "nodata") {
        cartquantity = "0";
        titlecenter = "No product found";
        setState(() {});
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
}
