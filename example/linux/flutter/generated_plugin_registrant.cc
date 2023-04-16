//
//  Generated file. Do not edit.
//

// clang-format off

#include "generated_plugin_registrant.h"

#include <selectos/selectos_plugin.h>

void fl_register_plugins(FlPluginRegistry* registry) {
  g_autoptr(FlPluginRegistrar) selectos_registrar =
      fl_plugin_registry_get_registrar_for_plugin(registry, "SelectosPlugin");
  selectos_plugin_register_with_registrar(selectos_registrar);
}
