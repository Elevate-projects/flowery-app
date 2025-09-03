
import 'dart:developer';


import 'package:flutter/material.dart';
import '../../utils/common_widgets/custom_back_arrow.dart';
import '../../utils/common_widgets/custom_cart_details.dart';
import '../../utils/flowery_method_helper.dart';
class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    log(
      'userData: ${FloweryMethodHelper.currentUserToken}',
    );
    log(
      'userinfo: ${FloweryMethodHelper.userData}',
    );
    return  Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        leading: CustomBackArrow(),
        title: const Text('Cart'),
      ),
      body: Column(
        children: [
          const Row(
            children: [
              Icon(Icons.location_on_outlined),
              Text('Delivery to', style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.grey,
              ),),
              SizedBox(width: 10),
              Text('2XVP+XC - Sheikh Zayed.....', style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),),
              SizedBox(width: 10),
              ImageIcon(
                AssetImage('assets/icons/arrow-right.png'),
                color: Colors.black45,
                size: 28,
              )
            ],
          ),
          const SizedBox(height: 10),
          CustomCartDetails(),
        ],
      ),
    );
  }
}
// to do in that branch
// Edit in CustomBackArrow in color
// id return 3 dentifrice categories