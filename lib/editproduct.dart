import 'dart:convert';
import 'dart:io';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:progress_dialog/progress_dialog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'product.dart';
import 'user.dart';

class EditProduct extends StatefulWidget {
  final User user;
  final Product product;

  const EditProduct({Key key, this.user, this.product}) : super(key: key);

  @override
  _EditProductState createState() => _EditProductState();
}

class _EditProductState extends State<EditProduct> {
  final GlobalKey<ScaffoldState> _scaffold = new GlobalKey<ScaffoldState>();

  String server = "https://justminedb.com/mobileminer";
  TextEditingController prnameEditingController = new TextEditingController();
  TextEditingController priceEditingController = new TextEditingController();
  TextEditingController qtyEditingController = new TextEditingController();
  TextEditingController typeEditingController = new TextEditingController();
  TextEditingController osEditingController = new TextEditingController();
  TextEditingController batteryEditingController = new TextEditingController();
  TextEditingController sensorEditingController = new TextEditingController();
  TextEditingController memoryEditingController = new TextEditingController();
  TextEditingController weightEditingController = new TextEditingController();
  double screenHeight, screenWidth;
  final focus0 = FocusNode();
  final focus1 = FocusNode();
  final focus2 = FocusNode();
  final focus3 = FocusNode();
  final focus4 = FocusNode();
  final focus5 = FocusNode();
  final focus6 = FocusNode();
  final focus7 = FocusNode();
  final focus8 = FocusNode();

  File _image;
  bool _takepicture = true;
  bool _takepicturelocal = false;
  String selectedType;

  @override
  void initState() {
    super.initState();
    print("edit Product");
    prnameEditingController.text = widget.product.name;
    priceEditingController.text = widget.product.price;
    qtyEditingController.text = widget.product.quantity;
    typeEditingController.text = widget.product.type;
    osEditingController.text = widget.product.os;
    batteryEditingController.text = widget.product.battery;
    sensorEditingController.text = widget.product.sensor;
    memoryEditingController.text = widget.product.memory;
    weightEditingController.text = widget.product.weight;
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      key: _scaffold,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        title: Text(
          'Edit Product',
          style: TextStyle(fontFamily: "Solway"),
        ),
      ),
      body: Container(
        alignment: Alignment.topCenter,
        child: SingleChildScrollView(
            child: Column(
          children: <Widget>[
            SizedBox(height: 10),
            GestureDetector(
                onTap: _choose,
                child: Column(
                  children: [
                    Visibility(
                      visible: _takepicture,
                      child: Container(
                        height: screenHeight / 3,
                        width: screenWidth / 1.5,
                        child: CachedNetworkImage(
                          fit: BoxFit.fill,
                          imageUrl:
                              server + "/productimage1/${widget.product.id}.jpg",
                          placeholder: (context, url) =>
                              new CircularProgressIndicator(),
                          errorWidget: (context, url, error) =>
                              new Icon(Icons.error),
                        ),
                      ),
                    ),
                    Visibility(
                        visible: _takepicturelocal,
                        child: Container(
                          height: screenHeight / 3,
                          width: screenWidth / 1.5,
                          decoration: BoxDecoration(
                            image: new DecorationImage(
                              colorFilter: new ColorFilter.mode(
                                  Colors.black.withOpacity(0.6),
                                  BlendMode.dstATop),
                              image: _image == null
                                  ? AssetImage('assets/images/phonecam.png')
                                  : FileImage(_image),
                              fit: BoxFit.cover,
                            ),
                          ),
                        )),
                  ],
                )),
            SizedBox(height: 6),
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
                                      height: 30,
                                      child: Container(
                                          alignment: Alignment.centerLeft,
                                          height: 30,
                                          child: Text(
                                            " " + widget.product.id,
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontFamily: "Solway",
                                            ),
                                          )),
                                    )),
                                  ]),
                                  TableRow(children: [
                                    TableCell(
                                      child: Container(
                                          alignment: Alignment.centerLeft,
                                          height: 30,
                                          child: Text("Product Name",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold, fontFamily: "Solway",
                                                color: Colors.black,
                                              ))),
                                    ),
                                    TableCell(
                                      child: Container(
                                        margin: EdgeInsets.fromLTRB(5, 1, 5, 1),
                                        height: 30,
                                        child: TextFormField(
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontFamily: "Solway",
                                            ),
                                            controller: prnameEditingController,
                                            keyboardType: TextInputType.text,
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
                                              border: new OutlineInputBorder(
                                                borderRadius:
                                                    new BorderRadius.circular(
                                                        5.0),
                                                borderSide: new BorderSide(),
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
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: "Solway",
                                                  color: Colors.black))),
                                    ),
                                    TableCell(
                                      child: Container(
                                        margin: EdgeInsets.fromLTRB(5, 1, 5, 1),
                                        height: 30,
                                        child: TextFormField(
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontFamily: "Solway",
                                            ),
                                            controller: priceEditingController,
                                            keyboardType: TextInputType.number,
                                            textInputAction:
                                                TextInputAction.next,
                                            focusNode: focus0,
                                            onFieldSubmitted: (v) {
                                              FocusScope.of(context)
                                                  .requestFocus(focus1);
                                            },
                                            decoration: new InputDecoration(
                                              fillColor: Colors.black,
                                              border: new OutlineInputBorder(
                                                borderRadius:
                                                    new BorderRadius.circular(
                                                        5.0),
                                                borderSide: new BorderSide(),
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
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: "Solway",
                                                  color: Colors.black))),
                                    ),
                                    TableCell(
                                      child: Container(
                                        margin: EdgeInsets.fromLTRB(5, 1, 5, 1),
                                        height: 30,
                                        child: TextFormField(
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontFamily: "Solway",
                                            ),
                                            controller: qtyEditingController,
                                            keyboardType: TextInputType.number,
                                            textInputAction:
                                                TextInputAction.next,
                                            focusNode: focus1,
                                            onFieldSubmitted: (v) {
                                              FocusScope.of(context)
                                                  .requestFocus(focus2);
                                            },
                                            decoration: new InputDecoration(
                                              fillColor: Colors.black,
                                              border: new OutlineInputBorder(
                                                borderRadius:
                                                    new BorderRadius.circular(
                                                        5.0),
                                                borderSide: new BorderSide(),
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
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: "Solway",
                                                  color: Colors.black))),
                                    ),
                                    TableCell(
                                      child: Container(
                                        margin: EdgeInsets.fromLTRB(5, 1, 5, 1),
                                        height: 30,
                                        child: TextFormField(
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontFamily: "Solway",
                                            ),
                                            controller: typeEditingController,
                                            keyboardType: TextInputType.text,
                                            textInputAction:
                                                TextInputAction.next,
                                            focusNode: focus2,
                                            onFieldSubmitted: (v) {
                                              FocusScope.of(context)
                                                  .requestFocus(focus3);
                                            },
                                            decoration: new InputDecoration(
                                              fillColor: Colors.black,
                                              border: new OutlineInputBorder(
                                                borderRadius:
                                                    new BorderRadius.circular(
                                                        5.0),
                                                borderSide: new BorderSide(),
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
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: "Solway",
                                                  color: Colors.black))),
                                    ),
                                    TableCell(
                                      child: Container(
                                        margin: EdgeInsets.fromLTRB(5, 1, 5, 1),
                                        height: 30,
                                        child: TextFormField(
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontFamily: "Solway",
                                            ),
                                            controller: osEditingController,
                                            keyboardType: TextInputType.text,
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
                                              border: new OutlineInputBorder(
                                                borderRadius:
                                                    new BorderRadius.circular(
                                                        5.0),
                                                borderSide: new BorderSide(),
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
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: "Solway",
                                                  color: Colors.black))),
                                    ),
                                    TableCell(
                                      child: Container(
                                        margin: EdgeInsets.fromLTRB(5, 1, 5, 1),
                                        height: 30,
                                        child: TextFormField(
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontFamily: "Solway",
                                            ),
                                            controller:
                                                batteryEditingController,
                                            keyboardType: TextInputType.text,
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
                                              border: new OutlineInputBorder(
                                                borderRadius:
                                                    new BorderRadius.circular(
                                                        5.0),
                                                borderSide: new BorderSide(),
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
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: "Solway",
                                                  color: Colors.black))),
                                    ),
                                    TableCell(
                                      child: Container(
                                        margin: EdgeInsets.fromLTRB(5, 1, 5, 1),
                                        height: 30,
                                        child: TextFormField(
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontFamily: "Solway",
                                            ),
                                            controller: sensorEditingController,
                                            keyboardType: TextInputType.text,
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
                                              border: new OutlineInputBorder(
                                                borderRadius:
                                                    new BorderRadius.circular(
                                                        5.0),
                                                borderSide: new BorderSide(),
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
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: "Solway",
                                                  color: Colors.black))),
                                    ),
                                    TableCell(
                                      child: Container(
                                        margin: EdgeInsets.fromLTRB(5, 1, 5, 1),
                                        height: 30,
                                        child: TextFormField(
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontFamily: "Solway",
                                            ),
                                            controller: memoryEditingController,
                                            keyboardType: TextInputType.text,
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
                                              border: new OutlineInputBorder(
                                                borderRadius:
                                                    new BorderRadius.circular(
                                                        5.0),
                                                borderSide: new BorderSide(),
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
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: "Solway",
                                                  color: Colors.black))),
                                    ),
                                    TableCell(
                                      child: Container(
                                        margin: EdgeInsets.fromLTRB(5, 1, 5, 1),
                                        height: 30,
                                        child: TextFormField(
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontFamily: "Solway",
                                            ),
                                            controller: weightEditingController,
                                            keyboardType: TextInputType.number,
                                            textInputAction:
                                                TextInputAction.next,
                                            focusNode: focus7,
                                            onFieldSubmitted: (v) {
                                              FocusScope.of(context)
                                                  .requestFocus(focus8);
                                            },
                                            decoration: new InputDecoration(
                                              fillColor: Colors.black,
                                              border: new OutlineInputBorder(
                                                borderRadius:
                                                    new BorderRadius.circular(
                                                        5.0),
                                                borderSide: new BorderSide(),
                                              ),
                                            )),
                                      ),
                                    ),
                                  ]),
                                ]),
                            SizedBox(height: 3),
                            MaterialButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0)),
                              minWidth: screenWidth / 1.5,
                              height: 40,
                              child: Text(
                                'Update Product',
                                style: TextStyle(
                                  fontFamily: "Solway",
                                ),
                              ),
                              color: Colors.blue,
                              textColor: Colors.white,
                              elevation: 5,
                              onPressed: () => updateProductDialog(),
                            ),
                          ],
                        )))),
          ],
        )),
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
      setState(() {
        _takepicture = false;
        _takepicturelocal = true;
      });
    }
  }

  updateProductDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          title: new Text(
            "Update Product ID " + widget.product.id,
            style: TextStyle(
              color: Colors.black,
              fontFamily: "Solway",
            ),
          ),
          content: new Text("Are you sure?",
              style: TextStyle(
                color: Colors.black,
                fontFamily: "Solway",
              )),
          actions: <Widget>[
            new FlatButton(
              child: new Text(
                "Yes",
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: "Solway",
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                updateProduct();
              },
            ),
            new FlatButton(
              child: new Text(
                "No",
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: "Solway",
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

  updateProduct() {
    if (prnameEditingController.text.length < 4) {
      final snackBar = SnackBar(
        content: Text(
          'Please enter the correct information',
          style: TextStyle(fontFamily: "Solway", color: Colors.white),
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
          'Please enter the correct information',
          style: TextStyle(fontFamily: "Solway", color: Colors.white),
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
          'Please enter the correct information',
          style: TextStyle(fontFamily: "Solway", color: Colors.white),
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
    if (typeEditingController.text.length < 1) {
      final snackBar = SnackBar(
        content: Text(
          'Please enter the correct information',
          style: TextStyle(fontFamily: "Solway", color: Colors.white),
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

    if (osEditingController.text.length < 1) {
      final snackBar = SnackBar(
        content: Text(
          'Please enter the correct information',
          style: TextStyle(fontFamily: "Solway", color: Colors.white),
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
    if (batteryEditingController.text.length < 1) {
      final snackBar = SnackBar(
        content: Text(
          'Please enter the correct information',
          style: TextStyle(fontFamily: "Solway", color: Colors.white),
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
    if (sensorEditingController.text.length < 1) {
      final snackBar = SnackBar(
        content: Text(
          'Please enter the correct information',
          style: TextStyle(fontFamily: "Solway", color: Colors.white),
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
    if (memoryEditingController.text.length < 1) {
      final snackBar = SnackBar(
        content: Text(
          'Please enter the correct information',
          style: TextStyle(fontFamily: "Solway", color: Colors.white),
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
          'Please enter the correct information',
          style: TextStyle(fontFamily: "Solway", color: Colors.white),
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

    double price = double.parse(priceEditingController.text);

    ProgressDialog pr = new ProgressDialog(context,
        type: ProgressDialogType.Normal, isDismissible: false);
    pr.style(message: "Updating product...");
    pr.show();
    String base64Image;

    if (_image != null) {
      base64Image = base64Encode(_image.readAsBytesSync());
      http.post(server + "/php/update_product.php", body: {
        "id": widget.product.id,
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
        if (res.body == "failed") {
          final snackBar = SnackBar(
            content: Text(
              'Update failed',
              style: TextStyle(fontFamily: "Solway", color: Colors.white),
            ),
            action: SnackBarAction(
              label: 'Close',
              textColor: Colors.white,
              onPressed: () {},
            ),
          );

          _scaffold.currentState.showSnackBar(snackBar);
          Navigator.of(context).pop();
        } else {
          final snackBar = SnackBar(
            content: Text(
              'Update Success',
              style: TextStyle(fontFamily: "Solway", color: Colors.white),
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
    } else {
      http.post(server + "/php/update_product.php", body: {
        "id": widget.product.id,
        "name": prnameEditingController.text,
        "quantity": qtyEditingController.text,
        "price": price.toStringAsFixed(2),
        "type": typeEditingController.text,
        "os": osEditingController.text,
        "battery": batteryEditingController.text,
        "sensor": sensorEditingController.text,
        "memory": memoryEditingController.text,
        "weight": weightEditingController.text,
      }).then((res) {
        print(res.body);
        pr.hide();
        if (res.body == "success") {
          final snackBar = SnackBar(
            content: Text(
              'Update Success',
              style: TextStyle(fontFamily: "Solway", color: Colors.white),
            ),
            action: SnackBarAction(
              label: 'Close',
              textColor: Colors.white,
              onPressed: () {Navigator.of(context).pop();},
            ),
          );

          _scaffold.currentState.showSnackBar(snackBar);
          
        } else {
          final snackBar = SnackBar(
            content: Text(
              'Update Failed',
              style: TextStyle(fontFamily: "Solway", color: Colors.white),
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
}
