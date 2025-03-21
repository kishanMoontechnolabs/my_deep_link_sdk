# My Deep Link SDK

[![Pub Version](https://img.shields.io/pub/v/my_deep_link_sdk.svg)](https://pub.dev/packages/my_deep_link_sdk)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

A Flutter package for **handling deep links** without Firebase.  
It allows you to **generate, share, and receive deep links** on Android & iOS.

## 🎯 Features
✨ **Generate & share short deep links**  
🔗 **Receive & handle deep links in real-time**  
📲 **Automatically open a new screen when a link is received**  
🌎 **Supports `myapp://deeplink` & `https://` links**  
📱 **Works seamlessly on Android & iOS**

---

## 📦 Installation

1️⃣ **Add this to your `pubspec.yaml`:**
```yaml
dependencies:
  my_deep_link_sdk: ^1.0.0
```

2️⃣ **Run:**
```sh
flutter pub get
```

---

## 🛠️ Usage

### **1️⃣ Import the Package**
```dart
import 'package:my_deep_link_sdk/my_deep_link_sdk.dart';
```

### **2️⃣ Generate & Share a Deep Link**
```dart
import 'package:share_plus/share_plus.dart';

final MyDeepLinkSDK deepLinkSDK = MyDeepLinkSDK();

// Generate a deep link with parameters
String shortLink = deepLinkSDK.createShortLink({"id": "123", "user": "flutter11"});

// Share the deep link
Share.share("Check this out: $shortLink");
```

### **3️⃣ Receive & Handle a Deep Link**
```dart
void listenForDeepLinks() {
  deepLinkSDK.decodedLinkStream.listen((params) {
    print("Received Deep Link Parameters: $params");
  });
}
```

---

## 🔧 Setup for Android & iOS

### **🟢 Android (Update `AndroidManifest.xml`)**
📂 **`android/app/src/main/AndroidManifest.xml`**
```xml
<intent-filter>
    <action android:name="android.intent.action.VIEW" />
    <category android:name="android.intent.category.DEFAULT" />
    <category android:name="android.intent.category.BROWSABLE" />
    <data android:scheme="myapp" android:host="deeplink" />
</intent-filter>

<intent-filter android:autoVerify="true">
    <action android:name="android.intent.action.VIEW" />
    <category android:name="android.intent.category.DEFAULT" />
    <category android:name="android.intent.category.BROWSABLE" />
    <data android:host="kishanmoontechnolabs.github.io"
          android:pathPrefix="/deep_link_redirect/"
          android:scheme="https" />
</intent-filter>
```

### **🟢 iOS (Update `Info.plist`)**
📂 **`ios/Runner/Info.plist`**
```xml
<key>CFBundleURLTypes</key>
<array>
    <dict>
        <key>CFBundleURLSchemes</key>
        <array>
            <string>myapp</string>
        </array>
    </dict>
</array>
<key>LSApplicationQueriesSchemes</key>
<array>
    <string>myapp</string>
</array>
<key>UIApplicationSupportsIndirectInputEvents</key>
<true/>
```

---

## 📜 Changelog
See [`CHANGELOG.md`](https://github.com/kishanMoontechnolabs/my_deep_link_sdk/blob/master/CHANGELOG.md) for release notes.

---

## 💡 Contributing
We welcome contributions!  
Feel free to **open an issue** or **submit a pull request**.

---

## 📄 License
This project is licensed under the **MIT License** - see [`LICENSE`](https://github.com/kishanMoontechnolabs/my_deep_link_sdk/blob/master/LICENSE) for details.

---

## 🌟 Support & Feedback
If you find this package useful, **please give it a ⭐ on GitHub!** 😊  
For issues, please **open a GitHub issue**.

---