import 'dart:convert';
import 'package:flutter/services.dart';

class MyDeepLinkSDK {
  static final MyDeepLinkSDK _instance = MyDeepLinkSDK._();
  factory MyDeepLinkSDK() => _instance;
  MyDeepLinkSDK._();

  static const MethodChannel _channel = MethodChannel('my_deep_link_sdk');
  static const EventChannel _eventChannel =
      EventChannel('my_deep_link_sdk_events');
  static Stream<Map<String, String>>? _decodedLinkStream;

  /// **Encode parameters into Base64**
  String _encodeParameters(Map<String, String> params) {
    String jsonString = jsonEncode(params);
    return base64UrlEncode(utf8.encode(jsonString))
        .replaceAll('=', ''); // Remove padding
  }

  /// **Decode received parameters**
  Map<String, String>? _decodeParameters(String encodedString) {
    try {
      // Ensure proper Base64 padding
      int mod = encodedString.length % 4;
      if (mod > 0) {
        encodedString += '=' * (4 - mod);
      }

      String decodedJson = utf8.decode(base64Url.decode(encodedString));
      Map<String, dynamic> decodedMap = jsonDecode(decodedJson);
      return decodedMap.map((key, value) => MapEntry(key, value.toString()));
    } catch (e) {
      print("Decoding error: $e");
      return null; // Invalid data
    }
  }

  /// **Create a short deep link**
  String createShortLink(Map<String, String> params) {
    String encodedParams = _encodeParameters(params);
    return "https://kishanmoontechnolabs.github.io/deep_link_redirect/deeplink.html?id=$encodedParams";
  }

  /// **Fetch the initial deep link and decode it**
  Future<Map<String, String>> getInitialLink() async {
    try {
      String? link = await _channel.invokeMethod<String>('getInitialLink');
      if (link != null) {
        return extractParameters(link) ?? {};
      }
    } catch (e) {
      print("Error fetching initial link: $e");
    }
    return {};
  }

  /// **Extract and decode parameters from received deep link**
  Map<String, String>? extractParameters(String deepLink) {
    try {
      Uri uri = Uri.parse(deepLink);
      String? encodedParams = uri.queryParameters["id"];
      if (encodedParams != null) {
        return _decodeParameters(encodedParams);
      }
    } catch (e) {
      print("Error extracting parameters: $e");
    }
    return null;
  }

  /// **Listen for deep link changes and automatically decode**
  Stream<Map<String, String>> get decodedLinkStream {
    _decodedLinkStream ??= _eventChannel
        .receiveBroadcastStream()
        .map((event) => extractParameters(event.toString()) ?? {});
    return _decodedLinkStream!;
  }
}
