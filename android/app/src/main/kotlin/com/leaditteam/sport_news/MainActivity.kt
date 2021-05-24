package com.leaditteam.sport_news

import android.app.NotificationChannel
import android.app.NotificationManager
import android.content.Context
import android.content.Intent
import android.content.pm.PackageManager
import android.media.AudioAttributes
import android.media.RingtoneManager
import android.os.Build
import android.os.Bundle
import android.os.Handler
import android.os.PersistableBundle
import android.util.Base64
import android.util.Log
import android.widget.Toast
import com.leaditteam.sport_news.gcm.SportUFirebaseMessagingService
import com.leaditteam.sport_news.services.NotificationPlugin
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.embedding.engine.plugins.PluginRegistry
import io.flutter.plugins.GeneratedPluginRegistrant
import io.flutter.plugins.firebasemessaging.FlutterFirebaseMessagingService
import io.flutter.view.FlutterMain
import java.security.MessageDigest
import java.security.NoSuchAlgorithmException


class MainActivity : FlutterActivity() {
    val TAG: String = "MainActivityNewsApp"
    var notificationPlugin: NotificationPlugin? = null

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        createNotificationChannel()
        //issue: https://github.com/flutter/flutter/issues?q=is%3Aissue+Bad+state%3A+The+client+closed+with+pending+request+%22streamListen%22
        if (intent != null && intent?.extras != null)
        handleNotification(intent!!)
    }
    fun createNotificationChannel(){
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
                val name = getString(R.string.notification_ch_name)
                val descriptionText = getString(R.string.app_name)
//                val channel = NotificationChannel(SportUFirebaseMessagingService.CHANNEL_ID, name, NotificationManager.IMPORTANCE_HIGH).apply {
//                    description = descriptionText
//                }
//                val audioAttributes = AudioAttributes.Builder()
//                        .setContentType(AudioAttributes.CONTENT_TYPE_SONIFICATION)
//                        .setUsage(AudioAttributes.USAGE_NOTIFICATION_EVENT)
//                        .build()
//                channel.setSound(RingtoneManager.getDefaultUri(RingtoneManager.TYPE_NOTIFICATION),audioAttributes)
//                channel.enableVibration(true)
                val notificationManager = getSystemService(NotificationManager::class.java)
//                notificationManager.createNotificationChannel(channel)
                notificationManager?.createNotificationChannel(NotificationChannel(getString(R.string.default_notification_channel_id),
                        name, NotificationManager.IMPORTANCE_HIGH))
            }

    }
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
 //       flutterEngine.plugins.add(FirebaseMessagingPlugin())
//        flutterEngine.plugins.add(FlutterFirebaseCorePlugin())
//        flutterEngine.plugins.add(E2EPlugin())

        //MARK: notification plugin
        if (!flutterEngine.plugins.has(NotificationPlugin::class.java) || notificationPlugin == null) {
            flutterEngine.plugins.add(NotificationPlugin())
            notificationPlugin = flutterEngine.plugins.get(NotificationPlugin::class.java)!! as NotificationPlugin
        }
    }

    override fun onNewIntent(intent: Intent) {
        super.onNewIntent(intent)
        handleNotification(intent)
    }

   fun handleNotification(intent: Intent){
        if (intent?.extras == null || !(intent.extras!!.containsKey(SportUFirebaseMessagingService.PATH_ID()))) {
           // Toast.makeText(context,"Error to get news id" , Toast.LENGTH_LONG).show()
            return
        }

        if (notificationPlugin != null) {
            val b = intent.extras
            var id = b?.getString(SportUFirebaseMessagingService.PATH_ID()) as String
            notificationPlugin?.sendData(id!!)
        } else
            Handler().postDelayed({
                onNewIntent(intent)
            }, 4000)
    }

    fun printHashKey() {
        try {
            val info = this.packageManager.getPackageInfo(this.packageName, PackageManager.GET_SIGNATURES)
            for (signature in info.signatures) {
                val md = MessageDigest.getInstance("SHA")
                md.update(signature.toByteArray())
                val hashKey = String(Base64.encode(md.digest(), 0))
                Log.e(TAG, "hash native =" + hashKey);
            }
        } catch (e: NoSuchAlgorithmException) {
            e.printStackTrace()
        } catch (e: Exception) {
            e.printStackTrace()
        }
    }
}

fun printl(s: String) {
    try {
        Log.e("info ====   ", s)
    } catch (e: Exception) {
        e.printStackTrace()
    }
}


