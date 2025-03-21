import 'package:flutter_test/flutter_test.dart';
import 'package:my_deep_link_sdk/my_deep_link_sdk_platform_interface.dart';
import 'package:my_deep_link_sdk/my_deep_link_sdk_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockMyDeepLinkSdkPlatform
    with MockPlatformInterfaceMixin
    implements MyDeepLinkSdkPlatform {
  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final MyDeepLinkSdkPlatform initialPlatform = MyDeepLinkSdkPlatform.instance;

  test('$MethodChannelMyDeepLinkSdk is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelMyDeepLinkSdk>());
  });

  test('getPlatformVersion', () async {
    MockMyDeepLinkSdkPlatform fakePlatform = MockMyDeepLinkSdkPlatform();
    MyDeepLinkSdkPlatform.instance = fakePlatform;
  });
}
