class AnalyticsEvent {
  String name = '';
  Map<String, dynamic>? properties;

  AnalyticsEvent({required String name, Map<String, dynamic>? properties}) {
    this.name = name;
    this.properties = properties;
  }
}
