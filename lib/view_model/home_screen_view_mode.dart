import 'dart:developer';

import 'package:copartner_assignment_app/repo/home_repo.dart';
import 'package:flutter/material.dart';

class SubscriptionViewModel extends ChangeNotifier {
  final _subscriptionRepo = SubscriptionRepo();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  setIsLoading(bool value) {
    _isLoading = value;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });
  }

  final List<Map<String, dynamic>> serviceType = [
    {'name': 'Options', 'id': "3"},
    {'name': 'Commodity', 'id': "1"},
    {'name': 'Equity', 'id': "2"},
  ];

  String _selectedServiceTypeId = "3";
  get selectedServiceTypeId => _selectedServiceTypeId;

  handleSelectedServices(Map<String, dynamic> type) {
    _selectedServiceTypeId = type['id']!;
    filterData(_selectedServiceTypeId);
    notifyListeners();
  }

  List<Map<String, dynamic>> filteredData = [];
  List<Map<String, dynamic>> filteredPlan = [];
  List uniqueExpert = [];

  void filterData(String serviceType) {
    filteredData.clear();
    uniqueExpert.clear();
    filteredPlan.clear();

    if (response["isSuccess"] && response["data"] is List) {
      // Step 1: Collect unique experts and their plans
      Map<String, Map<String, dynamic>> expertMap = {};
      Map<String, List<Map<String, dynamic>>> expertPlansMap = {};

      for (var item in response["data"]) {
        if (item["serviceType"] == serviceType) {
          String expertId = item["expertsId"];
          String uniqueKey = '${expertId}_${item["serviceType"]}';

          // Collect unique experts
          if (!expertMap.containsKey(uniqueKey)) {
            expertMap[uniqueKey] = item["experts"];
          }

          // Collect plans for each expert
          if (!expertPlansMap.containsKey(expertId)) {
            expertPlansMap[expertId] = [];
          }
          expertPlansMap[expertId]!.add({
            'planType': item['planType'],
            'durationMonth': item['durationMonth'],
            'amount': item['amount'],
            'discountedAmount': item['discountedAmount'],
            'discountPercentage': item['discountPercentage']
          });
        }
      }
      // Convert maps to lists
      uniqueExpert = expertMap.values.toList();
      filteredPlan = expertPlansMap.values.expand((e) => e).toList();
    }
    notifyListeners();
  }

  double calculateDiscountPercentage(
      double originalPrice, double discountedPrice) {
    if (originalPrice == 0) {
      throw ArgumentError("Original price cannot be zero.");
    }
    double discount = originalPrice - discountedPrice;
    double discountPercentage = (discount / originalPrice) * 100;
    return discountPercentage;
  }

  dynamic response;
  Future getSubscription(BuildContext context) async {
    setIsLoading(true);
    try {
      response = await _subscriptionRepo.getSubscription(context);
      setIsLoading(false);
    } catch (e) {
      setIsLoading(false);
      log('Erroer $e');
    }
  }

  //Handling Scroll

  final ScrollController scrollController = ScrollController();
  int currentPage = 0;
  get getCurrentPage => currentPage;

  setSetCurrentPage(currentPage) {
    this.currentPage = currentPage;
    notifyListeners();
  }
}
