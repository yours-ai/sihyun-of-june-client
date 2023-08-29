#!/bin/sh

# init flutter icons
if [[ -n "$IS_DEV" ]]; then
    dart run flutter_launcher_icons -f flutter_launch_icon_dev.yaml
else
    dart run flutter_launcher_icons -f flutter_launch_icon_live.yaml
fi

# init flutter splashs
dart run flutter_native_splash:create

# auto generate json code, using json_serializable
dart run build_runner build --delete-conflicting-outputs
