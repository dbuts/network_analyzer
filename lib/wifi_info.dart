import 'package:flutter/material.dart';
import 'package:wifi_info_plugin/wifi_info_plugin.dart';
import 'package:flutter/services.dart';
import 'dart:async';

class WifiInfo extends StatefulWidget {
  @override
  _WifiInfoState createState() => _WifiInfoState();
}

class _WifiInfoState extends State<WifiInfo> {
  WifiInfoWrapper _wifiObject;

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    WifiInfoWrapper wifiObject;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      wifiObject = await WifiInfoPlugin.wifiDetails;
    } on PlatformException {}
    if (!mounted) return;

    setState(() {
      _wifiObject = wifiObject;
    });
  }

  void updateWifiObject() async {
    _wifiObject = await WifiInfoPlugin.wifiDetails;
  }

  @override
  Widget build(BuildContext context) {
    updateWifiObject();
    String ipAddress = _wifiObject != null
        ? _wifiObject.ipAddress.toString()
        : "IP not found.";
    String ssid =
        _wifiObject != null ? _wifiObject.ssid.toString() : "SSID not found.";
    String sigStrength = _wifiObject != null
        ? _wifiObject.signalStrength.toString()
        : "Signal Strength not found.";
    String freq = _wifiObject != null
        ? _wifiObject.frequency.toString()
        : "Frequency not found.";
    return Column(
      children: <Widget>[
        Text('IP: ' + ipAddress),
        Text('SSID: ' + ssid),
        Text('Signal Strength: ' + sigStrength),
        Text('Frequency: ' + freq),
        ElevatedButton(
          onPressed: () {
            updateWifiObject();
            setState(() {});
          },
          child: Text("Update"),
        )
      ],
    );
  }
}
