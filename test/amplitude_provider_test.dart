import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_app_analytics/flutter_app_analytics.dart';

import 'amplitude_provider_test.mocks.dart';

@GenerateMocks([Dio])
void main() {
  AmplitudeProvider amplitude =
      AmplitudeProvider('e15bd3e31de87e9799aa8a0878fc060f');
  MockDio dio = MockDio();
  amplitude.dio = dio;
  group('identify', () {
    test('makes a call to the amplify identify api', () async {
      AnalyticsIdentification props = AnalyticsIdentification();
      props.userId = 'foo';
      reset(dio);

      Response res =
          Response(data: null, requestOptions: RequestOptions(path: 'foo'));
      when(dio.post('https://api.amplitude.com/identify',
              data: anyNamed('data'), options: anyNamed('options')))
          .thenAnswer((_) async => res);
      await amplitude.identify(props);
      verify(dio.post('https://api.amplitude.com/identify',
              data: anyNamed('data'), options: anyNamed('options')))
          .called(1);
    });
  });
  group('trackEvent', () {
    AnalyticsIdentification props = AnalyticsIdentification();
    props.userId = 'foo';

    test('makes a call to the httpapi track the event', () async {
      reset(dio);

      var data = {'ip': '1.2.3.4'};
      Response res =
          Response(data: data, requestOptions: RequestOptions(path: 'foo'));

      when(dio.get('https://api.ipify.org?format=json'))
          .thenAnswer((_) async => res);

      when(dio.post('https://api2.amplitude.com/2/httpapi',
              data: anyNamed('data')))
          .thenAnswer((_) async => res);

      when(dio.post('https://api.amplitude.com/identify',
              data: anyNamed('data'), options: anyNamed('options')))
          .thenAnswer((_) async => res);

      await amplitude.identify(props);
      await amplitude.trackEvent(AnalyticsEvent(name: 'foo', properties: {}));
      verify(dio.post('https://api2.amplitude.com/2/httpapi',
              data: anyNamed('data')))
          .called(1);
    });
  });
}
