import 'package:flutter/material.dart';
import 'package:my_deep_link_sdk/my_deep_link_sdk.dart';
import 'package:share_plus/share_plus.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _deepLinkData = "No deep link received yet.";
  final MyDeepLinkSDK _deepLinkSdk = MyDeepLinkSDK();

  @override
  void initState() {
    super.initState();
    _initDeepLinkListener();
  }

  /// **Initialize deep link listener**
  void _initDeepLinkListener() async {
    try {
      Map<String, String> initialParams = await _deepLinkSdk.getInitialLink();
      if (initialParams.isNotEmpty) {
        setState(() {
          _deepLinkData = "Initial Params: $initialParams";
        });
      }

      _deepLinkSdk.decodedLinkStream.listen((params) {
        if (params.isNotEmpty && params.toString() != _deepLinkData) {
          setState(() {
            _deepLinkData = "New Params: $params";
          });
        }
      });
    } catch (e) {
      setState(() {
        _deepLinkData = "Error retrieving deep link: $e";
      });
    }
  }

  /// **Generate and share deep link dynamically**
  void _shareDeepLink() {
    Map<String, String> params = {
      "a": "10",
      "b": "20", // Add more dynamic parameters here if needed
      "c": "flutter",
    };

    String shortLink = _deepLinkSdk.createShortLink(params);
    Share.share("Check this out: $shortLink");
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text("Deep Link Example")),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                _deepLinkData,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _shareDeepLink,
                child: const Text("Share Deep Link"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
