import 'dart:async';
import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';

class ConnectionSensitive extends StatefulWidget {
  final Widget child;

  ConnectionSensitive({@required this.child});

  @override
  _ConnectionSensitiveState createState() => _ConnectionSensitiveState();
}

class _ConnectionSensitiveState extends State<ConnectionSensitive> {
  bool _isConnected = true;
  Connectivity _connectivity;
  StreamSubscription<ConnectivityResult> _subscription;

  @override
  void initState() {
    super.initState();
    _connectivity = Connectivity();
    _subscription = _connectivity.onConnectivityChanged
        .listen((ConnectivityResult result) async {
      await distinguishConnection(result);
    });
  }

  // Future<void> checkConnection()

  Future<void> distinguishConnection(ConnectivityResult result) async {
    switch (result) {
      case ConnectivityResult.wifi:
        try {
          final checkedResult = await InternetAddress.lookup('example.com');
          if (checkedResult.isNotEmpty &&
              checkedResult[0].rawAddress.isNotEmpty) {
            setState(() => _isConnected = true);
          }
        } on SocketException catch (_) {
          setState(() => _isConnected = false);
        }
        break;
      case ConnectivityResult.mobile:
        setState(() => _isConnected = true);
        break;
      case ConnectivityResult.none:
        setState(() => _isConnected = false);
        break;
    }
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _isConnected
          ? widget.child
          : Scaffold(
              appBar: AppBar(
                title: Text('No Connection'),
                centerTitle: true,
                leading: Container(),
              ),
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CircularProgressIndicator(),
                    SizedBox(height: 20.0),
                    Text('Check your connection'),
                  ],
                ),
              ),
            ),
    );
  }
}
