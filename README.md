# WT Console Designer

Designer for creating consoles that can control other things.

This project is about testing the idea of designing a console that can then be used to communication 
with a background service on a machine somewhere, that can be controlled with the console.

This project is incomplete, and so far has only tested the creating the console portion. 

- Items can be dragged in from the tool bar on the left
- long press to select and long press on the canvas to drag select and area
- items, included selected groups, can be dragged around, aligned and deleted.
- 
The console automatically updates, as the design screen is updated.

## Build Web

```bash
flutter build web -o ./docs --base-href '/wt_console_designer/' --target lib/apps/demo_app.dart --no-tree-shake-icons
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