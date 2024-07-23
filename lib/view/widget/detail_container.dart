import 'package:copartner_assignment_app/constant/app_constant.dart';
import 'package:copartner_assignment_app/constant/app_text_style.dart';
import 'package:copartner_assignment_app/constant/screen_util.dart';
import 'package:copartner_assignment_app/view/widget/container_decoration.dart';
import 'package:copartner_assignment_app/view_model/home_screen_view_mode.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PlanList extends StatefulWidget {
  List planTypeData;
  PlanList({super.key, required this.planTypeData});

  @override
  State<PlanList> createState() => _PlanListState();
}

class _PlanListState extends State<PlanList> {
  late SubscriptionViewModel subcriptionProvider;
  @override
  void initState() {
    super.initState();
    subcriptionProvider =
        Provider.of<SubscriptionViewModel>(context, listen: false);
    subcriptionProvider.scrollController.addListener(() {
      setState(() {
        subcriptionProvider.setSetCurrentPage(
            (subcriptionProvider.scrollController.offset /
                    (MediaQuery.of(context).size.width * 0.6))
                .round());
      });
    });
  }

  buildData(BuildContext context, int index) {
    final planData = widget.planTypeData[index];
    return CustomDecoratedContainer(
        borderRadius: BorderRadius.circular(12),
        margin: const EdgeInsets.all(AppMargin.small),
        padding: const EdgeInsets.all(AppPadding.small),
        color: AppColors.planCard,
        width: ScreenSize.screenWidthPercentage(context, 0.7),
        borderColor: AppColors.grey.withOpacity(0.1),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(planData['planType'], style: AppTextStyles.heading5),
                const Text("10:00 AM", style: AppTextStyles.bodyText)
              ],
            ),
            AppSpacing.verticalMedium,
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Text("Amount : ", style: AppTextStyles.caption),
                CustomDecoratedContainer(
                  borderRadius: BorderRadius.circular(7),
                  color: AppColors.amountCard,
                  padding: const EdgeInsets.all(AppPadding.extrasmall),
                  child: Text(planData['amount'].toString(),
                      style: AppTextStyles.bodyText2),
                )
              ],
            ),
            AppSpacing.verticalMedium,
            RichText(
              text: TextSpan(
                style: DefaultTextStyle.of(context).style.copyWith(
                      fontSize: 16.0,
                      color: Colors.black,
                    ),
                children: [
                  const TextSpan(
                      text: 'Duration : ', style: AppTextStyles.caption),
                  TextSpan(
                      text: '${planData['durationMonth'].toString()} months',
                      style: AppTextStyles.heading5),
                  const TextSpan(
                      text: '    Discount : ', style: AppTextStyles.caption),
                  TextSpan(
                      text: planData['discountPercentage'].toString() == "null"
                          ? "0%"
                          : planData['discountPercentage'].toString(),
                      style: AppTextStyles.heading5),
                ],
              ),
            ),
          ],
        ));
  }

  _dotIndicator({required int itemCount, required int currentPage}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(itemCount, (index) {
        return Padding(
          padding: const EdgeInsets.all(3.0),
          child: Container(
            width: (currentPage == index)
                ? AppIconSize.medium
                : AppIconSize.extrasmall,
            height: 5,
            decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(3),
                color:
                    (currentPage == index) ? AppColors.white : AppColors.grey),
          ),
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.165,
          child: ListView.builder(
            controller: subcriptionProvider.scrollController,
            scrollDirection: Axis.horizontal,
            itemCount: widget.planTypeData.length,
            itemBuilder: (context, index) {
              return buildData(context, index);
            },
          ),
        ),
        AppSpacing.verticalSmall,
        _dotIndicator(
            itemCount: widget.planTypeData.length,
            currentPage: subcriptionProvider.currentPage)
      ],
    );
  }
}
