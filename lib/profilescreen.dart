import 'package:flutter/material.dart';
import 'package:mobileminer/paymenthistoryscreen.dart';
import 'package:mobileminer/user.dart';
import 'package:mobileminer/cartscreen.dart';
import 'package:mobileminer/mainscreen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'dart:convert';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'loginscreen.dart';
import 'user.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:mobileminer/walletscreen.dart';
import 'adminscreen.dart';
import 'managescreen.dart';

class ProfileScreen extends StatefulWidget {
  final User user;
  const ProfileScreen({Key key, this.user}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  int _currentIndex = 0;
  final GlobalKey<ScaffoldState> _scaffold = new GlobalKey<ScaffoldState>();
  GlobalKey<RefreshIndicatorState> refreshKey;
  String cartquantity = "0";
  String titlecenter = "Loading...";
  List productdata;
  double screenHeight, screenWidth;
  String server = "https://justminedb.com/mobileminer";
  int quantity = 1;
  String admin = 'admin@gmail.com';

  @override
  void initState() {
    super.initState();
    _loadUserData();
    print(widget.user.wallet);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffold,
      appBar: AppBar(
        title: Text(
          "My Profile",
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
        child: ListView(children: <Widget>[
          Card(
            elevation: 10,
            child: Row(mainAxisAlignment: MainAxisAlignment.start, children: <
                Widget>[
              GestureDetector(
                onTap: _takePicture,
                child: Container(
                  height: 100,
                  width: 100,
                  child: CachedNetworkImage(
                    fit: BoxFit.cover,
                    imageUrl:
                        server + "/profileimages/${widget.user.email}.jpg",
                    placeholder: (context, url) => new SizedBox(
                        height: 10.0,
                        width: 10.0,
                        child: CircularProgressIndicator()),
                    errorWidget: (context, url, error) =>
                        new Icon(MdiIcons.cameraIris, size: 64.0),
                  ),
                ),
              ),
              SizedBox(width: 20),
              Container(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        widget.user.name,
                        style: TextStyle(fontFamily: 'Solway', fontSize: 16),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        widget.user.email,
                        style: TextStyle(fontFamily: 'Solway', fontSize: 16),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        widget.user.phone,
                        style: TextStyle(fontFamily: 'Solway', fontSize: 16),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'My Wallet: RM' + widget.user.wallet,
                        style: TextStyle(fontFamily: 'Solway', fontSize: 16),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ]),
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
                      onPressed: () {
                        setState(() {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      PaymentHistoryScreen(
                                        user: widget.user,
                                      )));
                        });
                      },
                      child: Text(
                        'My Purchase',
                        style: TextStyle(
                            fontSize: 20,
                            fontFamily: 'Solway',
                            color: Colors.white),
                      ),
                      color: Colors.blue,
                      elevation: 0,
                    ),
                  ),
                ]),
          ),
          Card(
            elevation: 0,
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: <
                Widget>[
              Expanded(
                child: MaterialButton(
                  height: 50,
                  onPressed: () {
                    setState(() {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) => ManageScreen(
                                    user: widget.user,
                                  )));
                    });
                  },
                  child: Text(
                    'Manage My Account',
                    style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'Solway',
                        color: Colors.white),
                  ),
                  color: Colors.blue,
                  elevation: 0,
                ),
              ),
            ]),
          ),
          Card(
            elevation: 0,
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: <
                Widget>[
              Expanded(
                child: MaterialButton(
                  height: 50,
                  onPressed: () {
                    setState(() {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) => WalletScreen(
                                    user: widget.user,
                                  )));
                    });
                  },
                  child: Text(
                    'My Wallet',
                    style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'Solway',
                        color: Colors.white),
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
                      onPressed: () {
                        setState(() {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      LoginScreen()));
                        });
                      },
                      child: Text(
                        'Log out',
                        style: TextStyle(
                            fontSize: 20,
                            fontFamily: 'Solway',
                            color: Colors.white),
                      ),
                      color: Colors.blue,
                      elevation: 0,
                    ),
                  ),
                ]),
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
                cartquantity = widget.user.quantity;
                if (cartquantity == '0') {
                  final snackBar = SnackBar(
                    content: Text('Cart Empty', style: TextStyle(fontFamily:"Solway"),),
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
                  _loadUserData();
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
              style: TextStyle(fontFamily: 'Solway', color: Colors.indigo),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.shopping_cart,
              color: Colors.indigo,
            ),
            title: Text(
              'Cart',
              style: TextStyle(fontFamily: 'Solway', color: Colors.indigo),
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

  Future<Null> refreshList() async {
    await Future.delayed(Duration(seconds: 2));
    _loadUserData();
    return null;
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

  void _takePicture() async {
    File _image = await ImagePicker.pickImage(
        source: ImageSource.camera, maxHeight: 400, maxWidth: 300);
    if (_image == null) {
      final snackBar = SnackBar(
        content:
            Text('Please Take Picture', style: TextStyle(fontFamily: "Solway")),
        action: SnackBarAction(
          label: 'Close',
          textColor: Colors.white,
          onPressed: () {},
        ),
      );

      _scaffold.currentState.showSnackBar(snackBar);
      return;
    } else {
      String base64Image = base64Encode(_image.readAsBytesSync());
      print(base64Image);
      http.post(server + "/php/upload_image.php", body: {
        "encoded_string": base64Image,
        "email": widget.user.email,
      }).then((res) {
        print(res.body);
        if (res.body == "success") {
          setState(() {
            DefaultCacheManager manager = new DefaultCacheManager();
            manager.emptyCache();
          });
        } else {
          final snackBar = SnackBar(
            content: Text('Failed', style: TextStyle(fontFamily: "Solway")),
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
  }
}
