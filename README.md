# wt_console_designer
Designer for creating consoles.

## Build Web

```bash
flutter build web --release  --base-href '/wt_console_designer/'
rsync -va build/web/ docs/ --delete
```