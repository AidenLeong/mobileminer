import 'package:flutter/material.dart';
import 'package:mobileminer/user.dart';
import 'package:recase/recase.dart';
import 'package:http/http.dart' as http;

class ManageScreen extends StatefulWidget {
  final User user;
  const ManageScreen({Key key, this.user}) : super(key: key);

  @override
  _ManageScreenState createState() => _ManageScreenState();
}

class _ManageScreenState extends State<ManageScreen> {
  final GlobalKey<ScaffoldState> _scaffold = new GlobalKey<ScaffoldState>();
  GlobalKey<RefreshIndicatorState> refreshKey;

  String server = "https://justminedb.com/mobileminer";

  @override
  void initState() {
    super.initState();
    refreshKey = GlobalKey<RefreshIndicatorState>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffold,
      appBar: AppBar(
        title: Text(
          "Manage My Account",
          style: TextStyle(fontFamily: 'Solway', color: Colors.white),
        ),
        backgroundColor: Colors.indigo,
      ),
      body: Column(children: <Widget>[
        Card(
            elevation: 10,
            child: Row(
              children: <Widget>[
                SizedBox(
                  height: 50,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  'Full Name',
                  style: TextStyle(
                      fontFamily: 'Solway', color: Colors.black, fontSize: 16),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 245),
                  child: IconButton(
                    icon: Icon(
                      Icons.arrow_forward_ios,
                      size: 16,
                    ),
                    onPressed: () {
                      changeName();
                    },
                  ),
                ),
              ],
            )),
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
                  'Change Password',
                  style: TextStyle(
                      fontFamily: 'Solway', color: Colors.black, fontSize: 16),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 185),
                  child: IconButton(
                    icon: Icon(
                      Icons.arrow_forward_ios,
                      size: 16,
                    ),
                    onPressed: () {
                      changePassword();
                    },
                  ),
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
                  'Change Phone Number',
                  style: TextStyle(
                      fontFamily: 'Solway', color: Colors.black, fontSize: 16),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 143),
                  child: IconButton(
                    icon: Icon(
                      Icons.arrow_forward_ios,
                      size: 16,
                    ),
                    onPressed: () {
                      changePhone();
                    },
                  ),
                ),
              ],
            ),
          ]),
        ),
       
      ]),
    );
  }

  void changeName() {
    TextEditingController nameController = TextEditingController();
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0))),
              title: new Text(
                "Change your name?",
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              content: new TextField(
                  style: TextStyle(
                    color: Colors.black,
                  ),
                  controller: nameController,
                  decoration: InputDecoration(
                    labelText: 'Name',
                    icon: Icon(
                      Icons.person,
                      color: Colors.black,
                    ),
                  )),
              actions: <Widget>[
                new FlatButton(
                    child: new Text(
                      "Yes",
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                    onPressed: () =>
                        _changeName(nameController.text.toString())),
                new FlatButton(
                  child: new Text(
                    "No",
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  onPressed: () => {Navigator.of(context).pop()},
                ),
              ]);
        });
  }

  _changeName(String name) {
    if (name == "" || name == null) {
      final snackBar = SnackBar(
        content: Text(
          'Please enter your new name',
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
    ReCase rc = new ReCase(name);
    print(rc.titleCase.toString());
    http.post(server + "/php/update_profile.php", body: {
      "email": widget.user.email,
      "name": rc.titleCase.toString(),
    }).then((res) {
      if (res.body == "success") {
        print('in success');

        setState(() {
          widget.user.name = rc.titleCase;
        });
        final snackBar = SnackBar(
          content: Text(
            'Success',
            style: TextStyle(fontFamily: "Solway"),
          ),
          action: SnackBarAction(
            label: 'Close',
            textColor: Colors.white,
            onPressed: () {},
          ),
        );

        _scaffold.currentState.showSnackBar(snackBar);
        Navigator.of(context).pop();
        return;
      } else {}
    }).catchError((err) {
      print(err);
    });
  }

  void changePassword() {
    TextEditingController passController = TextEditingController();
    TextEditingController pass2Controller = TextEditingController();
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0))),
              title: new Text(
                "Change your password?",
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              content: new Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  TextField(
                      style: TextStyle(
                        color: Colors.black,
                      ),
                      controller: passController,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Old Password',
                        icon: Icon(
                          Icons.lock,
                          color: Colors.black,
                        ),
                      )),
                  TextField(
                      style: TextStyle(
                        color: Colors.black,
                      ),
                      obscureText: true,
                      controller: pass2Controller,
                      decoration: InputDecoration(
                        labelText: 'New Password',
                        icon: Icon(
                          Icons.lock,
                          color: Colors.black,
                        ),
                      )),
                ],
              ),
              actions: <Widget>[
                new FlatButton(
                    child: new Text(
                      "Yes",
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                    onPressed: () => updatePassword(
                        passController.text, pass2Controller.text)),
                new FlatButton(
                  child: new Text(
                    "No",
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  onPressed: () => {Navigator.of(context).pop()},
                ),
              ]);
        });
  }

  updatePassword(String pass1, String pass2) {
    if (pass1 == "" || pass2 == "") {
      final snackBar = SnackBar(
        content: Text(
          'Please enter your new Password',
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

    http.post(server + "/php/update_profile.php", body: {
      "email": widget.user.email,
      "oldpassword": pass1,
      "newpassword": pass2,
    }).then((res) {
      if (res.body == "success") {
        print('in success');
        setState(() {
          widget.user.password = pass2;
        });
        final snackBar = SnackBar(
          content: Text(
            'Success',
            style: TextStyle(fontFamily: "Solway"),
          ),
          action: SnackBarAction(
            label: 'Close',
            textColor: Colors.white,
            onPressed: () {},
          ),
        );

        _scaffold.currentState.showSnackBar(snackBar);
        Navigator.of(context).pop();
        return;
      } else {}
    }).catchError((err) {
      print(err);
    });
  }

  void changePhone() {
    TextEditingController phoneController = TextEditingController();
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0))),
              title: new Text(
                "Change name?",
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              content: new TextField(
                  style: TextStyle(
                    color: Colors.black,
                  ),
                  controller: phoneController,
                  decoration: InputDecoration(
                    labelText: 'New Phone Number',
                    icon: Icon(
                      Icons.phone,
                      color: Colors.black,
                    ),
                  )),
              actions: <Widget>[
                new FlatButton(
                    child: new Text(
                      "Yes",
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                    onPressed: () =>
                        _changePhone(phoneController.text.toString())),
                new FlatButton(
                  child: new Text(
                    "No",
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  onPressed: () => {Navigator.of(context).pop()},
                ),
              ]);
        });
  }

  _changePhone(String phone) {
    if (phone == "" || phone == null || phone.length < 9) {
      final snackBar = SnackBar(
        content: Text(
          'Please enter your new phone number',
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
    http.post(server + "/php/update_profile.php", body: {
      "email": widget.user.email,
      "phone": phone,
    }).then((res) {
      if (res.body == "success") {
        print('in success');

        setState(() {
          widget.user.phone = phone;
        });
        final snackBar = SnackBar(
          content: Text(
            'Success',
            style: TextStyle(fontFamily: "Solway"),
          ),
          action: SnackBarAction(
            label: 'Close',
            textColor: Colors.white,
            onPressed: () {},
          ),
        );

        _scaffold.currentState.showSnackBar(snackBar);
        Navigator.of(context).pop();
        return;
      } else {}
    }).catchError((err) {
      print(err);
    });
  }

  Future<Null> refreshList() async {
    await Future.delayed(Duration(seconds: 2));
    _loadData();
    return null;
  }

  void _loadData() async {
    String urlLoadJobs = server + "/php/load_userdata.php";
    await http.post(urlLoadJobs, body: {}).then((res) {
      if (res.body == "nodata") {
        setState(() {});
      } else {
        setState(() {});
      }
    }).catchError((err) {
      print(err);
    });
  }
}
