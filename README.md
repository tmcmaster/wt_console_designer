# wt_console_designer
Designer for creating consoles.

## Build Web

```bash
flutter build web --release  --base-href '/wt_console_designer/'
rsync -va build/web/ docs/ --delete
```

## Control screen brightness

```bash
osascript -e 'tell application "System Events"' -e 'key code 144' -e ' end tell'
osascript -e 'tell application "System Events"' -e 'key code 145' -e ' end tell'
```

## Control Volume

```bash
osascript -e "set Volume 0"
osascript -e "set Volume 10"
```

## Other codes

```text
160: Mission Control
130: Launch Pad
129: Spotlight
```

## Application Bundle IDs

```bash
osascript -e 'id of app "App Name"'
```

```text
com.seriflabs.affinitydesigner2: Affinity Designer
com.google.Chrome: Google Chrome
```