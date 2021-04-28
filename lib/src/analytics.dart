library flutter_app_analytics;

import 'package:device_info_plus/device_info_plus.dart';
import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_app_analytics/src/analytics_event.dart';
import 'package:flutter_app_analytics/src/analytics_identification.dart';
import 'package:flutter_app_analytics/src/analytics_provider.dart';

class Analytics {
  List<AnalyticsProvider> providers = [];

  Future<void> identify(AnalyticsIdentification properties) async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

    if (kIsWeb) {
      WebBrowserInfo webBrowserInfo = await deviceInfo.webBrowserInfo;
      properties.platform = 'web';
      properties.osVersion = webBrowserInfo.appVersion;
      properties.osName = webBrowserInfo.appName;
    } else {
      // Code below hasn't been tested yet on iOS and Android
      if (Platform.isAndroid) {
        AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
        properties.platform = 'android';
        properties.deviceBrand = androidInfo.brand ?? '';
        properties.deviceManufacturer = androidInfo.manufacturer ?? '';
        properties.deviceModel = androidInfo.model ?? '';
        properties.osName = androidInfo.version.baseOS ?? '';
        properties.osVersion =
            "${androidInfo.version.codename} - ${androidInfo.version.release}";
      } else if (Platform.isIOS) {
        IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
        properties.platform = 'iOS';
        properties.deviceManufacturer = 'Apple';
        properties.deviceModel = iosInfo.model ?? '';
        properties.osName = iosInfo.systemName ?? '';
        properties.osVersion = iosInfo.systemVersion ?? '';
      }
    }
    providers.forEach((provider) async {
      await provider.identify(properties);
    });
  }

  Future<void> trackEvent(AnalyticsEvent event) async {
    providers.forEach((provider) async {
      await provider.trackEvent(event);
    });
  }
}
