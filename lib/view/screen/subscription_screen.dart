import 'package:cached_network_image/cached_network_image.dart';
import 'package:copartner_assignment_app/constant/app_constant.dart';
import 'package:copartner_assignment_app/constant/app_image.dart';
import 'package:copartner_assignment_app/constant/app_string.dart';
import 'package:copartner_assignment_app/constant/app_text_style.dart';
import 'package:copartner_assignment_app/constant/screen_util.dart';
import 'package:copartner_assignment_app/view/widget/chip_widget.dart';
import 'package:copartner_assignment_app/view/widget/container_decoration.dart';
import 'package:copartner_assignment_app/view/widget/detail_container.dart';
import 'package:copartner_assignment_app/view_model/home_screen_view_mode.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SubscriptionScreen extends StatefulWidget {
  const SubscriptionScreen({super.key});

  @override
  State<SubscriptionScreen> createState() => _SubscriptionScreenState();
}

class _SubscriptionScreenState extends State<SubscriptionScreen> {
  late SubscriptionViewModel subscriptionProvider;
  @override
  void initState() {
    subscriptionProvider =
        Provider.of<SubscriptionViewModel>(context, listen: false);
    subscriptionProvider.getSubscription(context).then((value) {
      subscriptionProvider
          .filterData(subscriptionProvider.selectedServiceTypeId);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomDecoratedContainer(
          width: ScreenSize.screenWidthPercentage(context, 1),
          height: ScreenSize.screenHeightPercentage(context, 1),
          gradient: const LinearGradient(
              colors: AppColors.gradientBackgroundColor,
              begin: Alignment.topRight,
              end: Alignment.bottomLeft),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(
                  left: AppPadding.medium, right: AppPadding.medium),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppSpacing.vertical(10),
                  _buildAppBarSection(),
                  AppSpacing.verticalMedium,
                  _buildTabSection(),
                  AppSpacing.verticalMedium,
                  _buildSubscriptionSection(),
                ],
              ),
            ),
          )),
    );
  }

  _buildAppBarSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            const Text(AppString.dummyUserNameText,
                style: AppTextStyles.heading3),
            AppSpacing.horizontalMedium,
            const Text(AppString.grettingText, style: AppTextStyles.subheading),
            AppSpacing.horizontalExtraSmall,
            Image.asset(AppImages.hiHand,
                width: AppIconSize.small, height: AppIconSize.small),
          ],
        ),
        Row(
          children: [
            const Icon(
              Icons.search,
              color: AppColors.white,
            ),
            AppSpacing.horizontalMedium,
            const Icon(
              Icons.notifications,
              color: AppColors.white,
            ),
            AppSpacing.horizontalMedium,
            Container(
              width: AppBorderRadius.circleAvatarRadiusSmall,
              height: AppBorderRadius.circleAvatarRadiusSmall,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.white,
                image: DecorationImage(
                  image: AssetImage(AppImages.userImage),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
        )
      ],
    );
  }

  _buildTabSection() {
    return Consumer<SubscriptionViewModel>(
      builder: (context, value, child) => SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: value.serviceType.map((item) {
              return TabChipWidget(
                serviceType: item['name'],
                serviceTypeId: item['id'],
                isSelected: value.selectedServiceTypeId == item['id'],
                onSelected: (selected) {
                  subscriptionProvider.handleSelectedServices(selected);
                },
              );
            }).toList(),
          )),
    );
  }

  _buildSubscriptionSection() {
    return Consumer<SubscriptionViewModel>(
      builder: (context, value, child) => value.isLoading
          ? const Center(
              child: CircularProgressIndicator(
                color: AppColors.white,
              ),
            )
          : Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    AppString.subscriptionText,
                    style: AppTextStyles.heading3,
                  ),
                  AppSpacing.verticalSmall,
                  Expanded(
                    child: ListView.builder(
                        itemCount: value.uniqueExpert.length,
                        itemBuilder: (context, index) {
                          return CustomDecoratedContainer(
                            margin:
                                const EdgeInsets.all(AppMargin.veryExtraSmall),
                            padding: const EdgeInsets.all(AppPadding.small),
                            borderRadius: BorderRadius.circular(15),
                            color: AppColors.expertCard.withOpacity(0.8),
                            width: ScreenSize.screenWidth(context),
                            height: ScreenSize.screenHeightPercentage(
                                context, 0.272),
                            child: Column(
                              children: [
                                _buildCardTopSection(index, value.uniqueExpert),
                                AppSpacing.verticalExtraSmall,
                                PlanList(planTypeData: value.filteredPlan)
                              ],
                            ),
                          );
                        }),
                  ),
                  AppSpacing.verticalMedium
                ],
              ),
            ),
    );
  }

  _buildCardTopSection(int index, List expertData) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Consumer<SubscriptionViewModel>(
              builder: (context, value, child) => Container(
                margin: const EdgeInsets.only(top: AppMargin.veryExtraSmall),
                width: AppBorderRadius.circleAvatarRadius,
                height: AppBorderRadius.circleAvatarRadius,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.white,
                ),
                child: CachedNetworkImage(
                  imageUrl: value.uniqueExpert[index]['expertImagePath'],
                  imageBuilder: (context, imageProvider) => Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  placeholder: (context, url) => const Center(
                      child: CircularProgressIndicator(strokeWidth: 2)),
                  errorWidget: (context, url, error) => const Center(
                    child: Text(AppString.errorLoadingImageText),
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            AppSpacing.horizontalSmall,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(expertData[index]['channelName'],
                    style: AppTextStyles.heading4),
                AppSpacing.verticalExtraSmall,
                Text(expertData[index]['name'], style: AppTextStyles.caption)
              ],
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(top: AppPadding.small),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(AppImages.blueTick,
                  width: AppIconSize.small, height: AppIconSize.small),
              AppSpacing.horizontalExtraSmall,
              const Text(AppString.sebiText, style: AppTextStyles.bodyText)
            ],
          ),
        )
      ],
    );
  }
}
