import 'package:flutter/material.dart';
import '../../constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'main_text.dart';

class DropMenu extends StatelessWidget {
  final List<String>? items;
  final Function(String?)? onChanged;
  final String? Function(String?)? valid;
  final String hint;
  final double? width;
  final bool shouldBeEmpty;
  final bool hasHeader;
  final Color? borderColor;
  final double? radius;
  final String? header;
  final Color? headerTextColor;
  final Function()? onTap;
  final dynamic value;
  final bool isModel;
  final prefixIcon;
  final Color? dropDownColor;

  DropMenu(
      {this.value,
      required this.hint,
      this.shouldBeEmpty = false,
      this.valid,
      this.header,
      this.width,
      this.hasHeader = false,
      this.dropDownColor,
      this.items,
      this.radius,
      this.borderColor,
      this.prefixIcon,
      this.onChanged,
      this.headerTextColor,
      this.onTap,
      this.isModel = false});

  @override
  build(BuildContext context) {
    return Container(
      width: width ?? 300.w,
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 0),
          prefixIcon: prefixIcon != null
              ? Padding(
                  padding: EdgeInsets.only(left: 8.w),
                  child: IconButton(
                    icon: prefixIcon!,
                    onPressed: () {},
                  ),
                )
              : null,
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: borderColor ?? Colors.transparent,
              width: 0.0,
            ),
            borderRadius: BorderRadius.circular(radius ?? 50.r),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: borderColor ?? Colors.transparent,
              width: 0.0,
            ),
            borderRadius: BorderRadius.circular(radius ?? 50.r),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: borderColor ?? Colors.transparent,
              width: 0.0,
            ),
            borderRadius: BorderRadius.circular(radius ?? 50.r),
          ),
          filled: true,
          fillColor: Color(0xff184343),
        ),
        selectedItemBuilder: (BuildContext ctx) => items!
            .map(
              (e) => Text(
                e,
                style: TextStyle(
                  fontSize: 16.sp,
                  color: kSecondaryColor,
                  fontWeight: FontWeight.w400,
                ),
              ),
            )
            .toList(),
        dropdownColor: dropDownColor ?? Color(0xff184343),
        validator: valid,
        value: value,
        icon: Icon(
          Icons.keyboard_arrow_down,
          color: kSecondaryColor,
        ),
        hint: Text(
          value == null
              ? hint
              : isModel
                  ? value.name
                  : value,
          style: TextStyle(
            fontSize: 14.sp,
            color: kSecondaryColor,
          ),
        ),
        iconEnabledColor: kAccentColor,
        isExpanded: true,
        items: items == null || items!.isEmpty || shouldBeEmpty
            ? []
            : items!
                .map((e) => DropdownMenuItem<String>(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          e,
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: kSecondaryColor,
                          ),
                        ),
                      ),
                      value: items![items!.indexOf(e)],
                    ))
                .toList(),
        onChanged: onChanged,
      ),
    );
  }
}
