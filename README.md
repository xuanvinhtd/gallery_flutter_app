# Gallery Flutter App

A new Gallery Flutter project, using Google Photo API

- [The video demo this app](https://youtu.be/NEsSlzku0Mo)

### Gallery Project Environment

- Environment: Flutter sdk: ">=2.12.0 <3.0.0"
- Xcode 12.4
- Visual Studio Code 1.56.2
- Android 3.6
- Ruby 2.7.2
- Pod 1.10.1

### Features
- The simple manager the photos/videos in the device
- The simple manager the photos/videos on the Cloud(Use Google Photo API)
- Create the album   
- Upload a photo/video
- Preview Photo/Video

### Technique
- Structure project for Flutter
- Config evironment(Dev,Pro, Stg)
- Setup multiple language(vn, en) & Sample
- Setup Light/Dart Theme
- Logic code used BLOC & Sample
- Core network use Dio & Sample
- Setup Lint Rules by Google rules
- Login by Google

## Plugins

- Flutter 2.0.6
- intl: ^0.17.0
- equatable: ^2.0.2
- flutter_bloc: ^7.0.1
- dio: ^4.0.0
- pretty_dio_logger: ^1.1.1
- cached_network_image: ^3.0.0
- pedantic: ^1.11.0
- google_sign_in: ^5.0.2
- image_picker: ^0.7.4
- video_player: ^2.1.5


### Run Gallery Project

1. Start a iOS/Android simulator
2. Run below commannds on the terminal
```
flutter clean & flutter pub get

// Development
flutter run --flavor dev -t lib/main_dev.dart

// Staging
flutter run --flavor stg -t lib/main_stg.dart

// Product
flutter run --flavor pro -t lib/main_pro.dart

```

### Build Gallery Project

1. Run the below commannds on the terminal

#### Android
##### Build APK with mode release

```
// Development
flutter clean && flutter build apk --flavor dev -t lib/main_dev.dart --release

// Staging
flutter clean && flutter build apk --flavor stg -t lib/main_stg.dart --release

// Product
flutter clean && flutter build apk --flavor pro -t lib/main_pro.dart --release
```

##### Build APK with mode debug

```
// Development
flutter clean && flutter build apk --flavor dev -t lib/main_dev.dart --debug

// Staging
flutter clean && flutter build apk --flavor stg -t lib/main_stg.dart --debug

// Product
flutter clean && flutter build apk --flavor pro -t lib/main_pro.dart --debug
```

##### Build Bundle with mode debug/release

Like with the above commands, we need to change "apk" to "bundle"

#### iOS

##### Build iOS with mode debug

```
flutter build ios --debug --flavor dev
flutter build ios --debug --flavor stg
flutter build ios --debug --flavor pro
```

##### Build iOS with mode release

```
flutter build ios --release --flavor dev
flutter build ios --release --flavor stg
flutter build ios --release --flavor pro
```

## Reference
- [Flutter website](https://flutter.dev/)
- [Flutter Plugin website](https://pub.dev/)
- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

## Copyright & License

This open source project authorized by Vinh Ho.X(hoxuanvinhuit93@gmail.com), and the license is MIT.