# Flutter App Analytics

A flutter package to help abstract away vendor specific implementations of in app analytics.

NOTE: Currently this only supports Amplitude.

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
