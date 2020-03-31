package com.chuangzhihui.scrm

import android.os.Bundle

import io.flutter.app.FlutterActivity
import io.flutter.plugin.common.PluginRegistry
import io.flutter.plugins.FlutterPluginUseCarNum
import io.flutter.plugins.GeneratedPluginRegistrant

class MainActivity: FlutterActivity() {
  override fun onCreate(savedInstanceState: Bundle?) {
    super.onCreate(savedInstanceState)
    GeneratedPluginRegistrant.registerWith(this)
    registerCustomPlugin(this)
  }

  private fun registerCustomPlugin(registrar: PluginRegistry) {

    // 注册调用原生识别车牌号
    FlutterPluginUseCarNum.registerWith(registrar.registrarFor(FlutterPluginUseCarNum.CHANNEL))

  }

}
