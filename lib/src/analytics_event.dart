class AnalyticsEvent {
  String eventType;
  Map<String, dynamic> properties;

  AnalyticsEvent(String eventType, Map<String, dynamic> properties) {
    this.eventType = eventType;
    this.properties = properties;
  }
}
