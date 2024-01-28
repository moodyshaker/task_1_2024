import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../constants.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String title;
  final String? family;
  final Color? color;
  final double? verticalMargin;
  final double? horizontalMargin;
  final FontWeight? weight;
  final bool isTransparent;
  final bool withBorder;
  final Color? borderColor;
  final Color? textColor;
  final Color? imageColor;
  final double? width;
  final double? height;
  final double? borderWidth;
  final double? font;
  final double? radius;
  final bool withIcon;
  final String? iconPath;

  CustomButton(
      {this.onPressed,
      required this.title,
      this.color,
      this.radius,
      this.iconPath,
      this.width,
      this.withBorder = false,
      this.verticalMargin,
      this.borderWidth,
      this.withIcon = false,
      this.horizontalMargin,
      this.family,
      this.weight,
      this.borderColor,
      this.isTransparent = false,
      this.height,
      this.font,
      this.textColor,
      this.imageColor});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        margin: EdgeInsets.symmetric(
            horizontal: horizontalMargin ?? 0.w,
            vertical: verticalMargin ?? 0.h),
        height: height ?? 58.h,
        width: width ?? 339.w,
        decoration: BoxDecoration(
          color: isTransparent ? Colors.transparent : color ?? kMainColor,
          borderRadius: BorderRadius.circular(radius ?? 30.r),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: TextStyle(
                  color: textColor ?? kAccentColor,
                  fontSize: font ?? 20.sp,
                  fontFamily: family,
                  fontWeight: weight ?? FontWeight.w500),
            ),
            if (withIcon)
              SizedBox(
                width: 12.w,
              ),
            if (withIcon)
              Image.asset(
                getAsset(iconPath!),
                height: 16.h,
                width: 16.h,
              ),
          ],
        ),
      ),
    );
  }
}
