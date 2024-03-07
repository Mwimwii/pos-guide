package com.justtap;

import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.ReactMethod;

import com.zcs.sdk.DriverManager;
import com.zcs.sdk.SdkResult;
import com.zcs.sdk.Sys;

import android.util.Log;

public class DriverModule extends ReactContextBaseJavaModule {

    private DriverManager mDriverManager;
    private Sys mSys;
    private String mStatus;
    DriverModule(ReactApplicationContext context) {
        super(context);
        setDriverInstance();
        initSdk();
        Log.d("Init", "Init Successful On Load");
    }

    private void setDriverInstance() {
        Log.d("Init", "Getting the driver instance");
        mDriverManager = DriverManager.getInstance();
        Log.d("Init", "Getting the base device");
        mSys = mDriverManager.getBaseSysDevice();
    }

    
    // Initialize the SDK
    private void initSdk() {
        Log.d("Init", "Fetching Status");
        int status = mSys.sdkInit();
        Log.d("Init", "Status fetched:" + String.valueOf(status));
        if(status != SdkResult.SDK_OK) {
            Log.d("Init", "SDK Not initialized");
            mSys.sysPowerOn();
            try {
                Thread.sleep(1000);
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
        } else {
            Log.d("Init", "SDK Already initialized");
        }
        status = mSys.sdkInit();
        if(status != SdkResult.SDK_OK) {
            Log.d("Init", "Failed to load");
        } else
        {
            Log.d("Init", "Init successful");
        }
    }
    @Override
    public String getName() {
        return "DriverModule";
    }

}
