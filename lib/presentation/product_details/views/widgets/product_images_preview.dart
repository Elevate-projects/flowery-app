import 'package:cached_network_image/cached_network_image.dart';
import 'package:flowery_app/core/constants/app_colors.dart';
import 'package:flowery_app/presentation/product_details/views_model/product_details_cubit.dart';
import 'package:flowery_app/presentation/product_details/views_model/product_details_intent.dart';
import 'package:flowery_app/presentation/product_details/views_model/product_details_state.dart';
import 'package:flowery_app/utils/common_widgets/custom_back_arrow.dart';
import 'package:flowery_app/utils/common_widgets/shimmer_effect.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ProductImagesPreview extends StatelessWidget {
  const ProductImagesPreview({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final productDetailsCubit = BlocProvider.of<ProductDetailsCubit>(context);
    return Container(
      alignment: Alignment.center,
      height: 448.h,
      width: ScreenUtil().screenWidth,
      color: theme.colorScheme.onPrimary,
      child: RPadding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
          builder: (context, state) => Visibility(
            visible: state.productImages != null,
            child: SafeArea(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  RSizedBox(
                    height: 398.h,
                    child: PageView(
                      physics: const BouncingScrollPhysics(),
                      controller: productDetailsCubit.imagesPageController,
                      children: state.productImages!
                          .map(
                            (image) => Center(
                              child: CachedNetworkImage(
                                imageUrl: image,
                                fit: BoxFit.cover,
                                width: ScreenUtil().screenWidth,
                                height: 398.h,
                                progressIndicatorBuilder:
                                    (context, url, progress) => ShimmerEffect(
                                      width: ScreenUtil().screenWidth,
                                      height: 398.h,
                                      radius: 0,
                                    ),
                                errorWidget: (context, url, error) => Icon(
                                  Icons.info_outline,
                                  color: theme.colorScheme.error,
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                  PositionedDirectional(
                    top: 30.r,
                    start: 6.w,
                    child: const CustomBackArrow(),
                  ),
                  PositionedDirectional(
                    bottom: 8.h,
                    child: SmoothPageIndicator(
                      controller: productDetailsCubit.imagesPageController,
                      count: state.productImages!.length,
                      effect: SwapEffect(
                        activeDotColor: theme.colorScheme.primary,
                        dotColor: AppColors.white[70]!,
                        dotWidth: 10.r,
                        dotHeight: 10.r,
                        spacing: 8.r,
                      ),
                      onDotClicked: (index) => productDetailsCubit.doIntent(
                        intent: NavigateToSelectedImageIntent(
                          selectedImageIndex: index,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
