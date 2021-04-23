import 'package:flutter_app_analytics/src/analytics_event.dart';
import 'package:flutter_app_analytics/src/analytics_identification.dart';

abstract class AnalyticsProvider {
  Future<void> identify(AnalyticsIdentification properties);
  Future<void> trackEvent(AnalyticsEvent event);
}
