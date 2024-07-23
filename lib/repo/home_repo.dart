import 'package:copartner_assignment_app/constant/end_point.dart';
import 'package:copartner_assignment_app/services/network_services.dart';
import 'package:copartner_assignment_app/utils/utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class SubscriptionRepo {
  final _networkService = NetworkServices();
  getSubscription(BuildContext context) async {
    try {
      final response = await _networkService
          .get(ApiEndPoint.expertDetail)
          .catchError((error, stackTrace) {
        Utils.showMyDialog(error.toString(), context);
        if (kDebugMode) {
          print(error.toString());
        }
      });

      return response;
    } catch (e) {
      rethrow;
    }
  }
}
