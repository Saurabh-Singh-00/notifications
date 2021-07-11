package dev.ssaurabh.notifications;

import android.app.NotificationChannel;
import android.app.NotificationManager;
import android.content.Context;
import android.graphics.Color;
import android.os.Build;

import androidx.annotation.NonNull;
import androidx.annotation.RequiresApi;
import androidx.core.app.NotificationCompat;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;

/**
 * NotificationsPlugin
 */
public class NotificationsPlugin implements FlutterPlugin, MethodCallHandler {
    private MethodChannel channel;
    private Context mContext;


    @Override
    public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
        mContext = flutterPluginBinding.getApplicationContext();
        channel = new MethodChannel(flutterPluginBinding.getBinaryMessenger(), "notifications");
        channel.setMethodCallHandler(this);
    }

    @RequiresApi(api = Build.VERSION_CODES.O)
    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
        if (call.method.equals("getPlatformVersion")) {
            result.success("Android " + android.os.Build.VERSION.RELEASE);
        } else if (call.method.equals("showNotification")) {
            try {
                showNotification(buildProxyNotification(call));
                result.success(true);
            } catch (Exception e) {
                result.error("FAILED", e.getMessage(), null);
            }
        } else {
            result.notImplemented();
        }
    }

    public ProxyNotification buildProxyNotification(MethodCall call) {
        final String title = call.argument("title");
        final String contentText = call.argument("contentText");
        ProxyNotification proxyNotification = new ProxyNotification();
        proxyNotification.setTitle(title);
        proxyNotification.setContentText(contentText);
        return proxyNotification;
    }

    @RequiresApi(api = Build.VERSION_CODES.O)
    public void showNotification(@NonNull ProxyNotification proxyNotification) {

        // The id of the channel.
        String id = "notifications_app_channel";
        String channelId = "flutterNotification";

        // The user-visible name of the channel.
        String name = "Notifications App";
        int importance = NotificationManager.IMPORTANCE_HIGH;

        NotificationChannel mChannel = new NotificationChannel(id, name, importance);

        mChannel.enableLights(true);
        mChannel.setLightColor(Color.GREEN);

        mChannel.enableVibration(true);
        mChannel.setVibrationPattern(new long[]{100, 200, 300, 400, 500, 400, 300, 200, 400});


        NotificationCompat.Builder notificationBuilder = new NotificationCompat.Builder(mContext, channelId)
                .setContentTitle(proxyNotification.getTitle())
                .setAutoCancel(true)
                .setContentText(proxyNotification.getContentText())
                .setVisibility(NotificationCompat.VISIBILITY_PUBLIC)
                .setChannelId(id)
                .setSmallIcon(R.drawable.ic_baseline_assignment_turned_in_24)
                .setColorized(true);

        NotificationManager notificationManager = (NotificationManager) mContext.getSystemService(Context.NOTIFICATION_SERVICE);
        notificationManager.createNotificationChannel(mChannel);
        notificationManager.notify(1, notificationBuilder.build());
    }

    @Override
    public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
        channel.setMethodCallHandler(null);
    }
}
