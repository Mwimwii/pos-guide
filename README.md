# Usage in Z500(S50) SDK Usage

This is a usage guide of the Z500(C50) POS SDK, the implementation was written in react native but its not too far from Flutter.

## Native Java module

The Native Java Modules were targeted to a React Native setup but its not too far from flutter Method/Event Channels:

- NfcModule:
  - The POS needs to be explicitly set to read a specifcic type of card, so unfourtunately the Android NFC Library does not work.
  - According to the manual, the standard of the justtap cards is compatible with Mifare Ultralight which is included in the Module.
  - It starts a thread to handle the reading cards and sends a simple auth to decode the value inside.
- PrinterModule
  - The printer module also relies on a non standard printer and is also specific to the POS.
  - Its quite useful since you can use an EventChannel to check the printing status.
  - There are some Helpers to also assist with error codes `PosApiHelper`
- CardModule:
  - Just a simple EMV Card Reader (Visa, MasterCard, etc).

I'll demonstrate how I used the modules in react native. This will give you good idea on how the SDK works

## NFC Reader Module Usage `NfcModule.java`

This is what the application is doing:

1. The NFC Module is fetched from the available modules in the android package.
2. A useCallback hook is called to invoke the `readNfcCard` function every 200ms.
3. An event listener is created to listen to event data sent from `NfcModule.java`
4. The value returned is in hex format so a utility function `hexToAscii` gives us a more readable string

Note: - You'll need to create a Event Channel for the Flutter implementation since a thread is created to handle the reading - You may need to also have a provision to kill the thread when the screen is out of the view (`NfcModule.stopThread();`)

```js

  import { ...NativeEventEmitter, NativeModules } from "react-native";
  ...
  const { NfcModule } = NativeModules;

  function TapToPay() {
    ...
    useFocusEffect(
      useCallback(() => {
        let evenListener;
        let nfcPoll;
        function readMifare() {

          nfcPoll = setInterval(() => {
            NfcModule.readNfcCard();
          }, 200);

          const eventEmitter = new NativeEventEmitter(NfcModule);
          evenListener = eventEmitter.addListener('NFCCardData', (event) => {
            const payloadString = hexToAscii(event['CardData']);
            const startIndex = payloadString.indexOf('260');
            const slicedNumber = payloadString.slice(startIndex, startIndex + 12);
            setPayerPhone(() => {
              return slicedNumber;
            });
            clearInterval(nfcPoll);
          });
        }
        readMifare();
        return () => {
              clearInterval(nfcPoll);
              NfcModule.stopThread();
              evenListener.remove();
        };
      }, []));
  }
```

## Printer Module Usage `PrinterModule.java`

The printer module is more straight forward and the same applies

```js
  import { NativeModules, Platform, Button } from "react-native";
  ...
  const { PrinterModule } = NativeModules;
  function PaymentAuthorization() {
    const { user } = useContext(AuthContext);
    const { payerPhone } = useContext(PaymentContext);
    const onPressReturn = () => {
      if (Platform.OS !== "ios") {
        try {
          PrinterModule.printText(amount, user.name, payerPhone, "12/10/23", "https://www.gom.com");
        } catch (err) {
          console.warn(err);
        }
      }
    };
    return (
      <Button onPress={() => onPressReturn()}>Return</Button>
    );
  }

  export default PaymentAuthorization;

```

## Utilities

## Hex to Ascii

```js
function hexToAscii(hexString) {
  let output = "";
  for (let i = 0; i < hexString.length; i += 2) {
    const hex = hexString.substr(i, 2);
    const decimal = parseInt(hex, 16);
    output += String.fromCharCode(decimal);
  }
  return output;
}
```

Please reach out if anything
mpnyirongo@gmail.com
