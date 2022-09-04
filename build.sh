#!/bin/bash

nativefier --platform linux \
           --arch arm64 \
           --icon "slack_1.0.0/usr/share/pixmaps/slack.png" \
           --icon-tray 'slack-tray.png' \
           --icon-status 'slack-status.png' \
           --tray \
           --name Slack \
           --single-instance \
           'https://myworkspace.slack.com'

rm -rf slack_1.0.0/usr/lib/slack
mv -f Slack-linux-arm64 slack_1.0.0/usr/lib/slack

StartupWMClass=$(grep -Po '"name": "\K.*(?=",)' slack_1.0.0/usr/lib/slack/resources/app/package.json)

sed -i "s/StartupWMClass=.*/StartupWMClass=${StartupWMClass}/g" slack_1.0.0/usr/share/applications/slack.desktop

sed -i "s/Architecture:.*/Architecture: aarch64/g" slack_1.0.0/DEBIAN/control

dpkg-deb --build slack_1.0.0

