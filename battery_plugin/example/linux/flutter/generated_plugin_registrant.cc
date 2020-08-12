//
//  Generated file. Do not edit.
//

#include "generated_plugin_registrant.h"

#include <batter_plugin_linux/batter_plugin_linux_plugin.h>

void fl_register_plugins(FlPluginRegistry* registry) {
  g_autoptr(FlPluginRegistrar) batter_plugin_linux_registrar =
      fl_plugin_registry_get_registrar_for_plugin(registry, "BatterPluginLinuxPlugin");
  batter_plugin_linux_plugin_register_with_registrar(batter_plugin_linux_registrar);
}
