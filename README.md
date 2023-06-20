# [Royal Stock Exchange(RSE) Flutter Client](https://github.com/PrimeTimeTran/f-RSE)
# [Royal Stock Exchange(RSE) Flutter Client](https://royal-stock-exchange.netlify.app/)

![Preview](https://s11.gifyu.com/images/SQLgu.gif)

A stock exchange for the next generation.

- [Demo](https://royal-stock-exchange.netlify.app/)
- [Client Code](https://github.com/PrimeTimeTran/f-RSE)

## Dependencies

- Flutter
- Bloc
- SyncFusion

## Getting Started

- Get a copy of `.env`
- Create a NOTES.md for saving code snippets and notes for yourself.
- Create a SCRATCHPAD.md for saving snippets while working which you don't necessarily want to keep "long term"

### Deployment

#### Web

- flutter build web
- flutter run -d chrome

## FAQ

- Why isn't an asset in assets available on web?
  - Because we have to include them in web/assets & declare them in web/manifest.json for them to be bundled in the build process