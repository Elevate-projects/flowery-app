import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_app/core/constants/app_icons.dart';
import 'package:flowery_app/core/constants/app_images.dart';
import 'package:flowery_app/core/constants/app_text.dart';
import 'package:flowery_app/presentation/track_order/widget/map_view.dart';
import 'package:flowery_app/utils/common_widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class TrackOrderPage extends StatelessWidget {
  const TrackOrderPage({super.key});
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const MapToView(
                destinationLat: 30.0444,
                destinationLon: 31.2357,
              ),
               const RSizedBox(height: 15),
              Padding(
                padding:  REdgeInsets.symmetric(horizontal: 14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppText.estimatedArrival.tr(),
                      style:  theme.textTheme.bodyLarge?.copyWith(
                        color: theme.colorScheme.shadow,
                      ),
                    ),
                    Text(
                      AppText.time,
                      style: theme.textTheme.labelLarge?.copyWith(
                        color: theme.colorScheme.onSecondary,
                      ),
                    ),
                    const Divider(
                      color: Colors.grey,
                      thickness: 1,
                      indent: 0,
                      endIndent: 0,
                    ),
                    const RSizedBox(height: 40,),
                    Padding(
                        padding: REdgeInsets.symmetric(horizontal: 14),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                             const Image(image: AssetImage(
                              AppImages.defaultProfile,
                            ),
                              width: 30,
                              height: 30,
                            ),
                            const SizedBox(width: 16),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Muhammed",
                                ),
                                const RSizedBox(height: 4),
                                Row(
                                  children: [
                                    const Text(
                                      "its your delivery hero for today",

                                    ),
                                    const RSizedBox(width: 20),
                                    const Icon(
                                      Icons.phone_outlined,
                                      color: Colors.pink,
                                    ),
                                    const RSizedBox(width: 20),
                                    Image.asset(
                                      AppIcons.whatsApp,
                                      width: 24,
                                      height: 24,
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ],
                        )
                    ),
                    const RSizedBox(height: 40,),
                    CustomElevatedButton(
                        onPressed: () {
                      Navigator.pop(context);
                    }, buttonTitle: AppText.orderDetails.tr(),
                    )
                  ]
                ),
              ),
              const RSizedBox(height: 10,)
            ],
          ),
        ),
      ),
    );
  }
}
