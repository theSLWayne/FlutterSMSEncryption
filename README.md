## Encrypted SMS APP

- Flutter mobile encrypted sms system developed by team /dev/null
- A secure way to send sms using a encryption algorithm.
- A solution developed by Flutter for Android mobile devices.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Run Flutter App

- Connect a mobile device or run an android emulator.
- Open Terminal.
- Navigate to the folder which contains main.dart file.
- Type and run
> flutter doctor
- If everything is okay with Flutter Doctor, type and run 
> flutter run

## Encryption/Decryption

- The most important part of the application.
- Enables secure information flow through sms.
- The algorithm used: AES CBC 128bits
- Used inputs for encryption: PlainText, Encryption Key, Nonce
    - Plain Text: Message
    - Encryption Key: 16 bit string
    - Nonce: 16 bit string
- Nonce value is hardcorded into the app.
- The app sends encrypted text to the reciever's phone.
- Users should send passwords using their own ways.
- Anyone who doesn't have the app stands no chance of decrypting because anyone outside doesn't have access to the nonce value.
- Used inputs for decryption: CypherText, Decryption Key, Nonce
    - CypherText: Recieved encrypted message
    - Decryption Key: 16 bit string
    - Nonce: 16 bit string

## Dependencies

    cipher2: 0.3.0
    flutter:
        sdk: flutter
    sms: ^0.2.0