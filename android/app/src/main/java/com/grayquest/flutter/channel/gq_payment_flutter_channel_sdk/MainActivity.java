package com.grayquest.flutter.channel.gq_payment_flutter_channel_sdk;

import android.os.Bundle;
import android.widget.Toast;

import com.grayquest.android.payment.sdk.GQPaymentSDK;
import com.grayquest.android.payment.sdk.GQPaymentSDKListener;

import org.json.JSONException;
import org.json.JSONObject;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugins.GeneratedPluginRegistrant;

public class MainActivity extends FlutterActivity implements GQPaymentSDKListener {

    private static final String CHANNEL = "GQPaymentSDK/channel";
    private MethodChannel.Result res;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        GeneratedPluginRegistrant.registerWith(new FlutterEngine(this));

        new MethodChannel(getFlutterEngine().getDartExecutor(), CHANNEL).setMethodCallHandler(
                new MethodChannel.MethodCallHandler() {
                    @Override
                    public void onMethodCall(MethodCall call, MethodChannel.Result result) {
                        res = result;

                        if (call.method.equals("initiateGQPayment")) {
                            res.success("GQ SDk is Open");

                            String received = call.arguments().toString();
                            Toast.makeText(MainActivity.this, received, Toast.LENGTH_SHORT).show();
                            GQPaymentSDK.initiate(MainActivity.this, config(), null);

                        }
                    }
                });
    }

    @Override
    public void onSuccess(JSONObject message) {
        res.success(message.toString());
        Toast.makeText(MainActivity.this, message.toString(), Toast.LENGTH_SHORT).show();
    }

    @Override
    public void onFailed(JSONObject message) {
        res.success(message.toString());
        Toast.makeText(MainActivity.this, message.toString(), Toast.LENGTH_SHORT).show();
    }


    @Override
    public void onCancel(JSONObject message) {
        res.success(message.toString());
        Toast.makeText(MainActivity.this, message.toString(), Toast.LENGTH_SHORT).show();
    }

    private JSONObject config(){
        JSONObject configJSON = new JSONObject();

        try {
            JSONObject auth = new JSONObject();
            auth.put("client_id", "GQ-a194690e-c1f8-483c-9d83-2a2fd737b021");
            auth.put("client_secret_key", "94c35f29-84fe-4a50-a752-f4328b9b850d");
            auth.put("gq_api_key", "f4877340-0771-46d7-bb60-a582afc610c7");

//            JSONObject customization = new JSONObject();
//            customization.put("fee_helper_text", "");
//            customization.put("logo_url", "");
//            customization.put("theme_color", "");

            JSONObject pp_config = new JSONObject();
            pp_config.put("slug", "edunext");

            JSONObject fee_headers = new JSONObject();
            fee_headers.put("student_emi_fee", 100000);
            fee_headers.put("student_fee", 25000);
            fee_headers.put("payable_fee_1", 25000);
            fee_headers.put("payable_fee_2", 25000);
            fee_headers.put("payable_fee_3", 25000);
            fee_headers.put("payable_fee_4", 25000);
            fee_headers.put("payable_fee_5", 0);
            fee_headers.put("payable_fee_6", 0);
            fee_headers.put("payable_fee_7", 0);
            fee_headers.put("payable_fee_8", 0);
            fee_headers.put("payable_fee_9", 0);
            fee_headers.put("payable_fee_10", 0);
            fee_headers.put("payable_fee_11", 0);
            fee_headers.put("payable_fee_12", 0);

            configJSON.put("auth", auth);
            configJSON.put("student_id", "demo_123456");
            configJSON.put("env", "test");
            configJSON.put("customer_number", "8425960119");
//            configJSON.put("customization", customization);
            configJSON.put("pp_config", pp_config);
            configJSON.put("fee_headers", fee_headers);
        } catch (JSONException e) {
            e.printStackTrace();
        }

        return configJSON;
    }
}
