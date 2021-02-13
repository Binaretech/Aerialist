package com.binaretech.aerialist

import android.content.ContentValues
import android.content.Intent
import android.os.Build
import android.os.Environment
import android.provider.MediaStore
import androidx.annotation.NonNull
import androidx.core.content.ContextCompat
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity() {
    private val CHANNEL = "com.binaretech.aerialist/storage"
    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler{
            call, result ->
            when(call.method) {
                "getStorageDirectories" -> getStorageDirectories(result)
                else -> result.notImplemented()
            }
        }
    }

    private fun getStorageDirectories(result: MethodChannel.Result) {
         return result.success(Environment.getExternalStorageDirectory().absolutePath)
    }
}
