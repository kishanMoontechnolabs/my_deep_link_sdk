package com.example.my_deep_link_sdk

import android.content.Intent
import androidx.annotation.NonNull
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.PluginRegistry.NewIntentListener

class MyDeepLinkSdkPlugin : FlutterPlugin, MethodChannel.MethodCallHandler, EventChannel.StreamHandler, ActivityAware, NewIntentListener {

  private lateinit var channel: MethodChannel
  private lateinit var eventChannel: EventChannel
  private var eventSink: EventChannel.EventSink? = null
  private var activityBinding: ActivityPluginBinding? = null

  private var initialLink: String? = null
  private var latestLink: String? = null
  private var initialLinkSent = false

  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "my_deep_link_sdk")
    channel.setMethodCallHandler(this)

    eventChannel = EventChannel(flutterPluginBinding.binaryMessenger, "my_deep_link_sdk_events")
    eventChannel.setStreamHandler(this)
  }

  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
    eventChannel.setStreamHandler(null)
  }

  override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
    when (call.method) {
      "getInitialLink" -> result.success(initialLink)
      "getLatestLink" -> result.success(latestLink)
      else -> result.notImplemented()
    }
  }

  override fun onAttachedToActivity(binding: ActivityPluginBinding) {
    activityBinding = binding
    binding.addOnNewIntentListener(this)

    val intent = binding.activity.intent
    handleIntent(intent)
  }

  override fun onNewIntent(intent: Intent): Boolean {
    return handleIntent(intent)
  }

  private fun handleIntent(intent: Intent?): Boolean {
    if (intent?.data == null) return false

    val dataString = intent.dataString
    if (dataString == null) return false

    if (initialLink == null) {
      initialLink = dataString
    }
    latestLink = dataString

    eventSink?.success(dataString)
    return true
  }

  override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
    eventSink = events
    if (!initialLinkSent && initialLink != null) {
      initialLinkSent = true
      eventSink?.success(initialLink)
    }
  }

  override fun onCancel(arguments: Any?) {
    eventSink = null
  }

  override fun onDetachedFromActivity() {
    activityBinding?.removeOnNewIntentListener(this)
    activityBinding = null
  }

  override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
    activityBinding = binding
    binding.addOnNewIntentListener(this)
  }

  override fun onDetachedFromActivityForConfigChanges() {
    onDetachedFromActivity()
  }
}