// ICiontekPosService.aidl
package com.ciontek.ciontekposservice;
import android.graphics.Bitmap;
// Declare any non-default types here with import statements

interface ICiontekPosService {
/*--------------------------------Android OS Interface ----------------------------------------*/
    //1.0.1
    int installRomPackage(String romFilePath);

    //1.0.2
    String getOSVersion();

    //1.0.3
    String getDeviceId();

/*--------------------------------Peripheral Interface ----------------------------------------*/
    //2.0.1
    int Lib_LogSwitch(int LogSwitch);

    //2.0.2
    int Lib_GetRand(out byte[] rnd);

    //2.0.3
    int Lib_Update_32550();

    //2.0.4
    int Lib_GetVersion(out byte[] buf);

    //2.0.5
    int Lib_ReadSN(out byte[] SN);

    //2.0.6
    int Lib_WriteSN(in byte[] SN);

    //2.0.7
    int Lib_ReadChipID(out byte[] buf, int len);

/*--------------------------------IC card ---------------------------------------------------*/
    //3.0.1
    int Lib_IccOpen(byte slot, byte vccMode, out byte[] atr);

    //3.0.2
    int Lib_IccClose(byte slot);

    //3.0.3
    int Lib_IccCommand(byte slot, in byte[] apduSend, out byte[]  apduResp);

    //3.0.4
    int Lib_IccCheck(byte slot);

    //3.0.5
    int SC_ApduCmd(byte bslot, in byte[] pbInApdu, int usInApduLen, out byte[]pbOut,out byte[] pbOutLen);


/*--------------------------------    printer      --------------------------------------------*/
    //7.0.1
    int Lib_PrnInit();

    //7.0.2
    int Lib_PrnSetSpace(byte x, byte y);

    //7.0.3
    int Lib_PrnSetFont(byte AsciiFontHeight, byte ExtendFontHeight, byte Zoom);

    //7.0.4
    int Lib_PrnGetFont(in byte[] AsciiFontHeight, in byte[] ExtendFontHeight, in byte[] Zoom);

    //7.0.5
    int Lib_PrnStep(int pixel);

    //7.0.6
    int Lib_PrnSetVoltage(int voltage);

    //7.0.7
    int Lib_PrnIsCharge(int ischarge);

    //7.0.8
    int Lib_PrnStr(String str);

    //7.0.9
    int Lib_PrnBmp(in Bitmap bitmap);

    //7.0.10
    int Lib_PrnBarcode(String contents, int desiredWidth, int desiredHeight,String barcodeType);

    //7.0.11
    int Lib_PrintCutQrCode(String contents, int desiredWidth, int desiredHeight, String barcodeType);

    //7.0.12
    int Lib_PrintCutQrCodeStr(String qrContent, String printTxt, int distance, int desiredWidth, int desiredHeight, String barcodeType);

    //0140
    //int Lib_PrnCutPicture(in byte[] logo);

    //0141
    //int Lib_PrnCutPictureStr(in byte[] jlogo,in byte[] jString,int LinDis);

    //0142
    int Lib_PrnLogo(in byte[] logo);

    //7.0.13
    int Lib_SetLinPixelDis(char LinDistance);

    //7.0.14
    int Lib_PrnStart();

    //0145
    //int Lib_PrnConventional(int jnlevel);

    //0146
    //int Lib_PrnContinuous(int jnlevel);

    //0147
    //int Lib_PrnClose();

    //0148
    //int Lib_CTNPrnStart();

    //7.0.15
    int Lib_PrnSetLeftIndent(int x);

    //7.0.16
    int Lib_PrnSetAlign(int X);

    //7.0.17
    int Lib_PrnSetCharSpace(int X);

    //7.0.18
    int Lib_PrnSetLineSpace(int x);

    //7.0.19
    int Lib_PrnSetLeftSpace(int x);

    //7.0.20
    int Lib_PrnSetGray(int nLevel);

    //7.0.21
    int Lib_PrnSetSpeed(int iSpeed);

    //7.0.22
    int Lib_PrnCheckStatus( );

    //7.0.23
    int Lib_PrnFeedPaper(int step);

    //7.0.24
    int Lib_PrnSetMode(int mode);

    //7.0.25
    int Lib_PrnSetUnderline(int x);

    //7.0.26
    int Lib_PrnSetReverse(int x);

    //7.0.27
    int Lib_PrnSetBold(int x);

 /*---------------------------  APP White List  -----------------------------------------------*/

    //5.0.1
    boolean enableAppInstallWhiteList();

    //5.0.2
    boolean disableAppInstallWhiteList();

    //5.0.3
    boolean addAppToInstallWhiteList(String pkgName);

    //5.0.4
    boolean delAppFromInstallWhiteList(String pkgName);

    //5.0.5
    List<String> getAppInstallWhiteList();

    //5.1.1
    boolean enableAppUninstallBlackList();

    //5.1.2
    boolean disableAppUninstallBlackList();

    //5.1.3
    boolean addAppToUninstallBlackList(String pkgName);

    //5.1.4
    boolean delAppFromUninstallBlackList(String pkgName);

    //5.1.5
    List<String> getAppUninstallBlackList();

/*---------------------------  Fiscal APIs -------------------------------------------------------*/
    //6.0.1
    int fiscalOpen(int baudrate,int size, int stop, char parity, char cflow);

    //6.0.2
    int fiscalClose();

    //6.0.3
    int fiscalWrite(in byte[] data);

    //6.0.4
     int fiscalRead(out byte[] buffer,int bufLen,int timeout);

/*---------------------------  Beep APIs -------------------------------------------------------*/
    //7.0.1
    int Lib_Beep();

/*---------------------------  MagneticWork APIs -------------------------------------------------------*/
    //8.0.2
    int Lib_McrOpen();
    //8.0.3
    int Lib_McrClose();
    //8.0.4
    int Lib_McrReset();
    //8.0.5
    int Lib_McrCheck();
    //8.0.6
    int Lib_McrRead(byte keyNo, byte mode,out byte[] track1, out byte[] track2, out byte[] track3);

/*---------------------------  Contactless cards L1 APIs -------------------------------------------------------*/
    //9.0.1
    int Lib_PiccOpen();
    
    //9.0.2
    int Lib_PiccClose();
    
    //9.0.3
    int Lib_PiccCheck(byte mode, out byte[] cardType,out byte[] serialNo);
    
    //9.0.4
    int Lib_PiccPolling(out byte[] CardType,out byte[] UID,out byte[] ucUIDLen,out byte[] ATS,out byte[] ucATSLen,out byte[] SAK);
    
    //9.0.5
    int Lib_PiccCommand(in byte[] apduSend,out byte[] apduResp);
    
    //9.0.6
    int Picc_ApduCmd(in byte[] jpucInput,int usInputLen, out byte[] jpucOutput,out byte[] jpusOutputLen);


/*---------------------------  Contactless cards L2 APIs -------------------------------------------------------*/

     //9.0.7
     int Lib_Nfc(out byte[] NfcData_Len,out  byte[] Technology, out byte[]  UID, out byte[] NDEF_message);

     //9.0.8
     int Lib_PiccRemove();

     //9.0.9
     int Lib_PiccHalt();

     //9.0.10
     int Lib_PiccReset();

     //9.0.11
     int Lib_PiccM1Authority(byte type, byte blkNo, in byte[] pwd, in byte[] serialNo);

     //9.0.12
     int Lib_PiccM1ReadBlock(byte blkNo, out byte[] blkValue);

     //9.0.13
     int Lib_PiccM1WriteBlock(byte blkNo, in byte[] blkValue);

     //9.0.14
     int Lib_PiccM1Operate(byte type, byte blkNo, in byte [] value, byte updateBlkNo);

     //9.0.15
     int Lib_PiccM1WriteValue(int blkNo,in byte[] value);

     //9.0.16
     int Lib_PiccM1ReadValue(int blkNo,out byte[] value);

     //9.0.17
     int Lib_PiccM1RestoreTransfer(byte SrcBlock,byte DstBlock);

     //9.0.18
     int Lib_PiccSamAv2Init(int SamSlotNo ,in byte[] SamHostKey,out byte[] SAMHostMode, out  byte[]  SAMAV2Version, out byte[] jSamAv2VerLen);

     //9.0.19
     int Lib_PiccSamMfcAuth(byte KeyType, byte BlkNo, byte KeyNumber, byte KeyVersion);

     //9.0.20
     int Lib_PiccWriSl1KeyToAv2(in byte[] key ,byte KeyNumber,byte KeyPos,byte KeyVersion);

     //9.0.21
     int Lib_PiccHwModeSet(int Mode );

     //9.0.22
     int Mful_ActivateCard();

     //9.0.23
     int Mful_PwdAuth(in byte[] Key,out byte[] Pack );

     //9.0.24
     int Mful_Read(int PageNum,out byte[] Data);

     //9.0.25
     int Mful_Write(int PageNum,in byte[] Data);

     //9.0.26
     int Mful_ReadSign(int Addr,out byte[] Signature);

     //9.0.27
     int Mful_ReadCnt(int CntNum,out byte[] Counter);

     //9.0.28
     int Mful_IncrCnt(int CntNum,in byte[] IncValue);

     //9.0.29
     int Mfp_ActivateCard();

     //9.0.30
    int Mfp_WritePerso(int wBlockNr,in byte[] jaValue);

    //9.0.31
    int Mfp_CommitPerso();

    //9.0.32
    int Mfp_AuthenticateSL(byte SLNum,byte bFirstAuth,int wBlockNr,int wKeyNumber,int wKeyVersion,byte bLenDivInput,
                                          in byte[] jaDivInput,
                                          byte bLenPcdCap2,
                                          in byte[] jaPcdCap2In,
                                          out byte[] jaPcdCap2Out,
                                          out byte[] jaPdCap2,
                                          out byte[] jaKmf);

    //9.0.33
    int Mfp_AuthenticateClassicSL2(byte bBlockNo,byte bKeyType,int wKeyNumber,int wKeyVersion);

    //9.0.34
    int Mfp_MultiBlockRead(byte bBlockNr,byte bNumBlocks,out byte[] jaBlocks);

    //9.0.35
    int Mfp_MultiBlockWrite(byte bBlockNr,byte bNumBlocks,in byte[] jaBlocks);

    //9.0.36
    int Mfp_Write(byte bEncrypted,byte	bWriteMaced,int	wBlockNr,byte bNumBlocks,in byte[] jaBlocks);

    //9.0.37
    int Mfp_WriteValue(byte bEncrypted,byte	bWriteMaced,int	wBlockNr,in byte[] jaBlocks,byte bAddrData);

    //9.0.38
    int Mfp_ChangeKey(byte bChangeKeyMaced,int wBlockNr,int	wKeyNumber,int wKeyVersion,byte bLenDivInput,in byte[] jaDivInput);

    //9.0.39
    int Mfp_Read(byte bEncrypted,byte bReadMaced,byte bMacOnCmd,int	wBlockNr,byte bNumBlocks,out byte[]	jaBlocks);

    //9.0.40
    int Mfp_ReadValue(int bEncrypted,byte bReadMaced,byte bMacOnCmd,int	wBlockNr,out byte[] jaValue,out byte[] jaAddrData);

    //9.0.41
    int Mfp_ResetAuth();

    //9.0.42
    int Mfp_ProximityCheck(int bGenerateRndC,in byte[] jaRndC,byte bPps1,byte bNumSteps,out byte[] jaUsedRndC);

    //9.0.43
    int Mfp_ResetSecMsgState();

    //9.0.44
    int Mfp_KeyStore(in byte[] pbNewKey,byte ucNewKeyLen,byte ucKeyStoreKeyType,byte ucKeyNumber,byte ucKeyVersion);

    //9.0.45
    int Picc_SamOpen(int SamSlotNo,out byte[] SamAtr);

    //9.0.46
    int Picc_SamClose(int SamSlotNo);



/*---------------------------  Paypass APIs -------------------------------------------------------*/
    //10.0.1
    int PaypassKernelInit();

    //10.0.2
    int PaypassAidSet(String jString);

    //10.0.3
    int PaypassCapkSet(String jString);

    //10.0.4
    int PaypassKernelSet(String  jString);

    //10.0.5
    int PaypassReaderSet(String  jString);

    //10.0.6
    int PaypassTransSet(String  jString, int baud);

    //10.0.7
    int PaypassTransaction();

    //10.0.8
    int PaypassGetTagValue(out byte[] OutPut, int OutputBufSize, int tagname);

    //10.0.9
    int PaypassFinal();
    

/*---------------------------  Paywave APIs -------------------------------------------------------*/
    //11.0.1
     int PayWaveKernelInit();

    //11.0.2
    int PayWaveDownloadAIDS(String  jString);

    //11.0.3
    int PayWaveDownloadCapks(String  jString);

    //11.0.4
    int PayWaveDownloadTerm(String  jString);

    //11.0.5
    int PayWaveTrans();

    //11.0.6
     int PayWaveSetTransAmount(int Amount);

    //11.0.7
     int PayWaveSetOtherTransAmount(int Amount);

    //11.0.8
     int PayWaveSetTransType(int Type);

    //11.0.9
     int PayWaveGetTagData(out byte[]  OutPut, int OutputBufSize, int tagname);

    //11.0.10
     int PayWaveClearAllCapk();

    //11.0.11
     int PayWaveClearAllTerm();

    //11.0.12
     int PayWaveClearAllAIDS();

    //11.0.13
     int PayWaveFinal();
/**---------------------------  EMVCO APIs -------------------------------------------------------*/
     //12.0.1
     int EmvParaInit();

     //12.0.2
     int EmvContextInit(int index, int i);

     //12.0.3
     int EmvClearAllAIDS();

     //12.0.4
     int EmvClearOneAIDS(in byte[] Input, int InLen);

     //12.0.5
     int EmvAddOneAIDS(in byte[] Input, int InLen);

     //12.0.6
     int EmvClearAllCapks();

     //12.0.7
     int EmvClearOneCapks(in byte[] Input, int InLen);

     //12.0.8
     int EmvAddOneCAPK(in byte[] Input, int InLen);

     //12.0.9
     int EmvSaveTermParas(in byte[] Input, int InLen,int index);

     //12.0.10
     int EmvSetTransAmount(int amount);

     //12.0.11
     int EmvSetExtAmount(in int[] amount);  // yxs not  accomplish

     //12.0.12
     int EmvSetTransAmountBack(int amountBack);

     //12.0.13
     int EmvSetCardType(int cardtype) ;

     //12.0.14
     int EmvSetTransType(int TransTypeNum );

     //12.0.15
     int EmvProcess(int KernelType, int FlowType);

     //12.0.16
     int EmvGetTagData(out byte[]  OutPut, int OutputBufSize, int tagname);

     //12.0.17
     int EmvSetOnlineResult(in byte[] result, in byte[] IsSuerRespData, int IsSuerRespDataLength);

     //12.0.18
     int EmvGetPinBlock(int type, int pinkey_n, in byte[] card_no, in byte[] mode, out byte[] pin_block, int timeout);

     //12.0.19
     int EmvGetDukptPinblock_T(int pinkey_n, in byte[] card_no, out byte[] pin_block, out byte[] OutKsn, out byte[] PinKcv, int timeout);

     //12.0.20
     int EmvGetAESDukptPinblock(int pinkey_n, in byte[] card_no, out byte[] pin_block, out byte[] OutKsn, out byte[] PinKcv, int timeout);

     //12.0.21
     int EmvGetMKSKPinblock(int pinkey_n, in byte[] card_no, out byte[] pin_block, out byte[] PinKcv, int timeout);

     //12.0.22
     int EmvGetAESMKSKPinblock(int pinkey_n, in byte[] card_no, out byte[] pin_block, out byte[] PinKcv, int timeout);

     //12.0.23
     int EmvGetDukptPinblock(int type ,int pinkey_n , in byte[] card_no, out byte[] pin_block, out byte[] OutKsn, out byte[] PinKcv, int timeout);

     //12.0.24
     int EmvGetKLKPinBlock(int type , int pinkey_n, in byte[] card_no, in byte[] mode,  out byte[] pin_block, int timeout);

     //12.0.25
     int GetDukptClearPinblock(int pinkey_n , in byte[] card_no, in byte[] pinclear, out byte[] pin_block, out byte[] OutKsn, out byte[] PinKcv);

     //12.0.26
     int SetAddKSNDATA(int mode, int key_index);

     //12.0.27
     int Lib_EntryPoint();

     //12.0.28
     int Lib_SetEntryModeOpen();

     //12.0.29
     int Lib_SetEntryModeClose();

     //12.0.30
     int EmvFinal();
/*---------------------------  Express APIs -------------------------------------------------------*/
    //13.0.1
    int ExpressKernelInit();

    //13.0.2
    int ExpressAidSet(String  jString);

    //13.0.3
    int ExpressCapkSet(String  jString);

    //13.0.4
    int ExpressGenerlParamSet(String  jString);

    //13.0.5
    int ExpressDRLParamSet(String  jString);

    //13.0.6
    int ExpressCRLParamSet(String  jString);

    //13.0.7
    int ExpressExcepFileParamSet(String  jString);

    //13.0.8
    int ExpressKernelConfigSet(String  jString);

    //13.0.9
    int ExpressTransaction(String  jString);

    //13.0.10
    int ExpressGetTagData(int tagname, out byte[]  OutPut);

    //13.0.11
    int ExpressOff();

/*---------------------------  PCI APIs -------------------------------------------------------*/
     //14.0.1
     int Lib_PciWritePinMKey(byte keyNo, byte keyLen, in byte[] keyData, byte mode);

     //14.0.2
     int Lib_PciWriteMacMKey(byte keyNo, byte keyLen, in byte[] keyData, byte mode);

     //14.0.3
     int Lib_PciWriteDesMKey(byte keyNo, byte keyLen, in byte[] keyData, byte mode);

     //14.0.4
     int Lib_PciWritePinKey(byte keyNo, byte keyLen, in byte[] keyData, byte mode, byte mkeyNo);

     //14.0.5
     int Lib_PciWriteMacKey(byte keyNo, byte keyLen, in byte[] keyData, byte mode, byte mkeyNo);

     //14.0.6
     int Lib_PciWriteDesKey(byte keyNo, byte keyLen, in byte[] keyData, byte mode, byte mkeyNo);

     //14.0.7
     int Lib_PciReadKCV(byte mkey_no, byte key_type,out byte[] mkey_kcv);

     //14.0.8
     int Lib_PciWriteKLKPinKey(byte keyNo, byte keyLen, in byte[] keyData, byte mode, byte mkeyNo, out byte[] mkey_kcv,  byte main_work);

     //14.0.9
     int Lib_PciWriteKLKMacKey(byte keyNo, byte keyLen, in byte[] keyData, byte mode, byte mkeyNo, out byte[] mkey_kcv,   byte main_work);

     //14.0.10
     int Lib_PciWriteKLKDesKey(byte keyNo, byte keyLen, in byte[] keyData, byte mode, byte mkeyNo, out byte[] mkey_kcv,   byte main_work);

     //14.0.11
     int Lib_PciGetPin(byte keyNo, byte minLen, byte maxLen, byte mode,in byte[] cardNo, out byte[] pinBlock, in byte[] pinPasswd,byte pin_len, byte mark, in byte[] iAmount, byte waitTimeSec);

     //14.0.12
     int Lib_PciGetMac(byte keyNo, int inLen, in byte[] inData, out byte[] macout, byte mode);

     //14.0.13
     int Lib_PciGetDes(byte keyNo, int inLen, in byte[] inData, out byte[] desout, byte mode);

     //14.0.14
     int Lib_PciGetKLKPin(byte keyNo, byte minLen, byte maxLen, byte mode,in byte[] cardNo, out byte[] pinBlock, in byte[] pinPasswd,byte pin_len, byte mark, in byte[] iAmount, byte waitTimeSec);

     //14.0.15
     int Lib_PciGetKLKMac(byte keyNo, int inLen, in byte[] inData, out byte[] macout, byte mode);

     //14.0.16
     int Lib_PciGetKLKDes(byte keyNo, int inLen, in byte[] inData, out byte[] desout, byte mode);

     //14.0.17
     int Lib_PciGetSelPalPin(byte keyNo, byte minLen, byte maxLen, byte mode,in byte[] cardNo, out byte[] pinBlock, in byte[] pinPasswd,byte pin_len, byte mark, in byte[] iAmount, byte waitTimeSec);

     //14.0.18
     int Lib_PciGetSelPalMac(byte keyNo, int inLen, in byte[] inData, out byte[] macout, byte mode);

     //14.0.19
     int Lib_PciGetSelPalDes(byte keyNo, int inLen, in byte[] inData, out byte[] desout, byte mode);

     //14.0.20
     int Lib_PciWriteDukptIpek(int KeyId,  int IpekLen,  in byte[] Ipek, int KsnLen,  in byte[] Ksn);

     //14.0.21
     int Lib_PciWriteBdk(int KeyId,  int BdkLen,  in byte[] Bdk, int KsnLen, in byte[] Ksn);

     //14.0.22
     int Lib_PciGetDukptMac(int KeyId, byte  mode, byte  Mac_data_len, in byte[]  Mac_data_in, out byte[] Mac_out, out byte[] OutKsn, out byte[] MacKcv);

     //14.0.23
     int Lib_PciGetDuktDes(int KeyId, byte mode, byte DesMode, int  Des_data_len, in byte[] Des_data_in, in byte[] jIV, out byte[]  Des_out, out byte[]  OutKsn,  out byte[]  DesKcv);
/*---------------------------  transaction kernel common APIs -------------------------------------------------------*/
     //1x.0.1
     int InitPaySysKernel();

     //1x.0.2
     int UninitPaySysKernel();

     //1x.0.3
     int EmvKeyPadInit(in Bitmap logo);

     //1x.0.4
     int EmvSetKeyPadTime( int time_s);

     //1x.0.5
     int EmvSetKeyPadType(int Type);

     //1x.0.6
     int EmvSetPtcCounter(int counter);

     //1x.0.7
     int EmvSetExtTransAmount();

     //1x.0.8
     int EmvSetExtPtcCounter();

/*---------------------------  other misc APIs -------------------------------------------------------*/

     int Lib_SetLed(byte ledn,byte mode);
}
