package com.leaditteam.sport_news.gcm

import android.app.Notification
import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import androidx.core.app.NotificationManagerCompat


class NotificationPublisher : BroadcastReceiver() {
    override fun onReceive(context: Context, intent: Intent) {
        val notification: Notification? = intent.getParcelableExtra(NOTIFICATION)
//        val notificationManager = context.getSystemService(Context.NOTIFICATION_SERVICE) as NotificationManager
//        val id = intent.getIntExtra(NOTIFICATION_ID, 0)
        //notificationManager.notify(id, notification)
        if (notification != null) {
            with(NotificationManagerCompat.from(context)) {
                notify(SportUFirebaseMessagingService.NOTIFICATION_ID, notification)
            }
        }
    }

    companion object {
        var NOTIFICATION_ID = "notification-id"
        var NOTIFICATION = "notification"
    }
}
