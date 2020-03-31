package io.flutter.plugins;

import android.app.Activity;
import android.content.Intent;
import android.widget.Toast;

import exocr.lpr.DataCallBack;
import exocr.lpr.LPRManager;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.PluginRegistry;

public class FlutterPluginUseCarNum implements MethodChannel.MethodCallHandler {
    public static String CHANNEL = "com.chuangzhihui.scrm/plugin";
    static MethodChannel channel;
    private Activity activity;
    private String mCarNo;

    private FlutterPluginUseCarNum(Activity activity) {
        this.activity = activity;
    }

    public static void registerWith(PluginRegistry.Registrar registrar) {
        channel = new MethodChannel(registrar.messenger(), CHANNEL);
        FlutterPluginUseCarNum instance = new FlutterPluginUseCarNum(registrar.activity());
        //setMethodCallHandler在此通道上接收方法调用的回调
        channel.setMethodCallHandler(instance);
    }

    @Override
    public void onMethodCall(MethodCall methodCall, MethodChannel.Result result) {
        //通过MethodCall可以获取参数和方法名，然后再寻找对应的平台业务，本案例做了2个跳转的业务
        //接收来自flutter的指令oneAct
        switch (methodCall.method){
            case "usrScan":
                LPRManager.getInstance().recognize(new DataCallBack() {
                    @Override
                    public void onDetected(boolean b) {
                        if (b) {
                            mCarNo = LPRManager.getInstance().getResult();
                            //返回给flutter的参数
                            result.success(mCarNo);
                        } else {
//                        Toast.makeText(activity, "扫码失败", Toast.LENGTH_SHORT).show();
                        }
                    }

                    @Override
                    public void onCameraDenied() {

                    }
                }, activity);
                break;
            case "toast":
                Toast.makeText(activity, "调用原生测试", Toast.LENGTH_SHORT).show();
                break;
        }
    }

}
