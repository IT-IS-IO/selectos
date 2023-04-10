import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'selectos_method_channel.dart';

abstract class SelectosPlatform extends PlatformInterface {
  /// Constructs a SelectosPlatform.
  SelectosPlatform() : super(token: _token);

  static final Object _token = Object();

  static SelectosPlatform _instance = MethodChannelSelectos();

  /// The default instance of [SelectosPlatform] to use.
  ///
  /// Defaults to [MethodChannelSelectos].
  static SelectosPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [SelectosPlatform] when
  /// they register themselves.
  static set instance(SelectosPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
