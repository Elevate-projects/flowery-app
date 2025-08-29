import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/constants/app_icons.dart';
import '../../../../core/constants/app_text.dart';
import '../../../../domain/entities/product_card/product_card_entity.dart';
import '../../../../utils/common_widgets/custom_elevated_button.dart';

class ProductCard extends StatelessWidget {
  final ProductCardEntity product;
  const ProductCard({required this.product});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
        child: SizedBox(height: 230.h,child: Padding(
          padding:   EdgeInsets.all(10.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,

            children: [
              Image.network(product.imgCover??"", fit: BoxFit.fill, height: 126),
              SizedBox(height: 10.h,),

              Text(product.title??"", style: const TextStyle(fontWeight: FontWeight.bold),),
              SizedBox(height: 3.h,),

              Row(mainAxisAlignment: MainAxisAlignment.start,
                children: [Text("EGP ${product.priceAfterDiscount}", maxLines: 2, overflow: TextOverflow.ellipsis),
                  SizedBox(width: 10.w,),
                  Text(product.price.toString(), style: TextStyle(decoration: TextDecoration.lineThrough),),
                  SizedBox(width: 5.w,),

                  Text('20%'),



                ],),Spacer(),
          CustomElevatedButton(
            onPressed: () {},
            buttonTitle: AppText.addToCart,
            height: 30.h,
            isText: false,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(AppIcons.cart, fit: BoxFit.scaleDown),
                const RSizedBox(width: 8),
                Text(
                  AppText.addToCart,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w500,
                    color: theme.colorScheme.secondary,
                  ),
                ),
              ],
            ),
          )
            ],
          ),
        ),)
    );
  }
}