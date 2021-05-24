package com.leaditteam.sport_news.services

import android.os.Handler
import android.util.Log
import com.leaditteam.sport_news.printl
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.EventChannel.EventSink
import io.flutter.plugin.common.PluginRegistry
import io.intheloup.streamschannel.StreamsChannel

public class NotificationPlugin : FlutterPlugin {

    private var eventSink: EventSink? = null
    private var handler = object : EventChannel.StreamHandler {
        override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
            eventSink = events!!
        }

        override fun onCancel(arguments: Any?) {
        }
    }

    fun sendData(data: String) {
        if (eventSink!=null) eventSink!!.success(data)
        else
            Handler().postDelayed({
                sendData(data)
            }, 4000)
    }

    fun registerWith(registrar: PluginRegistry.Registrar) {
        val channel = StreamsChannel(registrar.messenger(), "my_message_handler_ch").also { it->
            it.setStreamHandlerFactory {handler }
        }

    }
    override fun onAttachedToEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        val channel = StreamsChannel(binding.binaryMessenger, "my_message_handler_ch").also { it ->
            it.setStreamHandlerFactory {handler }
        }
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
//        eventSink!!.endOfStream()
    }

}
