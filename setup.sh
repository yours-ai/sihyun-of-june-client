#!/bin/sh

# init flutter icons
if [[ -n "$IS_LIVE" ]]; then
    dart run flutter_launcher_icons -f flutter_launch_icon_live.yaml
    cp ./firebase/live/google-services.json ./android/app/
    cp ./firebase/live/GoogleService-Info.plist ./ios/Runner/
    cp ./firebase/live/firebase_options.dart ./lib/
else
    dart run flutter_launcher_icons -f flutter_launch_icon_dev.yaml
    cp ./firebase/dev/google-services.json ./android/app/
    cp ./firebase/dev/GoogleService-Info.plist ./ios/Runner/
    cp ./firebase/dev/firebase_options.dart ./lib/
fi

# init flutter splashs
dart run flutter_native_splash:create

# auto generate json code, using json_serializable
dart run build_runner build --delete-conflicting-outputs