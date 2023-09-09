import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'selectos_platform_interface.dart';

class MethodChannelSelectos extends SelectosPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('selectos');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
