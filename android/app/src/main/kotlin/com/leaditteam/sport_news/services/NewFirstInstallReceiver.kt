package com.leaditteam.sport_news.services

import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.os.RemoteException
import android.util.Log
import com.android.installreferrer.api.InstallReferrerClient
import com.android.installreferrer.api.InstallReferrerStateListener
import com.android.installreferrer.api.ReferrerDetails
//
//class NewFirstInstallReceiver : BroadcastReceiver(), InstallReferrerStateListener {
//    private var referrerClient: InstallReferrerClient? = null
//   override fun onReceive(context: Context?, intent: Intent) {
//       Log.d(LOG_TAG, "InstallReferrer on rec ${intent.extras}")
//        if (intent.getAction() != null) {
//            if (intent.getAction().equals(Intent.ACTION_PACKAGE_FIRST_LAUNCH)) {
//                referrerClient = InstallReferrerClient.newBuilder(context).build()
//                referrerClient?.startConnection(this)
//            }
//        }
//    }
//
//    override  fun onInstallReferrerSetupFinished(responseCode: Int) {
//        when (responseCode) {
//            InstallReferrerClient.InstallReferrerResponse.OK -> {
//                Log.d(LOG_TAG, "InstallReferrer Response.OK")
//                try {
//                    val response: ReferrerDetails = referrerClient!!.getInstallReferrer()
//                    Log.d(LOG_TAG, "InstallReferrer ok rec = $response")
//                    val referrer: String = response.getInstallReferrer()
//                    val clickTimestamp: Long = response.getReferrerClickTimestampSeconds()
//                    val installTimestamp: Long = response.getInstallBeginTimestampSeconds()
//                    Log.d(LOG_TAG, "InstallReferrer $referrer")
//                    referrerClient?.endConnection()
//                } catch (e: RemoteException) {
//                    Log.e(LOG_TAG, "" + e.printStackTrace())
//                }
//            }
//            InstallReferrerClient.InstallReferrerResponse.FEATURE_NOT_SUPPORTED -> Log.w(LOG_TAG, "InstallReferrer Response.FEATURE_NOT_SUPPORTED")
//            InstallReferrerClient.InstallReferrerResponse.SERVICE_UNAVAILABLE -> Log.w(LOG_TAG, "InstallReferrer Response.SERVICE_UNAVAILABLE")
//            InstallReferrerClient.InstallReferrerResponse.SERVICE_DISCONNECTED -> Log.w(LOG_TAG, "InstallReferrer Response.SERVICE_DISCONNECTED")
//            InstallReferrerClient.InstallReferrerResponse.DEVELOPER_ERROR -> Log.w(LOG_TAG, "InstallReferrer Response.DEVELOPER_ERROR")
//        }
//    }
//
//    override fun onInstallReferrerServiceDisconnected() {
//        Log.w(LOG_TAG, "InstallReferrer onInstallReferrerServiceDisconnected()")
//    }
//
//    companion object {
//        protected val LOG_TAG = this::class.java.simpleName
//    }
//}