import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:progress_dialog/progress_dialog.dart';
import 'package:image_cropper/image_cropper.dart';

class NewProduct1 extends StatefulWidget {
  @override
  _NewProduct1State createState() => _NewProduct1State();
}

class _NewProduct1State extends State<NewProduct1> {
  String server = "https://justminedb.com/mobileminer";
  final GlobalKey<ScaffoldState> _scaffold = new GlobalKey<ScaffoldState>();

  double screenHeight, screenWidth;
  File _image;
  String pathAsset = 'assets/images/phonecam.png';
  TextEditingController idEditingController = new TextEditingController();
  TextEditingController prnameEditingController = new TextEditingController();
  TextEditingController priceEditingController = new TextEditingController();
  TextEditingController qtyEditingController = new TextEditingController();
  TextEditingController typeEditingController = new TextEditingController();
  TextEditingController osEditingController = new TextEditingController();
  TextEditingController batteryEditingController = new TextEditingController();
  TextEditingController sensorEditingController = new TextEditingController();
  TextEditingController memoryEditingController = new TextEditingController();
  TextEditingController weightEditingController = new TextEditingController();
  final focus0 = FocusNode();
  final focus1 = FocusNode();
  final focus2 = FocusNode();
  final focus3 = FocusNode();
  final focus4 = FocusNode();
  final focus5 = FocusNode();
  final focus6 = FocusNode();
  final focus7 = FocusNode();
  final focus8 = FocusNode();
  final focus9 = FocusNode();
  String selectedType;

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      key: _scaffold,
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        title: Text(
          'New Product',
          style: TextStyle(fontFamily: "Solway"),
        ),
      ),
      body: Center(
        child: Container(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                SizedBox(height: 6),
                GestureDetector(
                    onTap: () => {_choose()},
                    child: Container(
                      height: screenHeight / 3,
                      width: screenWidth / 1.5,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: _image == null
                              ? AssetImage(pathAsset)
                              : FileImage(_image),
                          fit: BoxFit.cover,
                        ),
                        border: Border.all(
                          width: 3.0,
                          color: Colors.grey,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      ),
                    )),
                SizedBox(height: 5),
                Text("Click the above image to take picture of your product",
                    style: TextStyle(fontSize: 10.0, color: Colors.black, fontFamily: "Solway")),
                SizedBox(height: 5),
                Container(
                    width: screenWidth / 1.2,
                    child: Card(
                        elevation: 6,
                        child: Padding(
                            padding: EdgeInsets.all(10),
                            child: Column(
                              children: <Widget>[
                                Table(
                                    defaultColumnWidth: FlexColumnWidth(1.0),
                                    children: [
                                      TableRow(children: [
                                        TableCell(
                                          child: Container(
                                              alignment: Alignment.centerLeft,
                                              height: 30,
                                              child: Text("Product ID",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily: "Solway",
                                                    color: Colors.black,
                                                  ))),
                                        ),
                                        TableCell(
                                          child: Container(
                                            margin:
                                                EdgeInsets.fromLTRB(5, 1, 5, 1),
                                            height: 30,
                                            child: TextFormField(
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontFamily: "Solway",
                                                ),
                                                controller: idEditingController,
                                                keyboardType:
                                                    TextInputType.text,
                                                textInputAction:
                                                    TextInputAction.next,
                                                onFieldSubmitted: (v) {
                                                  FocusScope.of(context)
                                                      .requestFocus(focus0);
                                                },
                                                decoration: new InputDecoration(
                                                  contentPadding:
                                                      const EdgeInsets.all(5),
                                                  fillColor: Colors.black,
                                                  border:
                                                      new OutlineInputBorder(
                                                    borderRadius:
                                                        new BorderRadius
                                                            .circular(5.0),
                                                    borderSide:
                                                        new BorderSide(),
                                                  ),
                                                )),
                                          ),
                                        ),
                                      ]),
                                      TableRow(children: [
                                        TableCell(
                                          child: Container(
                                              alignment: Alignment.centerLeft,
                                              height: 30,
                                              child: Text("Product Name",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily: "Solway",
                                                    color: Colors.black,
                                                  ))),
                                        ),
                                        TableCell(
                                          child: Container(
                                            margin:
                                                EdgeInsets.fromLTRB(5, 1, 5, 1),
                                            height: 30,
                                            child: TextFormField(
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontFamily: "Solway",
                                                ),
                                                controller:
                                                    prnameEditingController,
                                                keyboardType:
                                                    TextInputType.text,
                                                textInputAction:
                                                    TextInputAction.next,
                                                onFieldSubmitted: (v) {
                                                  FocusScope.of(context)
                                                      .requestFocus(focus0);
                                                },
                                                decoration: new InputDecoration(
                                                  contentPadding:
                                                      const EdgeInsets.all(5),
                                                  fillColor: Colors.black,
                                                  border:
                                                      new OutlineInputBorder(
                                                    borderRadius:
                                                        new BorderRadius
                                                            .circular(5.0),
                                                    borderSide:
                                                        new BorderSide(),
                                                  ),
                                                )),
                                          ),
                                        ),
                                      ]),
                                      TableRow(children: [
                                        TableCell(
                                          child: Container(
                                              alignment: Alignment.centerLeft,
                                              height: 30,
                                              child: Text("Price (RM)",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontFamily: "Solway",
                                                      color: Colors.black))),
                                        ),
                                        TableCell(
                                          child: Container(
                                            margin:
                                                EdgeInsets.fromLTRB(5, 1, 5, 1),
                                            height: 30,
                                            child: TextFormField(
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontFamily: "Solway",
                                                ),
                                                controller:
                                                    priceEditingController,
                                                keyboardType:
                                                    TextInputType.number,
                                                textInputAction:
                                                    TextInputAction.next,
                                                focusNode: focus0,
                                                onFieldSubmitted: (v) {
                                                  FocusScope.of(context)
                                                      .requestFocus(focus1);
                                                },
                                                decoration: new InputDecoration(
                                                  fillColor: Colors.black,
                                                  border:
                                                      new OutlineInputBorder(
                                                    borderRadius:
                                                        new BorderRadius
                                                            .circular(5.0),
                                                    borderSide:
                                                        new BorderSide(),
                                                  ),
                                                )),
                                          ),
                                        ),
                                      ]),
                                      TableRow(children: [
                                        TableCell(
                                          child: Container(
                                              alignment: Alignment.centerLeft,
                                              height: 30,
                                              child: Text("Quantity",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontFamily: "Solway",
                                                      color: Colors.black))),
                                        ),
                                        TableCell(
                                          child: Container(
                                            margin:
                                                EdgeInsets.fromLTRB(5, 1, 5, 1),
                                            height: 30,
                                            child: TextFormField(
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontFamily: "Solway",
                                                ),
                                                controller:
                                                    qtyEditingController,
                                                keyboardType:
                                                    TextInputType.number,
                                                textInputAction:
                                                    TextInputAction.next,
                                                focusNode: focus1,
                                                onFieldSubmitted: (v) {
                                                  FocusScope.of(context)
                                                      .requestFocus(focus2);
                                                },
                                                decoration: new InputDecoration(
                                                  fillColor: Colors.black,
                                                  border:
                                                      new OutlineInputBorder(
                                                    borderRadius:
                                                        new BorderRadius
                                                            .circular(5.0),
                                                    borderSide:
                                                        new BorderSide(),
                                                  ),
                                                )),
                                          ),
                                        ),
                                      ]),
                                      TableRow(children: [
                                        TableCell(
                                          child: Container(
                                              alignment: Alignment.centerLeft,
                                              height: 30,
                                              child: Text("Brand",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontFamily: "Solway",
                                                      color: Colors.black))),
                                        ),
                                        TableCell(
                                          child: Container(
                                            margin:
                                                EdgeInsets.fromLTRB(5, 1, 5, 1),
                                            height: 30,
                                            child: TextFormField(
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontFamily: "Solway",
                                                ),
                                                controller:
                                                    typeEditingController,
                                                keyboardType:
                                                    TextInputType.text,
                                                textInputAction:
                                                    TextInputAction.next,
                                                focusNode: focus2,
                                                onFieldSubmitted: (v) {
                                                  FocusScope.of(context)
                                                      .requestFocus(focus3);
                                                },
                                                decoration: new InputDecoration(
                                                  fillColor: Colors.black,
                                                  border:
                                                      new OutlineInputBorder(
                                                    borderRadius:
                                                        new BorderRadius
                                                            .circular(5.0),
                                                    borderSide:
                                                        new BorderSide(),
                                                  ),
                                                )),
                                          ),
                                        ),
                                      ]),
                                      TableRow(children: [
                                        TableCell(
                                          child: Container(
                                              alignment: Alignment.centerLeft,
                                              height: 30,
                                              child: Text("OS",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontFamily: "Solway",
                                                      color: Colors.black))),
                                        ),
                                        TableCell(
                                          child: Container(
                                            margin:
                                                EdgeInsets.fromLTRB(5, 1, 5, 1),
                                            height: 30,
                                            child: TextFormField(
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontFamily: "Solway",
                                                ),
                                                controller: osEditingController,
                                                keyboardType:
                                                    TextInputType.text,
                                                textInputAction:
                                                    TextInputAction.next,
                                                onFieldSubmitted: (v) {
                                                  FocusScope.of(context)
                                                      .requestFocus(focus0);
                                                },
                                                decoration: new InputDecoration(
                                                  contentPadding:
                                                      const EdgeInsets.all(5),
                                                  fillColor: Colors.black,
                                                  border:
                                                      new OutlineInputBorder(
                                                    borderRadius:
                                                        new BorderRadius
                                                            .circular(5.0),
                                                    borderSide:
                                                        new BorderSide(),
                                                  ),
                                                )),
                                          ),
                                        ),
                                      ]),
                                      TableRow(children: [
                                        TableCell(
                                          child: Container(
                                              alignment: Alignment.centerLeft,
                                              height: 30,
                                              child: Text("Battery",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontFamily: "Solway",
                                                      color: Colors.black))),
                                        ),
                                        TableCell(
                                          child: Container(
                                            margin:
                                                EdgeInsets.fromLTRB(5, 1, 5, 1),
                                            height: 30,
                                            child: TextFormField(
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontFamily: "Solway",
                                                ),
                                                controller:
                                                    batteryEditingController,
                                                keyboardType:
                                                    TextInputType.text,
                                                textInputAction:
                                                    TextInputAction.next,
                                                onFieldSubmitted: (v) {
                                                  FocusScope.of(context)
                                                      .requestFocus(focus0);
                                                },
                                                decoration: new InputDecoration(
                                                  contentPadding:
                                                      const EdgeInsets.all(5),
                                                  fillColor: Colors.black,
                                                  border:
                                                      new OutlineInputBorder(
                                                    borderRadius:
                                                        new BorderRadius
                                                            .circular(5.0),
                                                    borderSide:
                                                        new BorderSide(),
                                                  ),
                                                )),
                                          ),
                                        ),
                                      ]),
                                      TableRow(children: [
                                        TableCell(
                                          child: Container(
                                              alignment: Alignment.centerLeft,
                                              height: 30,
                                              child: Text("Sensor",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontFamily: "Solway",
                                                      color: Colors.black))),
                                        ),
                                        TableCell(
                                          child: Container(
                                            margin:
                                                EdgeInsets.fromLTRB(5, 1, 5, 1),
                                            height: 30,
                                            child: TextFormField(
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontFamily: "Solway",
                                                ),
                                                controller:
                                                    sensorEditingController,
                                                keyboardType:
                                                    TextInputType.text,
                                                textInputAction:
                                                    TextInputAction.next,
                                                onFieldSubmitted: (v) {
                                                  FocusScope.of(context)
                                                      .requestFocus(focus0);
                                                },
                                                decoration: new InputDecoration(
                                                  contentPadding:
                                                      const EdgeInsets.all(5),
                                                  fillColor: Colors.black,
                                                  border:
                                                      new OutlineInputBorder(
                                                    borderRadius:
                                                        new BorderRadius
                                                            .circular(5.0),
                                                    borderSide:
                                                        new BorderSide(),
                                                  ),
                                                )),
                                          ),
                                        ),
                                      ]),
                                      TableRow(children: [
                                        TableCell(
                                          child: Container(
                                              alignment: Alignment.centerLeft,
                                              height: 30,
                                              child: Text("Memory",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontFamily: "Solway",
                                                      color: Colors.black))),
                                        ),
                                        TableCell(
                                          child: Container(
                                            margin:
                                                EdgeInsets.fromLTRB(5, 1, 5, 1),
                                            height: 30,
                                            child: TextFormField(
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontFamily: "Solway",
                                                ),
                                                controller:
                                                    memoryEditingController,
                                                keyboardType:
                                                    TextInputType.text,
                                                textInputAction:
                                                    TextInputAction.next,
                                                onFieldSubmitted: (v) {
                                                  FocusScope.of(context)
                                                      .requestFocus(focus0);
                                                },
                                                decoration: new InputDecoration(
                                                  contentPadding:
                                                      const EdgeInsets.all(5),
                                                  fillColor: Colors.black,
                                                  border:
                                                      new OutlineInputBorder(
                                                    borderRadius:
                                                        new BorderRadius
                                                            .circular(5.0),
                                                    borderSide:
                                                        new BorderSide(),
                                                  ),
                                                )),
                                          ),
                                        ),
                                      ]),
                                      TableRow(children: [
                                        TableCell(
                                          child: Container(
                                              alignment: Alignment.centerLeft,
                                              height: 30,
                                              child: Text("Weight",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontFamily: "Solway",
                                                      color: Colors.black))),
                                        ),
                                        TableCell(
                                          child: Container(
                                            margin:
                                                EdgeInsets.fromLTRB(5, 1, 5, 1),
                                            height: 30,
                                            child: TextFormField(
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontFamily: "Solway",
                                                ),
                                                controller:
                                                    weightEditingController,
                                                keyboardType:
                                                    TextInputType.number,
                                                textInputAction:
                                                    TextInputAction.next,
                                                focusNode: focus7,
                                                onFieldSubmitted: (v) {
                                                  FocusScope.of(context)
                                                      .requestFocus(focus8);
                                                },
                                                decoration: new InputDecoration(
                                                  fillColor: Colors.black,
                                                  border:
                                                      new OutlineInputBorder(
                                                    borderRadius:
                                                        new BorderRadius
                                                            .circular(5.0),
                                                    borderSide:
                                                        new BorderSide(),
                                                  ),
                                                )),
                                          ),
                                        ),
                                      ]),
                                    ]),
                                SizedBox(height: 3),
                                MaterialButton(
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(10.0)),
                                  minWidth: screenWidth / 1.5,
                                  height: 40,
                                  child: Text(
                                    'Insert New Product',
                                    style: TextStyle(fontFamily: "Solway"),
                                  ),
                                  color: Colors.blue,
                                  textColor: Colors.white,
                                  elevation: 5,
                                  onPressed: _insertNewProduct,
                                ),
                              ],
                            )))),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _choose() async {
    _image = await ImagePicker.pickImage(
        source: ImageSource.camera, maxHeight: 800, maxWidth: 800);
    _cropImage();
    setState(() {});
  }

  Future<Null> _cropImage() async {
    File croppedFile = await ImageCropper.cropImage(
        sourcePath: _image.path,
        aspectRatioPresets: Platform.isAndroid
            ? [
                CropAspectRatioPreset.square,
              ]
            : [
                CropAspectRatioPreset.square,
              ],
        androidUiSettings: AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.deepOrange,
            toolbarWidgetColor: Colors.black,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        iosUiSettings: IOSUiSettings(
          title: 'Cropper',
        ));
    if (croppedFile != null) {
      _image = croppedFile;
      setState(() {});
    }
  }

  void _insertNewProduct() {
    if (_image == null) {
      final snackBar = SnackBar(
        content: Text(
          'Please take product picture',
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
    if (prnameEditingController.text.length < 4) {
      final snackBar = SnackBar(
        content: Text(
          'Please enter product name',
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
    if (qtyEditingController.text.length < 1) {
      final snackBar = SnackBar(
        content: Text(
          'Please enter product quantity',
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
    if (priceEditingController.text.length < 1) {
      final snackBar = SnackBar(
        content: Text(
          'Please enter product price',
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
    if (weightEditingController.text.length < 1) {
      final snackBar = SnackBar(
        content: Text(
          'Please enter product weight',
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
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          title: new Text(
            "Insert New Product ID " + idEditingController.text,
            style: TextStyle(color: Colors.black, fontFamily: "Solway"),
          ),
          actions: <Widget>[
            new FlatButton(
              child: new Text(
                "Yes",
                style: TextStyle(
                  fontFamily: "Solway",
                  color: Colors.black,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                insertProduct();
              },
            ),
            new FlatButton(
              child: new Text(
                "No",
                style: TextStyle(
                  fontFamily: "Solway",
                  color: Colors.black,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  insertProduct() {
    double price = double.parse(priceEditingController.text);

    ProgressDialog pr = new ProgressDialog(context,
        type: ProgressDialogType.Normal, isDismissible: false);
    pr.style(message: "Inserting new product...");
    pr.show();
    String base64Image = base64Encode(_image.readAsBytesSync());

    http.post(server + "/php/insert_product.php", body: {
      "id": idEditingController.text,
      "name": prnameEditingController.text,
      "quantity": qtyEditingController.text,
      "price": price.toStringAsFixed(2),
      "type": typeEditingController.text,
      "os": osEditingController.text,
      "battery": batteryEditingController.text,
      "sensor": sensorEditingController.text,
      "memory": memoryEditingController.text,
      "weight": weightEditingController.text,
      "encoded_string": base64Image,
    }).then((res) {
      print(res.body);
      pr.hide();

      if (res.body == "found") {
        final snackBar = SnackBar(
          content: Text(
            'Product ID existed!',
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
      if (res.body == "success") {
        final snackBar = SnackBar(
          content: Text(
            'Insert Product Successful',
            style: TextStyle(fontFamily: "Solway"),
          ),
          action: SnackBarAction(
            label: 'Close',
            textColor: Colors.white,
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        );

        _scaffold.currentState.showSnackBar(snackBar);
      } else {
        final snackBar = SnackBar(
          content: Text(
            'Insert Failed',
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
    }).catchError((err) {
      print(err);
      pr.hide();
    });
  }
}
