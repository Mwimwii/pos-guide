package com.justtap;

import android.util.Log;

import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.ReactMethod;
import com.facebook.react.bridge.Callback;
import com.facebook.react.bridge.Arguments;
import com.facebook.react.bridge.WritableMap;
import com.facebook.react.modules.core.DeviceEventManagerModule;

import com.ctk.sdk.PosApiHelper;
import com.zcs.sdk.util.StringUtils;

public class NfcModule extends ReactContextBaseJavaModule {
    private PosApiHelper posApiHelper;
    private PICC_Thread piccThread;
    private boolean m_bThreadFinished;

NfcModule(ReactApplicationContext reactContext) {
    super(reactContext);
    posApiHelper = PosApiHelper.getInstance();
    piccThread = null;
    m_bThreadFinished = false;

}


@Override
public String getName(){
    return "NfcModule";
}

    private void sendEvent(String eventName, WritableMap params) {
        getReactApplicationContext()
                .getJSModule(DeviceEventManagerModule.RCTDeviceEventEmitter.class)
                .emit(eventName, params);
    }

@ReactMethod
public void stopThread() {
    m_bThreadFinished = true;
    piccThread = null;
}

@ReactMethod
private void readNfcCard() {
   if (null != piccThread && !piccThread.isThreadFinished()) {
       return;
   }
        piccThread = new PICC_Thread(0);
        piccThread.start();
    }

public class PICC_Thread extends Thread {
        int type;
        int ret;

        public PICC_Thread(int type) {
            this.type = type;
        }

        public boolean isThreadFinished() {
            return m_bThreadFinished;
        }
    public void run() {
        m_bThreadFinished = false;
        ret = posApiHelper.PiccMfulActivateCard();
        if (ret == 0) {
            // Wait for Card interaction
            byte[] ntagPwd = {(byte) 0xFF, (byte) 0xFF, (byte) 0xFF, (byte) 0xFF};
            byte[] Pack = new byte[2];
                ret = posApiHelper.PiccMfulPwdAuth(ntagPwd, Pack);
                if (ret == 0) {
                    int pageNum = 7;
                    byte[] dataBuf = new byte[16];
                    ret = posApiHelper.PiccMfulRead(pageNum, dataBuf);
                    if (ret == 0) {
                        final String dataStr = StringUtils.convertBytesToHex(dataBuf);
                        WritableMap eventData = Arguments.createMap();
                        Log.e("Found Data", dataStr);
                        eventData.putString("CardData", dataStr);
                        sendEvent("NFCCardData", eventData);
                        m_bThreadFinished = true;
                        return;
                    }
                }
        } else {
            m_bThreadFinished = true;
        }
    }
    }
}
