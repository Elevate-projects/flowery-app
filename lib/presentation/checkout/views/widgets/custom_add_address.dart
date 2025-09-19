import 'package:flowery_app/domain/entities/address/address_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class CustomAddAddress extends StatelessWidget {
  final int index;
  final bool isSelected;
  final VoidCallback onSelect;
  final AddressEntity address;

  const CustomAddAddress({
    super.key,
    required this.address,
    required this.index,
    required this.isSelected,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: REdgeInsets.symmetric(horizontal: 10, vertical: 6),
      child: Container(
        height: 83,
        width: 343,
        decoration: BoxDecoration(
          border: Border.all(
            color: theme.colorScheme.shadow,
          ),
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const RSizedBox(height: 10),
            RadioGroup(
              groupValue: isSelected ? index : null,
              onChanged: (int? value) {
                onSelect();
              },
              child:   Row(
                children: [
                  const RSizedBox(width: 10),
                  Radio(
                    value: index,
                  ),
                   Text(address.city?? ""),
                  const Spacer(),
                  InkWell(
                    onTap: () {},
                    child: const Padding(
                      padding: EdgeInsets.only(right: 20, left: 10),
                      child: Icon(Icons.edit),
                    ),
                  )
                ],
              ),
            ),

            const RSizedBox(height: 5),
            Row(
              children: [
                Padding(
                  padding: REdgeInsets.only(left: 10),
                  child: Text(
                    address.street ?? "",
                    style: theme.textTheme.bodyMedium,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
