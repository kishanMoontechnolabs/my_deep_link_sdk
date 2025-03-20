import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'my_deep_link_sdk_method_channel.dart';

abstract class MyDeepLinkSdkPlatform extends PlatformInterface {
  /// Constructs a MyDeepLinkSdkPlatform.
  MyDeepLinkSdkPlatform() : super(token: _token);

  static final Object _token = Object();

  static MyDeepLinkSdkPlatform _instance = MethodChannelMyDeepLinkSdk();

  /// The default instance of [MyDeepLinkSdkPlatform] to use.
  ///
  /// Defaults to [MethodChannelMyDeepLinkSdk].
  static MyDeepLinkSdkPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [MyDeepLinkSdkPlatform] when
  /// they register themselves.
  static set instance(MyDeepLinkSdkPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
