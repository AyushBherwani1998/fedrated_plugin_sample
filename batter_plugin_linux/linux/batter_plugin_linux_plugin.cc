#include "include/batter_plugin_linux/batter_plugin_linux_plugin.h"

#include <flutter_linux/flutter_linux.h>
#include <gtk/gtk.h>
#include <sys/utsname.h>
#include <bits/stdc++.h>
using namespace std;

#define BATTER_PLUGIN_LINUX_PLUGIN(obj) \
  (G_TYPE_CHECK_INSTANCE_CAST((obj), batter_plugin_linux_plugin_get_type(), \
                              BatterPluginLinuxPlugin))

struct _BatterPluginLinuxPlugin {
  GObject parent_instance;
};

G_DEFINE_TYPE(BatterPluginLinuxPlugin, batter_plugin_linux_plugin, g_object_get_type())

// Called when a method call is received from Flutter.
static void batter_plugin_linux_plugin_handle_method_call(
    BatterPluginLinuxPlugin* self,
    FlMethodCall* method_call) {
  g_autoptr(FlMethodResponse) response = nullptr;

  const gchar* method = fl_method_call_get_name(method_call);

  if (strcmp(method, "getBatteryLevel") == 0) {
    string data;
    array<char, 128> buffer;
    std::unique_ptr<FILE, decltype(&pclose)> pipe(popen("cat /sys/class/power_supply/BAT0/capacity", "r"), pclose);

    while (fgets(buffer.data(), buffer.size(), pipe.get()) != nullptr) {
        data += buffer.data();
    }

    double value = atof(data.c_str());

    if (value == 0.0) {
     // Throw error
    } else {
     g_autoptr(FlValue) result = fl_value_new_float(value);
     response = FL_METHOD_RESPONSE(fl_method_success_response_new(result));
    }
  } else {
    response = FL_METHOD_RESPONSE(fl_method_not_implemented_response_new());
  }

  fl_method_call_respond(method_call, response, nullptr);
}

static void batter_plugin_linux_plugin_dispose(GObject* object) {
  G_OBJECT_CLASS(batter_plugin_linux_plugin_parent_class)->dispose(object);
}

static void batter_plugin_linux_plugin_class_init(BatterPluginLinuxPluginClass* klass) {
  G_OBJECT_CLASS(klass)->dispose = batter_plugin_linux_plugin_dispose;
}

static void batter_plugin_linux_plugin_init(BatterPluginLinuxPlugin* self) {}

static void method_call_cb(FlMethodChannel* channel, FlMethodCall* method_call,
                           gpointer user_data) {
  BatterPluginLinuxPlugin* plugin = BATTER_PLUGIN_LINUX_PLUGIN(user_data);
  batter_plugin_linux_plugin_handle_method_call(plugin, method_call);
}

void batter_plugin_linux_plugin_register_with_registrar(FlPluginRegistrar* registrar) {
  BatterPluginLinuxPlugin* plugin = BATTER_PLUGIN_LINUX_PLUGIN(
      g_object_new(batter_plugin_linux_plugin_get_type(), nullptr));

  g_autoptr(FlStandardMethodCodec) codec = fl_standard_method_codec_new();
  g_autoptr(FlMethodChannel) channel =
      fl_method_channel_new(fl_plugin_registrar_get_messenger(registrar),
                            "battery",
                            FL_METHOD_CODEC(codec));
  fl_method_channel_set_method_call_handler(channel, method_call_cb,
                                            g_object_ref(plugin),
                                            g_object_unref);

  g_object_unref(plugin);
}
