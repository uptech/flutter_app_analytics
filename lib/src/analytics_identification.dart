import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class AnalyticsIdentification {
  String? userId;
  String? deviceId;
  String? osName;
  String? osVersion;
  String? platform;
  String? appVersion;
  String? deviceBrand;
  String? deviceManufacturer;
  String? deviceModel;
  Map<String, dynamic>? userProperties;

  static Future<AnalyticsIdentification> identifyDevice() async {
    AnalyticsIdentification properties = AnalyticsIdentification();

    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (kIsWeb) {
      WebBrowserInfo info = await deviceInfo.webBrowserInfo;
      properties.osName = info.appName;
      properties.osVersion = Platform.operatingSystemVersion;
      properties.deviceManufacturer = info.vendor;
      properties.deviceId = 'unknown_web_device_id';
      properties.platform = 'web';
    } else {
      try {
        properties.platform = Platform.operatingSystem;

        if (Platform.isMacOS) {
          MacOsDeviceInfo info = await deviceInfo.macOsInfo;
          properties.osName = info.hostName;
          properties.osVersion = info.osRelease;
          properties.deviceId = 'unknown_macos_device_id';
          properties.deviceManufacturer = 'Apple';
          properties.deviceModel = info.model;
        } else if (Platform.isIOS) {
          IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
          properties.osName = iosInfo.systemName;
          properties.osVersion = iosInfo.systemVersion;
          properties.deviceId = iosInfo.identifierForVendor;
          properties.deviceManufacturer = 'Apple';
          properties.deviceModel = iosInfo.utsname.machine;
          properties.deviceBrand = iosInfo.localizedModel;
        } else if (Platform.isAndroid) {
          AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
          properties.osName = androidInfo.version.codename;
          properties.osVersion = androidInfo.version.release;
          properties.deviceId = androidInfo.id;
          properties.deviceManufacturer = androidInfo.manufacturer;
          properties.deviceBrand = androidInfo.brand;
          properties.deviceModel = androidInfo.model;
        } else if (Platform.isLinux) {
          LinuxDeviceInfo info = await deviceInfo.linuxInfo;
          properties.osName = info.prettyName;
          properties.osVersion = info.versionId;
          properties.deviceId = info.machineId;
        } else {
          properties.deviceId = 'unknown_device_id';
        }
      } catch (e) {
        properties.deviceId = 'unknown_device_id';
      }
    }

    return properties;
  }
}
