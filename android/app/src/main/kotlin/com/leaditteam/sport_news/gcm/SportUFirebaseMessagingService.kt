package com.leaditteam.sport_news.gcm

import android.app.*
import android.content.Context
import android.content.Intent
import android.media.AudioAttributes
import android.media.RingtoneManager
import android.os.Build
import android.os.Parcel
import android.os.Parcelable
import androidx.core.app.NotificationCompat
import androidx.core.app.NotificationManagerCompat
import com.google.firebase.messaging.FirebaseMessaging
import com.google.firebase.messaging.FirebaseMessagingService
import com.google.firebase.messaging.RemoteMessage
import com.leaditteam.sport_news.MainActivity
import com.leaditteam.sport_news.R
import com.leaditteam.sport_news.printl
import io.flutter.plugins.firebasemessaging.FlutterFirebaseMessagingService

import java.text.SimpleDateFormat
import java.util.*


class SportUFirebaseMessagingService : FirebaseMessagingService() {
    var pendingIntentID = Random().nextInt(30)

    companion object {
//        const val CHANNEL_ID = "channel_notification_sportu"
        const val EXTRA_ID = "notification_object_id"
        const val EXTRA_ACTION = "notification_path"
        const val NOTIFICATION_ID = 8842
        fun PATH_ID():String = "path_id"
    }

    override fun onMessageReceived(remoteMessage: RemoteMessage) {
        printl("From: " + remoteMessage.data.toString())
        createNotificationChannel()

        var title:String = ""
        var body:String = ""
        var id:String? = null
        var showDelayed = false
//        var calendar: Calendar = Calendar.getInstance()
        title = remoteMessage.notification?.title!!
        body = remoteMessage.notification?.body!!
        try {
//            title = remoteMessage.data["title"].toString()//remoteMessage.notification?.title
//            body = remoteMessage.data["body"].toString()//remoteMessage.notification?.body
            id = remoteMessage.data["id"]
//            val time = remoteMessage.data["time"]
//            printl("data ${id.toString()}")
//            printl("time ${time.toString()}")

//            if (!time.equals("now")) {
//                showDelayed = true
//                calendar = parseTime(time!!.split(":")[0], time!!.split(":")[1])
//            }

        } catch (exc: Exception) {
            exc.printStackTrace()
        }

        val intent = Intent(this, MainActivity::class.java)
        intent.putExtra(PATH_ID(),id)
        intent.addFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP)
        val openActionIntent = PendingIntent.getActivity(this, 4444, intent, PendingIntent.FLAG_ONE_SHOT)
        var builder = NotificationCompat.Builder(this, getString(R.string.default_notification_channel_id))
                .setDefaults(Notification.DEFAULT_SOUND)
                .setSmallIcon(R.mipmap.ic_launcher)
                .setContentTitle(title)
                .setContentText(body)
                .setPriority(NotificationCompat.PRIORITY_HIGH)
                //.setWhen(calendar.timeInMillis)
                .setAutoCancel(true)
                .setSound(RingtoneManager.getDefaultUri(RingtoneManager.TYPE_NOTIFICATION))
                .setContentIntent(openActionIntent)

//        val delay = abs(calendar.timeInMillis - System.currentTimeMillis())
//        val time = String.format("%02d min, %02d sec",
//                java.util.concurrent.TimeUnit.MILLISECONDS.toMinutes(delay),
//                java.util.concurrent.TimeUnit.MILLISECONDS.toSeconds(delay) -
//                        java.util.concurrent.TimeUnit.MINUTES.toSeconds(java.util.concurrent.TimeUnit.MILLISECONDS.toMinutes(delay))
//        )
//        printl("delay to set in time = ${time}")
//        printl("delay to set in mill = ${delay}")

//        if (showDelayed) {
//            scheduleNotification(builder.build(),calendar.timeInMillis)
//        } else {
            showNotification(builder)
     //   }
    }

    private fun scheduleNotification(notification: android.app.Notification, delay: Long) {
        pendingIntentID += 1
        val notificationIntent = Intent(this, NotificationPublisher::class.java)
        notificationIntent.putExtra(NotificationPublisher.NOTIFICATION_ID, delay.toInt())
        notificationIntent.putExtra(NotificationPublisher.NOTIFICATION, notification)
        val pendingIntent = PendingIntent.getBroadcast(this,pendingIntentID, notificationIntent, PendingIntent.FLAG_ONE_SHOT)
        val futureInMillis =  delay
        val alarmManager = getSystemService(Context.ALARM_SERVICE) as AlarmManager
//        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
//            alarmManager.setExactAndAllowWhileIdle(AlarmManager.RTC_WAKEUP, futureInMillis,pendingIntent)
//        }else {
//            alarmManager.setExact(AlarmManager.RTC_WAKEUP, futureInMillis, pendingIntent)
//        }
        alarmManager[AlarmManager.RTC_WAKEUP, futureInMillis] = pendingIntent //ELAPSED_REALTIME_WAKEUP
    }

    fun showNotification(builder: NotificationCompat.Builder) {
        with(NotificationManagerCompat.from(this)) {
            notify(NOTIFICATION_ID, builder.build())
        }
    }

    fun parseTime(hours: String, minutes: String): Calendar {
        val cal = Calendar.getInstance()
        val formatter = SimpleDateFormat("dd-MM-yyyy HH:mm:ss")
        printl(formatter.format(cal.getTime()))
        printl(cal.get(Calendar.HOUR_OF_DAY).toString())
        if (cal.get(Calendar.HOUR_OF_DAY)>hours.toInt()){
            cal.add(Calendar.DAY_OF_MONTH, 1)
        }
        cal.set(Calendar.HOUR_OF_DAY, hours.toInt())
        cal.set(Calendar.MINUTE, minutes.toInt())
        printl(formatter.format(cal.getTime()))
        return cal
    }

    private fun createNotificationChannel() {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            val name = getString(R.string.notification_ch_name)
            val descriptionText = getString(R.string.app_name)
            val importance = NotificationManager.IMPORTANCE_HIGH
            val channel = NotificationChannel(getString(R.string.default_notification_channel_id), name, importance).apply {
                description = descriptionText
            }
            val audioAttributes = AudioAttributes.Builder()
                    .setContentType(AudioAttributes.CONTENT_TYPE_SONIFICATION)
                    .setUsage(AudioAttributes.USAGE_NOTIFICATION)
                    .build()
            channel.setSound(RingtoneManager.getDefaultUri(RingtoneManager.TYPE_NOTIFICATION),audioAttributes)
            channel.enableVibration(true)
            val notificationManager: NotificationManager =
                    getSystemService(Context.NOTIFICATION_SERVICE) as NotificationManager
            notificationManager.createNotificationChannel(channel)
        }
    }

    override fun onNewToken(p0: String) {
        super.onNewToken(p0)
        printl("on new token fcm =  $p0")
    }
}
