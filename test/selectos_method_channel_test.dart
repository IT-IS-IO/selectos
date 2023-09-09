import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:selectos/selectos_method_channel.dart';

void main() {
  MethodChannelSelectos platform = MethodChannelSelectos();
  const MethodChannel channel = MethodChannel('selectos');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    // ignore: deprecated_member_use
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    // ignore: deprecated_member_use
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await platform.getPlatformVersion(), '42');
  });
}
