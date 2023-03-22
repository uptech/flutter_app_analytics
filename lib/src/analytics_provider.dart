import 'package:flutter_app_analytics/src/analytics_event.dart';

abstract class AnalyticsProvider {
  List<String> allowedUserProperties = [];
  Future<void> identify({String? userId, Map<String, dynamic>? properties});
  Future<void> trackEvent(AnalyticsEvent event);
  Future<void> trackEvents(List<AnalyticsEvent> events);
}
