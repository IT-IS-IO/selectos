#include "include/selectos/selectos_plugin_c_api.h"

#include <flutter/plugin_registrar_windows.h>

#include "selectos_plugin.h"

void SelectosPluginCApiRegisterWithRegistrar(
    FlutterDesktopPluginRegistrarRef registrar) {
  selectos::SelectosPlugin::RegisterWithRegistrar(
      flutter::PluginRegistrarManager::GetInstance()
          ->GetRegistrar<flutter::PluginRegistrarWindows>(registrar));
}
