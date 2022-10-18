import 'dart:io' show Platform;

class Secret {
  static const ANDROID_CLIENT_ID = "<enter your Android client secret>";
  static const IOS_CLIENT_ID = "<enter your iOS client secret>";
  static String getId() =>
      Platform.isAndroid ? Secret.ANDROID_CLIENT_ID : Secret.IOS_CLIENT_ID;
}
