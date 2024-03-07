package com.justtap;

import android.util.Log;

import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.ReactMethod;
import com.facebook.react.bridge.Callback;
import com.facebook.react.bridge.Arguments;
import com.facebook.react.bridge.WritableMap;
import com.facebook.react.modules.core.DeviceEventManagerModule;

import com.zcs.sdk.DriverManager;
import com.zcs.sdk.SdkData;
import com.zcs.sdk.SdkResult;
import com.zcs.sdk.card.CardInfoEntity;
import com.zcs.sdk.card.CardReaderManager;
import com.zcs.sdk.card.CardReaderTypeEnum;
import com.zcs.sdk.card.CardSlotNoEnum;
import com.zcs.sdk.card.ICCard;
import com.zcs.sdk.card.MagCard;
import com.zcs.sdk.card.RfCard;
import com.zcs.sdk.listener.OnSearchCardListener;
import com.zcs.sdk.util.StringUtils;

public class CardModule extends ReactContextBaseJavaModule {
    private DriverManager mDriverManager;
    private CardReaderManager mCardReadManager;
    private OnSearchCardListener mRfCardSearchCardListener;

    private RfCard mRfCard;
    private static final String KEY_CONTACTLESS_CARD = "contactless_card_key";
    private static final int READ_TIMEOUT = 60 * 1000;

    CardModule(ReactApplicationContext reactContext) {
        super(reactContext);
        mDriverManager = DriverManager.getInstance();
        mCardReadManager = mDriverManager.getCardReadManager();
        mRfCardSearchCardListener = new OnSearchCardListener() {
            @Override
            public void onCardInfo(CardInfoEntity cardInfoEntity) {
                    byte rfCardType = cardInfoEntity.getRfCardType();
                    readRfCard(rfCardType);
            }

            @Override
            public void onError(int i) {
                Log.d("CardModule.java", "Card Error");
            }

            @Override
            public void onNoCard(CardReaderTypeEnum cardReaderTypeEnum, boolean b) {
                Log.d("CardModule.java", "No Card");
            }
        };
    }

    @Override
    public String getName() {
        return "CardModule";
    }
    private void sendEvent(String eventName, WritableMap eventData) {
        ReactApplicationContext reactContext = getReactApplicationContext();
        reactContext.getJSModule(DeviceEventManagerModule.RCTDeviceEventEmitter.class)
                .emit(eventName, eventData);
    }

    @ReactMethod
    public void searchRfCard() {
        mCardReadManager.cancelSearchCard();
        mCardReadManager.searchCard(CardReaderTypeEnum.RF_CARD, READ_TIMEOUT, mRfCardSearchCardListener);
    }

    public static final byte[] APDU_SEND_RF = {0x00, (byte) 0xA4, 0x04, 0x00, 0x0E, 0x32, 0x50, 0x41, 0x59, 0x2E, 0x53, 0x59, 0x53, 0x2E, 0x44, 0x44, 0x46, 0x30, 0x31, 0x00};
    public static final byte[] APDU_SEND_FELICA = {0x10, 0x06, 0x01, 0x2E, 0x45, 0x76, (byte) 0xBA, (byte) 0xC5, 0x45, 0x2B, 0x01, 0x09, 0x00, 0x01, (byte) 0x80, 0x00};

    private void readRfCard(final byte rfCardType) {
        mRfCard = mCardReadManager.getRFCard();
        int result = mRfCard.rfReset();
        if (result == SdkResult.SDK_OK) {
            byte[] apduSend;
            if (rfCardType == SdkData.RF_TYPE_FELICA) { // felica card
                apduSend = APDU_SEND_FELICA;
            } else {
                apduSend = APDU_SEND_RF;
            }
            int[] recvLen = new int[1];
            byte[] recvData = new byte[300];
            result = mRfCard.rfExchangeAPDU(apduSend, recvData, recvLen);
            if (result == SdkResult.SDK_OK) {
                final String apduRecv = StringUtils.convertBytesToHex(recvData).substring(0, recvLen[0] * 2);
                    Log.d(rfCardTypeToString(rfCardType), apduRecv);
                WritableMap eventData = Arguments.createMap();
                eventData.putString("data", apduRecv);
                sendEvent("CardRead", eventData);
            } else {
                Log.d("CardModule.java", "Card Info Received, but error found");
                WritableMap eventData = Arguments.createMap();
                eventData.putString("error", "Wrong Card Type");
                sendEvent("CardRead", eventData);
            }

        } else {
            Log.d("CardModule.java", "Card Info Received, but error found");
            WritableMap eventData = Arguments.createMap();
            eventData.putString("error", "Wrong Card Type");
            sendEvent("CardRead", eventData);
        }

        mRfCard.rfCardPowerDown();
    }
    private String rfCardTypeToString(byte rfCardType) {
        String type = "";
        switch (rfCardType) {
            case SdkData.RF_TYPE_A:
                type = "RF_TYPE_A";
                break;
            case SdkData.RF_TYPE_B:
                type = "RF_TYPE_B";
                break;
            case SdkData.RF_TYPE_MEMORY_A:
                type = "RF_TYPE_MEMORY_A";
                break;
            case SdkData.RF_TYPE_FELICA:
                type = "RF_TYPE_FELICA";
                break;
            case SdkData.RF_TYPE_MEMORY_B:
                type = "RF_TYPE_MEMORY_B";
                break;
        }
        return type;
    }

}
