import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_deep_link_sdk/my_deep_link_sdk_method_channel.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  MethodChannelMyDeepLinkSdk platform = MethodChannelMyDeepLinkSdk();
  const MethodChannel channel = MethodChannel('my_deep_link_sdk');

  setUp(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(
      channel,
      (MethodCall methodCall) async {
        return '42';
      },
    );
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, null);
  });

  test('getPlatformVersion', () async {
    expect(await platform.getPlatformVersion(), '42');
  });
}
