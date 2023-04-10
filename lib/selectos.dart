
import 'selectos_platform_interface.dart';

class Selectos {
  Future<String?> getPlatformVersion() {
    return SelectosPlatform.instance.getPlatformVersion();
  }
}
