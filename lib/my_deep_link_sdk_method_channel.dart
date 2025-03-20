import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'my_deep_link_sdk_platform_interface.dart';

/// An implementation of [MyDeepLinkSdkPlatform] that uses method channels.
class MethodChannelMyDeepLinkSdk extends MyDeepLinkSdkPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('my_deep_link_sdk');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
