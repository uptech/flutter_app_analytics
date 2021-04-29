import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_app_analytics/src/analytics_event.dart';
import 'package:flutter_app_analytics/src/analytics_identification.dart';
import 'package:flutter_app_analytics/src/analytics_provider.dart';

class AmplitudeProvider implements AnalyticsProvider {
  String _apiKey;
  Dio dio = Dio(); // public for testing :(
  AmplitudeIdentification? _amplitudeIdentification;

  AmplitudeProvider(this._apiKey);

  Future<void> identify(AnalyticsIdentification properties) async {
    this._amplitudeIdentification = AmplitudeIdentification(properties);
    var requestData = this._amplitudeIdentification!.toJson();

    try {
      await dio.post(
        'https://api.amplitude.com/identify',
        data: {
          'api_key': this._apiKey,
          'identification': jsonEncode(requestData),
        },
        options: Options(
          headers: {
            Headers.contentTypeHeader: Headers.formUrlEncodedContentType,
          },
        ),
      );
    } on DioError catch (e) {
      print("Error in Amplify Identify call");

      print(e.requestOptions.data);
      print(e.message);
      if (e.response != null) {
        print(e.response!.data);
        print(e.response!.headers);
      }
    }
  }

  Future<void> trackEvent(AnalyticsEvent event) async {
    try {
      // get the user's IP address first
      var response = await dio.get('https://api.ipify.org?format=json');
      await dio.post('https://api2.amplitude.com/2/httpapi', data: {
        'api_key': this._apiKey,
        'events': [
          {
            'user_id': this._amplitudeIdentification?.properties.userId,
            'device_id': this._amplitudeIdentification?.properties.deviceId,
            'event_type': event.name,
            'event_properties': event.properties,
            'time': DateTime.now().millisecondsSinceEpoch,
            'ip': response.data['ip'],
          }
        ]
      });
    } on DioError catch (e) {
      print("Error in Amplify TrackEvent call");
      print(e.message);

      if (e.response != null) {
        print(e.response!.data);
        print(e.response!.headers);
      }
    }
  }
}

class AmplitudeIdentification {
  AnalyticsIdentification properties;

  AmplitudeIdentification(this.properties);

  Map toJson() => {
        'user_id': this.properties.userId,
        'device_id': this.properties.deviceId,
        'os_name': this.properties.osName,
        'os_version': this.properties.osVersion,
        'app_version': this.properties.appVersion,
        'device_model': this.properties.deviceModel,
        'device_manufacturer': this.properties.deviceManufacturer,
        'device_brand': this.properties.deviceBrand,
        'platform': this.properties.platform,
        'user_attributes': this.properties.userProperties,
      };
}
