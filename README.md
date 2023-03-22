# Flutter App Analytics

A flutter package to help abstract away vendor specific implementations of in app analytics.

## Supported Providers

[Amplitude](https://github.com/uptech/flutter_app_analytics_amplitude_provider)
[Firebase](https://github.com/uptech/flutter_app_analytics_firebase_provider)
[Segment](https://github.com/uptech/flutter_app_analytics_segment_provider)
[Laudspeaker](https://github.com/uptech/flutter_app_analytics_laudspeaker_provider)

## User Properties

We don't want to dissiminate private information to third parties, so we've added the ability to set an allowed list of user properties that get used in the identify call. It's up to each provider to pass this list into the constructor and save them, but after that this class will make sure to filter out any properties that are sent in identify calls that aren't explicitly allowed.
