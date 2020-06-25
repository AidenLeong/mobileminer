import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobileminer/paymenthistoryscreen.dart';
import 'package:mobileminer/user.dart';
import 'package:mobileminer/cartscreen.dart';
import 'package:mobileminer/mainscreen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AccountScreen extends StatefulWidget {
  final User user;
  const AccountScreen({Key key, this.user}) : super(key: key);

  @override
  _AccountScreennState createState() => _AccountScreennState();
}

class _AccountScreennState extends State<AccountScreen> {
  int _currentIndex = 0;
  String cartquantity = "0";
  String titlecenter = "Loading...";
  List productdata;
  double screenHeight, screenWidth;
  String server = "https://justminedb.com/mobileminer";
  int quantity = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "My Profile",
          style: TextStyle(fontFamily: 'Solway',color: Colors.white),
        ),
        backgroundColor: Colors.indigo,
      ),
      body: ListView(children: <Widget>[
        Card(
          elevation: 10,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  'assets/images/avatar.jpg',
                  height: 100,
                  width: 100,
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        widget.user.name,
                        style: TextStyle(fontFamily: 'Solway',fontSize: 20),
                      ),
                    ]),
              ]),
        ),
        Card(
          elevation: 0,
          child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: MaterialButton(
                    height: 50,
                    onPressed: () {setState(() {
                       Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => PaymentHistoryScreen(
                                user: widget.user,
                              )));
                    });},
                    child: Text(
                      'My Purchase',
                      style: TextStyle(fontSize: 20,fontFamily: 'Solway', color: Colors.white),
                    ),
                    color: Colors.blue,
                    elevation: 0,
                  ),
                ),
              ]),
        ),
         Card(
          elevation: 0,
          child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: MaterialButton(
                    height: 50,
                    onPressed: () {},
                    child: Text(
                      'Manage Your Account',
                      style: TextStyle(fontSize: 20, fontFamily: 'Solway',color: Colors.white),
                    ),
                    color: Colors.blue,
                    elevation: 0,
                  ),
                ),
              ]),
        ),
         
         Card(
          elevation: 0,
          child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: MaterialButton(
                    height: 50,
                    onPressed: () { SystemChannels.platform.invokeMethod('SystemNavigator.pop');},
                    child: Text(
                      'Log out',
                      style: TextStyle(fontSize: 20,fontFamily: 'Solway',color: Colors.white),
                    ),
                    color: Colors.blue,
                    elevation: 0,
                  ),
                ),
              ]),
        ),
      ]),
      bottomNavigationBar: BottomNavigationBar(
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
                _loadData();
                _loadCartQuantity();
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
              style: TextStyle(fontFamily: 'Solway',color: Colors.indigo),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.favorite_border,
              color: Colors.indigo,
            ),
            title: Text(
              'Wishlist',
              style: TextStyle(fontFamily: 'Solway',color: Colors.indigo),
            ),
          ),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
                color: Colors.indigo,
              ),
              title: Text(
                'Account',
                style: TextStyle(color: Colors.indigo, fontFamily: 'Solway',),
              )),
        ],
      ),
    );
  }

  void _loadData() async {
    String urlLoadJobs =
        "https://justminedb.com/mobileminer/php/load_products.php";
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
    String urlLoadJobs =
        "https://justminedb.com/mobileminer/php/load_cartquantity.php";
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
}
