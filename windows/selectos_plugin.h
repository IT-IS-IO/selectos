#ifndef FLUTTER_PLUGIN_SELECTOS_PLUGIN_H_
#define FLUTTER_PLUGIN_SELECTOS_PLUGIN_H_

#include <flutter/method_channel.h>
#include <flutter/plugin_registrar_windows.h>

#include <memory>

namespace selectos {

class SelectosPlugin : public flutter::Plugin {
 public:
  static void RegisterWithRegistrar(flutter::PluginRegistrarWindows *registrar);

  SelectosPlugin();

  virtual ~SelectosPlugin();

  // Disallow copy and assign.
  SelectosPlugin(const SelectosPlugin&) = delete;
  SelectosPlugin& operator=(const SelectosPlugin&) = delete;

 private:
  // Called when a method is called on this plugin's channel from Dart.
  void HandleMethodCall(
      const flutter::MethodCall<flutter::EncodableValue> &method_call,
      std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result);
};

}  // namespace selectos

#endif  // FLUTTER_PLUGIN_SELECTOS_PLUGIN_H_
