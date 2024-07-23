import 'package:copartner_assignment_app/constant/app_constant.dart';
import 'package:flutter/material.dart';

class TabChipWidget extends StatelessWidget {
  final String serviceType;
  final String serviceTypeId;
  final bool isSelected;
  final void Function(Map<String, dynamic>) onSelected;

  const TabChipWidget({
    Key? key,
    required this.serviceType,
    required this.serviceTypeId,
    required this.isSelected,
    required this.onSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: ChoiceChip(
        clipBehavior: Clip.antiAlias,
        showCheckmark: false,
        label: Text(
          serviceType,
          style: TextStyle(
            color: isSelected ? Colors.white : AppColors.white,
          ),
        ),
        selected: isSelected,
        onSelected: (bool isSelected) {
          onSelected({'name': serviceType, 'id': serviceTypeId});
        },
        selectedColor: AppColors.blue,
        backgroundColor: isSelected ? AppColors.white : AppColors.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
          side: BorderSide(
            color: isSelected ? AppColors.blue : AppColors.white,
            width: 1.0,
          ),
        ),
        elevation: 0.0,
      ),
    );
  }
}
