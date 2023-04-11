import 'package:flutter_test/flutter_test.dart';
import 'package:selectos/selectos.dart';
import 'package:selectos/selectos_platform_interface.dart';
import 'package:selectos/selectos_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockSelectosPlatform
    with MockPlatformInterfaceMixin
    implements SelectosPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final SelectosPlatform initialPlatform = SelectosPlatform.instance;

  test('$MethodChannelSelectos is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelSelectos>());
  });

  test('getPlatformVersion', () async {
    Selectos selectosPlugin = Selectos();
    MockSelectosPlatform fakePlatform = MockSelectosPlatform();
    SelectosPlatform.instance = fakePlatform;

    expect(await selectosPlugin.getPlatformVersion(), '42');
  });
}
