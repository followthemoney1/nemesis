package com.leaditteam.sport_news.services


import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.content.SharedPreferences
import android.preference.PreferenceManager
import android.util.Log
import com.adjust.sdk.AdjustReferrerReceiver
import java.io.UnsupportedEncodingException
import java.lang.Exception
import java.net.URLDecoder
import java.util.*

//
//class FirstInstallReceiver : BroadcastReceiver() {
//    var TAG = this.javaClass.name
//    private val sources = arrayOf(
//            UTM_CAMPAIGN, UTM_SOURCE, UTM_MEDIUM, UTM_TERM, UTM_CONTENT, UTM_ANID
//    )
//    var sSources = UTM_CAMPAIGN + UTM_SOURCE + UTM_MEDIUM + UTM_TERM + UTM_CONTENT + UTM_ANID
//    override fun onReceive(context: Context, intent: Intent) {
//        Log.e(this.javaClass.name, "FirstInstallReciver onReceive")
//        val extras = intent.extras ?: return
//        try {
//            val referrerStringGoogle = extras.getString("referrer")
//            val referrerStringFacebook = extras.getString("fbclid")
//            if(referrerStringGoogle!=null){
//            if (referrerStringGoogle != null && !referrerStringGoogle.isEmpty()
//                    && !referrerStringGoogle.contains("utm_source=(not%20set)&utm_medium=(not%20set)")
//                    && !referrerStringGoogle.contains("utm_source=(not set)&utm_medium=(not set)")) {
////                pushFromGoogle(context)
//                Log.e(this.javaClass.name, "Put reffer link FirstInstallReceiver $referrerStringGoogle")
//            }
//            }else if(referrerStringFacebook!=null){
//                Log.e(this.javaClass.name, "Put reffer link FirstInstallReceiver $referrerStringFacebook")
//            }
//        }catch (e:Exception){
//
//        }
//
//    }
//
//    private fun pushFromGoogle(c: Context) {
//        val preferences: SharedPreferences = PreferenceManager.getDefaultSharedPreferences(c)
//        Log.e(this.javaClass.name, preferences.toString())
//        val editor = preferences.edit()
//        editor.putBoolean("first_install", true)
//        editor.apply()
//    }
//
//    @Throws(UnsupportedEncodingException::class)
//    fun getHashMapFromQuery(q: String?): Map<String, String> {
//        val query = URLDecoder.decode(q, "UTF-8")
//        val query_pairs: MutableMap<String, String> = LinkedHashMap()
//        val pairs = query.split("&".toRegex()).toTypedArray()
//        for (pair in pairs) {
//            val idx = pair.indexOf("=")
//            query_pairs[URLDecoder.decode(pair.substring(0, idx), "UTF-8")] = URLDecoder.decode(pair.substring(idx + 1), "UTF-8")
//        }
//        return query_pairs
//    }
//
//    @Throws(UnsupportedEncodingException::class)
//    fun getUrlFromQuery(q: String?): String {
//        return URLDecoder.decode(q, "UTF-8")
//    }
//
//    companion object {
//        const val UTM_CAMPAIGN = "utm_campaign"
//        const val UTM_SOURCE = "utm_source"
//        const val UTM_MEDIUM = "utm_medium"
//        const val UTM_TERM = "utm_term"
//        const val UTM_CONTENT = "utm_content"
//        const val UTM_ANID = "anid"
//    }
//}