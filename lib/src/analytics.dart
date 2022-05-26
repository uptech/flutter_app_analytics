library flutter_app_analytics;

import 'package:flutter_app_analytics/src/analytics_event.dart';
import 'package:flutter_app_analytics/src/analytics_provider.dart';

class Analytics {
  List<AnalyticsProvider> providers = [];

  Future<void> identify({
    String? userId,
    Map<String, dynamic>? properties,
  }) async {
    await Future.forEach<AnalyticsProvider>(providers, (provider) async {
      await provider.identify(userId: userId, properties: properties);
    });
  }

  Future<void> trackEvent(AnalyticsEvent event) async {
    await Future.forEach<AnalyticsProvider>(providers, (provider) async {
      await provider.trackEvent(event);
    });
  }
}
