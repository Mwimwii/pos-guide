package com.justtap;

import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.ReactMethod;
import com.facebook.react.bridge.Promise;

import android.content.Intent;
import android.text.Layout;
import android.util.Log;

import com.ctk.sdk.PosApiHelper;
import com.google.zxing.BarcodeFormat;

import java.util.Timer;

public class PrinterModule extends ReactContextBaseJavaModule {
    private Intent mPrintServiceIntent;
    private PosApiHelper posApiHelper;
    private int ret;
    private boolean m_bThreadFinished;


    private int RESULT_CODE;
    //private Pos pos;
    private Print_Thread printThread;

    PrinterModule(ReactApplicationContext reactContext) {
        super(reactContext);
        posApiHelper = PosApiHelper.getInstance();
        m_bThreadFinished = true;
        RESULT_CODE = 0;
        ret = -1;
        printThread = null;
    }

    @Override
    public String getName() {
        return "PrinterModule";
    }


    @ReactMethod
    public void printText(String amount, String merchant, String customer_no, String date, String url) {
        if (printThread != null && !printThread.isThreadFinished()) {
            return;
        }

        printThread = new Print_Thread(amount, merchant, customer_no, date, url);
        printThread.start();
        }


   public class Print_Thread extends Thread {
       private final String amount;
        private final String merchant;
       private final String customer_no;
       private final String title;
       private final String url;
       private final String date;

       public boolean isThreadFinished() {
           return m_bThreadFinished;
       }


       public Print_Thread(String amount, String merchant, String customer_no, String date, String url) {
           this.amount = amount;
           this.merchant = merchant;

           this.customer_no = customer_no;
           this.title = "Justtap Payments";
           this.url = url;
           this.date = date;

       }

       public void run() {
           synchronized (this) {
               m_bThreadFinished = false;
               try {
                   ret = posApiHelper.PrintInit();
               } catch (Exception e) {
                   e.printStackTrace();
               }

               ret = 2;

               posApiHelper.PrintSetGray(ret);

               ret = posApiHelper.PrintCheckStatus();
               if (ret == -1) {
                   RESULT_CODE = -1;
                   // SendMsg("Error, No Paper ");
                   m_bThreadFinished = true;
                   return;
               } else if (ret == -2) {
                   RESULT_CODE = -1;
                   // SendMsg("Error, Printer Too Hot ");
                   m_bThreadFinished = true;
                   return;
               } else if (ret == -3) {
                   RESULT_CODE = -1;
                   // SendMsg("Battery less :" + (BatteryV * 2));
                   m_bThreadFinished = true;
                   return;
               }
               else
               {
                   RESULT_CODE = 0;
               }

               posApiHelper.PrintSetFont((byte) 24, (byte) 24, (byte) 0x00);
               posApiHelper.PrintStr(this.title+ "www.justtap.us\n");
               posApiHelper.PrintStr("\n");
               posApiHelper.PrintStr("ISSUED BY: " + this.merchant +" \n");
               posApiHelper.PrintStr("id" +this.customer_no + "\n");
               posApiHelper.PrintStr("TXN. TYPE:SALE\n");
               posApiHelper.PrintStr("DATE:" +this.date+"\n");
               posApiHelper.PrintStr("- - - - - - - - - - - - - - - -\n");
               posApiHelper.PrintStr("Subtotal              K" +this.amount + "\n");
               posApiHelper.PrintStr("\n");
               posApiHelper.PrintStr("Total                 K" +this.amount + "\n");
               posApiHelper.PrintStr("\n");
               posApiHelper.PrintStr("\n");
               posApiHelper.PrintBarcode(this.url, 360, 120, "CODE_128");
               posApiHelper.PrintStr("     " + this.url + "\n\n");
               posApiHelper.PrintBarcode(this.url, 240, 240, "QR_CODE");
               posApiHelper.PrintStr("- - - - - - - - - - - - - - - -\n");
               posApiHelper.PrintStr("                                         ");
               posApiHelper.PrintStr("\n");
               posApiHelper.PrintStr("\n");
               posApiHelper.PrintStr("\n");

               final long starttime_long = System.currentTimeMillis();
               ret = posApiHelper.PrintStart();

               if (ret != 0) {
                   RESULT_CODE = -1;
                   Log.e("liuhao", "Lib_PrnStart fail, ret = " + ret);
                   if (ret == -1) {
                       // SendMsg("No Print Paper ");
                   } else if(ret == -2) {
                       // SendMsg("too hot ");
                   }else if(ret == -3) {
                       // SendMsg("low voltage ");
                   }else{
                       // SendMsg("Print fail ");
                   }
               } else {
                   RESULT_CODE = 0;
                   // SendMsg("Print Finish ");

                   final long endttime_long = System.currentTimeMillis();
                   final long totaltime_long = starttime_long - endttime_long;
                   // SendMsg("Print finish " );
               }
               m_bThreadFinished = true;
           }
       }


   }

   }
