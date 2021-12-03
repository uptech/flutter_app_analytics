# Flutter App Analytics

A flutter package to help abstract away vendor specific implementations of in app analytics.

## Supported Providers
[Amplitude](https://github.com/uptech/flutter_app_analytics_amplitude_provider)
[Firebase](https://github.com/uptech/flutter_app_analytics_firebase_provider)

## Testing

### Run Tests

```
flutter test
```

## Generating your mocks

We use build_runner to generate mocks from mockito:

```
flutter pub run build_runner build
```
