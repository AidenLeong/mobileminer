import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobileminer/loginscreen.dart';
import 'package:http/http.dart' as http;
import 'package:toast/toast.dart';

void main() => runApp(RegisterScreen());

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  double screenHeight;
  bool _isChecked = false;
  GlobalKey<FormState> _key = new GlobalKey(); //Global Key
  String urlRegister = "https://justminedb.com/mobileminer/php/register_user.php";
  TextEditingController _nameEditingController = new TextEditingController();
  TextEditingController _emailEditingController = new TextEditingController();
  TextEditingController _phoneditingController = new TextEditingController();
  TextEditingController _passwordEditingController = new TextEditingController();
  bool _validate = false;
  String name, email, phone, password;

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: new ThemeData(
        primarySwatch: Colors.brown,
      ),
      title: 'Material App',
      home: Scaffold(
          resizeToAvoidBottomPadding: false,
          body: Stack(
            children: <Widget>[
              partA(context),
              partB(context),
              pageTitle(),
            ],
          )),
    );
  }

  Widget partA(BuildContext context) {
    return Container(
      height: screenHeight,
      child: Image.asset(
        'assets/images/mp2.png',
        fit: BoxFit.cover,
      ),
    );
  }

  Widget partB(BuildContext context) {
    return Container(
      height: 600,
      margin: EdgeInsets.only(top: screenHeight / 3.5),
      padding: EdgeInsets.only(left: 10, right: 10),
      child: Column(
        children: <Widget>[
          Center(
              child: new Form(
                key: _key,
                autovalidate: _validate,
                child: signUpInfo(),
              )),

          //For go back to Login page
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              GestureDetector(
                onTap: _loginScreen,
                child: Text(
                  "I'm already a member",
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  //For sign up information
  Widget signUpInfo() {
    return new Container(
      padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
      child: Column(
        children: <Widget>[
          SizedBox(height: 50),
          Align(
            alignment: Alignment.topLeft,
          ),

          //Name
          new TextFormField(
            controller: _nameEditingController,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              labelText: 'Name',
              labelStyle: new TextStyle(
                color: Colors.black,
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.black),
              ),
              icon: Icon(Icons.account_circle, color: Colors.black),
            ),
            validator: validateName,
            onSaved: (String val) {
              name = val;
            },
          ),

          //Email
          new TextFormField(
              controller: _emailEditingController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: 'Email',
                labelStyle: new TextStyle(
                  color: Colors.black,
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
                icon: Icon(Icons.email, color: Colors.black),
              ),
              validator: validateEmail,
              onSaved: (String val) {
                email = val;
              }),

          //Phone number
          new TextFormField(
              controller: _phoneditingController,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                labelText: 'Phone number',
                labelStyle: new TextStyle(
                  color: Colors.black,
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
                icon: Icon(Icons.phone_android, color: Colors.black),
              ),
              validator: validatePhone,
              onSaved: (String val) {
                phone = val;
              }),

          //Password   
          new TextFormField(
              controller: _passwordEditingController,
              decoration: InputDecoration(
                labelText: 'Password',
                labelStyle: new TextStyle(
                  color: Colors.black,
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
                icon: Icon(Icons.lock, color: Colors.black),
              ),
              obscureText: true,
              validator: validatePass,
              onSaved: (String val) {
                password = val;
              }
              ),
      
          SizedBox(
            height: 20,
          ),

          //Accept Term
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Checkbox(
                  value: _isChecked,
                  onChanged: (bool value) {
                    _onChange(value);
                  },
                ),
                Text('I accept to the',
                    style: TextStyle(
                      fontSize: 16,
                    )),

               //Click for show EULA
                GestureDetector(
                  onTap: _showEULA,
                  child: Text('Terms and Condition',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline)),
                ),
              ]),

          //Sign Up button
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.fromLTRB(20, 0, 12, 0),
                  child: MaterialButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0)),
                    minWidth: 300,
                    height: 50,
                    child: Text('SIGN UP'),
                    color: Colors.teal[400],
                    textColor: Colors.white,
                    elevation: 10,
                    onPressed: _onRegister,
                  ),
                ),
              ]),
        ],
      ),
    );
  }

//Title for sign up page
  Widget pageTitle() {
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
              padding: EdgeInsets.fromLTRB(50, 220, 50, 100),
              child: Text(
                "SIGN UP",
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.w900),
              )),
        ],
      ),
    );
  }

  //Notice for registration
  void _register1() {
    if (_key.currentState.validate()) {
      String _name = _nameEditingController.text;
      String _email = _emailEditingController.text;
      String _phone = _phoneditingController.text;
      String _password = _passwordEditingController.text;
   
    http.post(urlRegister, body: {
      "name": _name,
      "email": _email,
      "password": _password,
      "phone": _phone,
    }).then((res) {
      if (res.body == "success") {
        Navigator.pop(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => LoginScreen()));
        Toast.show("Registration success", context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      } else {
        Toast.show("Registration failed", context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      }
    }).catchError((err) {
      print(err);
    });
  }
  else {
      setState(() {
        _validate = true;
      });
    }
  }

  void _onRegister() {
    if (!_isChecked) {
      Toast.show("Please Accept Term Before Proceed", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      return;
    }
    // confirmation for information
    showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: Text("Is your information is correct?") ,
            content: new Text("Please confirm your information is correct."),
            actions: <Widget>[
              MaterialButton(
                  onPressed: () {
                    Navigator.of(context).pop(_register1());
                  },
                  child: Text("Yes")),
              MaterialButton(
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                  child: Text("No")),
            ],
          ),
        ); 
        
  }

  void _loginScreen() {
    Navigator.pop(context,
        MaterialPageRoute(builder: (BuildContext context) => LoginScreen()));
  }

  void _onChange(bool value) {
    setState(() {
      _isChecked = value;
      //savepref(value);
    });
  }

  void _showEULA() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("EULA"),
          content: new Container(
            height: screenHeight / 2,
            child: Column(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: new SingleChildScrollView(
                    child: RichText(
                        softWrap: true,
                        textAlign: TextAlign.justify,
                        text: TextSpan(
                            style: TextStyle(
                              color: Colors.black,
                              //fontWeight: FontWeight.w500,
                              fontSize: 12.0,
                            ),
                            text:
                                "This End-User License Agreement is a legal agreement between you and Slumberjer This EULA agreement governs your acquisition and use of our MOBILE MINER software (Software) directly from Slumberjer or indirectly through a Slumberjer authorized reseller or distributor (a Reseller).Please read this EULA agreement carefully before completing the installation process and using the MOBILE MINER software. It provides a license to use the MOBILE MINER software and contains warranty information and liability disclaimers. If you register for a free trial of the MOBILE MINER software, this EULA agreement will also govern that trial. By clicking accept or installing and/or using the MOBILE MINER software, you are confirming your acceptance of the Software and agreeing to become bound by the terms of this EULA agreement. If you are entering into this EULA agreement on behalf of a company or other legal entity, you represent that you have the authority to bind such entity and its affiliates to these terms and conditions. If you do not have such authority or if you do not agree with the terms and conditions of this EULA agreement, do not install or use the Software, and you must not accept this EULA agreement.This EULA agreement shall apply only to the Software supplied by Slumberjer herewith regardless of whether other software is referred to or described herein. The terms also apply to any Slumberjer updates, supplements, Internet-based services, and support services for the Software, unless other terms accompany those items on delivery. If so, those terms apply. This EULA was created by EULA Template for MOBILE MINER. Slumberjer shall at all times retain ownership of the Software as originally downloaded by you and all subsequent downloads of the Software by you. The Software (and the copyright, and other intellectual property rights of whatever nature in the Software, including any modifications made thereto) are and shall remain the property of Slumberjer. Slumberjer reserves the right to grant licences to use the Software to third parties"
                            //children: getSpan(),
                            )),
                  ),
                )
              ],
            ),
          ),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        );
      },
    );
  }
}
//validator for name
  String validateName(String value) {
    String patttern = r'(^[a-zA-Z ]*$)';
    RegExp regExp = new RegExp(patttern);
    if (value.length == 0) {
      return "Name is Required";
    } else if (!regExp.hasMatch(value)) {
      return "Name must be a-z and A-Z";
    }
    return null;
  }

//validator for Phone
  String validatePhone(String value) {
    String patttern = r'(^[0-9]*$)';
    RegExp regExp = new RegExp(patttern);
    if (value.length == 0) {
      return "Mobile is Required";
    } else if (value.length < 10) {
      return "Mobile number must be at least 10 digits";
    } else if (!regExp.hasMatch(value)) {
      return "Mobile Number must be digits";
    }
    return null;
  }

//validator for Email
  String validateEmail(String value) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = new RegExp(pattern);
    if (value.length == 0) {
      return "Email is Required";
    } else if (!regExp.hasMatch(value)) {
      return "Invalid Email";
    } else {
      return null;
    }
  }

//validator for Password
String validatePass(String value) {
  if (value.length == 0) {
    return "Password is Required";
  } else if (value.length < 6) {
    return "Password must be at least 6 alphanumerics";
  } 
  return null;
}
