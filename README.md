# [Royal Stock Exchange(RSE) Flutter Client](https://github.com/PrimeTimeTran/f-RSE)

![Preview](https://s11.gifyu.com/images/SQAUR.gif)

[//]: # (![Preview]&#40;./preview.gif&#41;)

A stock exchange for the next generation.

- [Demo](https://royal-stock-exchange.netlify.app/)
- [Client Code](https://github.com/PrimeTimeTran/f-RSE)

## Dependencies

- Flutter
- Bloc
- SyncFusion

## Getting Started

- Get a copy of `.env`
- Create `./notes` for notes.

### Deployment

#### Web

- flutter build web
- flutter run -d chrome

#### iOS

#### Android

## FAQ

- Why isn't an asset in assets available on web?
  - Because we have to include them in web/assets & declare them in web/manifest.json for them to be bundled in the build process

- How to ensure firebase events are sent to the correct project?
  - iOS:
    - Restart emulator.
  - Android:
    - [Enable live debugging of events](https://stackoverflow.com/questions/42769236/firebase-analytics-debug-view-does-not-show-anything):
      - `adb shell setprop debug.firebase.analytics.app 231022961791`
      - `adb shell setprop debug.firebase.analytics.app com.example.rse`
    - Restart emulator.
