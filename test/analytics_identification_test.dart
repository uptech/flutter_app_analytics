import 'package:flutter_app_analytics/flutter_app_analytics.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('fetchDeviceInfo', () {
    test('fetches the identity for the current device', () async {
      final properites = await AnalyticsIdentification.identifyDevice();
      expect(properites.platform, isNot(null));
    });
  });
}
