import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobileminer/registerscreen.dart';
import 'package:http/http.dart' as http;
import 'package:mobileminer/user.dart';
import 'package:toast/toast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mobileminer/mainscreen.dart';
import 'package:progress_dialog/progress_dialog.dart';

void main() => runApp(LoginScreen());
bool rememberMe = false;

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  double screenHeight;
  TextEditingController _emailEditingController = new TextEditingController();
  TextEditingController _passEditingController = new TextEditingController();
  String urlLogin = "https://justminedb.com/mobileminer/php/login_user.php";

  @override
  void initState() {
    super.initState();
    print("Hello i'm in INITSTATE");
    loadPref();
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
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
        'assets/images/mp.png',
        fit: BoxFit.cover,
      ),
    );
  }

  Widget partB(BuildContext context) {
    return Container(
      height: 500,
      margin: EdgeInsets.only(top: screenHeight / 3),
      padding: EdgeInsets.only(left: 10, right: 10),
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.fromLTRB(30, 20, 30, 10),
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 50,
                ),
                Align(
                  alignment: Alignment.topLeft,
                ),

                //Email
                TextField(
                    controller: _emailEditingController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      labelStyle: new TextStyle(fontFamily: 'Solway',
                        color: Colors.white,
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      icon: Icon(Icons.email, color: Colors.white),
                    )),

                //Password
                TextField(
                  controller: _passEditingController,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    labelStyle: new TextStyle(fontFamily: 'Solway',
                      color: Colors.white,
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    icon: Icon(Icons.lock, color: Colors.white),
                  ),
                  obscureText: true,
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
             
                  children: <Widget>[
                    Checkbox(
                      value: rememberMe,
                      onChanged: (bool value) {
                        _onRememberMeChanged(value);
                      },
                    ),
                    Padding(
                      padding: EdgeInsets.only(),
                      child: Text('Remember Me ',
                          style: TextStyle(fontFamily: 'Solway',
                              fontSize: 16  ,
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                    ),
                 
                  ],
                ),
               

                //Login button
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.fromLTRB(35.5, 40, 2, 20),
                      child: MaterialButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0)),
                        minWidth: 250,
                        height: 50,
                        child: Text(
                          'LOG IN',
                          style: TextStyle(fontFamily: 'Solway',fontSize: 16),
                        ),
                        color: Colors.teal[400],
                        textColor: Colors.white,
                        elevation: 10,
                        onPressed: _userLogin,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          //-------- OR --------
          Row(
            children: <Widget>[
              SizedBox(width: 60),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                child: Container(
                  height: 1.0,
                  width: 100.0,
                  color: Colors.white,
                ),
              ),
              new Text(
                "OR",
                style: TextStyle(fontFamily: 'Solway',
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                child: Container(
                  height: 1.0,
                  width: 100.0,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                child: Container(
                  height: 8.0,
                  width: 100.0,
                  color: Colors.transparent,
                ),
              ),
            ],
          ),

          //Go to sign up page
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(10, 20, 2, 20),
                child: MaterialButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0)),
                  minWidth: 250,
                  height: 50,
                  child: Text(
                    'SIGN UP',
                    style: TextStyle(fontFamily: 'Solway',fontSize: 16),
                  ),
                  color: Colors.teal[400],
                  textColor: Colors.white,
                  elevation: 10,
                  onPressed: _registerUser,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  //Title for Login page
  Widget pageTitle() {
    return Container(
      margin: EdgeInsets.only(top: 60),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
              padding: EdgeInsets.fromLTRB(50, 182, 50, 100),
              child: Text(
                "LOGIN",
                style: TextStyle(fontFamily: 'Solway',
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.w900),
              )),
        ],
      ),
    );
  }

  //Notice for login sucess or failure
  void _userLogin() async{
    try {
      ProgressDialog pr = new ProgressDialog(context,
          type: ProgressDialogType.Normal, isDismissible: false);
      pr.style(message: "Log in...");
      pr.show();
      String _email = _emailEditingController.text;
      String _password = _passEditingController.text;

      http.post(urlLogin, body: {
        "email": _email,
        "password": _password,
      })
          //.timeout(const Duration(seconds: 4))
          .then((res) {
        print(res.body);
        var string = res.body;
        List userdata = string.split(",");
        if (userdata[0] == "success") {
          User _user = new User(
              name: userdata[1],
              email: _email,
              password: _password,
              phone: userdata[3],
              quantity: userdata[4]);
          pr.hide();
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => MainScreen(
                        user: _user,
                      )));
        } else {
          pr.hide();
          Toast.show("Login failed", context,
              duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
        }
      }).catchError((err) {
        print(err);
        pr.hide();
      });
    } on Exception catch (_) {
      Toast.show("Error", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    }
  }

  void _registerUser() {
    Navigator.push(context,
        MaterialPageRoute(builder: (BuildContext context) => RegisterScreen()));
  }

  //Forget Password
 /* void _forgotPassword() {
    TextEditingController phoneController = TextEditingController();
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Forget Password?", style: TextStyle(fontFamily: 'Solway',),),
          content: new Container(
            height: 150,
            child: Column(
              children: <Widget>[
                Text(
                  "Please enter your recovery email. A reset password email will send to the inbox of the recovery email. ", style: TextStyle(fontFamily: 'Solway',),
                ),
                TextField(
                    decoration: InputDecoration(
                  labelText: 'Email',
                  icon: Icon(Icons.email, color: Colors.black),
                ))
              ],
            ),
          ),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Yes", style: TextStyle(fontFamily: 'Solway',),),
              onPressed: () {
                Navigator.of(context).pop();
                print(
                  phoneController.text,
                );
              },
            ),
            new FlatButton(
              child: new Text("No", style: TextStyle(fontFamily: 'Solway',),),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }*/

  //Exit the application
  Future<bool> _onBackPressed() {
    return showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            content: new Text('Are you sure you want to close application?'),
            actions: <Widget>[
              MaterialButton(
                  onPressed: () {
                    SystemChannels.platform.invokeMethod('SystemNavigator.pop');
                  },
                  child: Text("Yes", style: TextStyle(fontFamily: 'Solway',),)),
              MaterialButton(
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                  child: Text("No", style: TextStyle(fontFamily: 'Solway',),)),
            ],
          ),
        ) ??
        false;
  }

  void loadPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String email = (prefs.getString('email')) ?? '';
    String password = (prefs.getString('pass')) ?? '';
    if (email.length > 1) {
      setState(() {
        _emailEditingController.text = email;
        _passEditingController.text = password;
        rememberMe = true;
      });
    }
  }

  void savepref(bool value) async {
    String email = _emailEditingController.text;
    String password = _passEditingController.text;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (value) {
      //save preference
      await prefs.setString('email', email);
      await prefs.setString('pass', password);
      Toast.show("Preferences have been saved", context,
          duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
    } else {
      //delete preference
      await prefs.setString('email', '');
      await prefs.setString('pass', '');
      setState(() {
        _emailEditingController.text = '';
        _passEditingController.text = '';
        rememberMe = false;
      });
      Toast.show("Preferences have removed", context,
          duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
    }
  }

  void _onRememberMeChanged(bool newValue) => setState(() {
        rememberMe = newValue;
        print(rememberMe);
        if (rememberMe) {
          savepref(true);
        } else {
          savepref(false);
        }
      });
}
