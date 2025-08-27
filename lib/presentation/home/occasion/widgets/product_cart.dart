import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../domain/entities/product_card/product_card_entity.dart';
import '../../../../utils/common_widgets/custom_elevated_button.dart';

class ProductCard extends StatelessWidget {
  final ProductCardEntity product;
  const ProductCard({required this.product});

  @override
  Widget build(BuildContext context) {
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
              CustomElevatedButton(child: Icon(Icons.shopping_cart,),onPressed: (){}, buttonTitle:'add to cart',width: 147,height: 40,)
            ],
          ),
        ),)
    );
  }
}