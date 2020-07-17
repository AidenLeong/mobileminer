import 'dart:async';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter/material.dart';
import 'user.dart';

class TopUp extends StatefulWidget {
  final User user;
  final String val;
  TopUp({this.user, this.val});
  @override
  _TopUpState createState() => _TopUpState();
}

class _TopUpState extends State<TopUp> {
  Completer<WebViewController> _controller = Completer<WebViewController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.indigo,
          title: Text('Top Up',
          style: TextStyle(fontFamily: 'Solway', color: Colors.white),),
        ),
        body: Column(
          children: <Widget>[
            Expanded(
              child: WebView(
                initialUrl:
                    'https://justminedb.com/mobileminer/php/topup.php?email=' +
                        widget.user.email +
                        '&mobile=' +
                        widget.user.phone +
                        '&name=' +
                        widget.user.name +
                        '&amount=' +
                        widget.val +
                        '&currentwallet=' +
                        widget.user.wallet,
                javascriptMode: JavascriptMode.unrestricted,
                onWebViewCreated: (WebViewController webViewController) {
                  _controller.complete(webViewController);
                },
              ),
            )
          ],
        ));
  }
}


