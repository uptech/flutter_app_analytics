import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_app_analytics/flutter_app_analytics.dart';
import 'analytics_test.mocks.dart';

@GenerateMocks([AmplitudeProvider])
void main() {
  Analytics analytics = Analytics();
  MockAmplitudeProvider amplitudeProvider = MockAmplitudeProvider();
  group('identify', () {
    test('calls identify on each of the providers', () {
      analytics.providers = [amplitudeProvider];
      AnalyticsIdentification identifyProps = AnalyticsIdentification();
      analytics.identify(identifyProps);
      verify(amplitudeProvider.identify(identifyProps)).called(1);
    });
  });

  group('trackEvent', () {
    test('calls identify on each of the providers', () {
      analytics.providers = [amplitudeProvider];
      AnalyticsEvent event = AnalyticsEvent(name: 'some_event');
      analytics.trackEvent(event);
      verify(amplitudeProvider.trackEvent(event)).called(1);
    });
  });
}
