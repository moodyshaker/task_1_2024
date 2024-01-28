import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../constants.dart';
import 'main_text.dart';

class CustomTextField extends StatefulWidget {
  final String hint;
  final String? initialValue;
  final int? minLines;
  final String? headerText;
  final int? maxLines;
  final Color? hintColor;
  final int? maxLength;
  final bool nullMax;
  final TextInputType? type;
  final bool hasBorder;
  final List<TextInputFormatter>? inputFormatters;
  final Function(String?)? onsave;
  final Function()? suffixCallback;
  final Function(String?)? onChange;
  final Function()? iconCallback;
  final String? Function(String?)? valid;
  final AutovalidateMode? validationMode;
  final Widget? suffixIcon;
  final Color? fillColor;
  final Color? cursorColor;
  final Color? borderColor;
  final bool isPassword;
  final bool circularBorder;
  final double? radius;
  final FontWeight? hintWeight;
  final double? hintFont;
  final TextEditingController? controller;
  final VoidCallback? onTap;
  final String? prefix;
  final FocusNode? focus;
  final bool autoFocus;
  final bool? read;
  final bool withPasswordIcon;
  final bool isPhone;
  final bool? flag;
  final bool filled;
  final TextAlign? align;
  final TextInputAction? action;
  final VoidCallback? edit;
  final bool? isEdit;
  final double? hor;
  final double? horizontalPadding;
  final double? verticalPadding;

  CustomTextField({
    required this.hint,
    this.maxLines,
    this.filled = false,
    this.circularBorder = true,
    this.onsave,
    this.hintWeight,
    this.hintFont,
    this.onTap,
    this.borderColor,
    this.cursorColor,
    this.headerText,
    this.radius,
    this.minLines,
    this.hintColor,
    this.suffixCallback,
    this.hasBorder = true,
    this.withPasswordIcon = true,
    this.suffixIcon,
    this.type,
    this.initialValue,
    this.maxLength,
    this.nullMax = false,
    this.inputFormatters,
    this.fillColor,
    this.valid,
    this.action,
    this.align,
    this.onChange,
    this.isPassword = false,
    this.iconCallback,
    this.controller,
    this.isPhone = false,
    this.focus,
    this.autoFocus = false,
    this.prefix,
    this.read,
    this.edit,
    this.isEdit,
    this.flag,
    this.hor,
    this.validationMode,
    this.verticalPadding,
    this.horizontalPadding,
  });

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _isHidden = true;

  void _visibility() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.headerText != null)
          MainText(
            text: widget.headerText,
            font: 15.sp,
            color: kSecondaryColor,
          ),
        if (widget.headerText != null) 10.h.hSpace,
        TextFormField(
          onTap: widget.onTap,
          initialValue: widget.initialValue,
          validator: widget.valid,
          controller: widget.controller,
          cursorColor: widget.cursorColor ?? kBorderColor,
          onSaved: widget.onsave,
          focusNode: widget.focus,
          inputFormatters: widget.inputFormatters,
          textAlign: widget.align ?? TextAlign.start,
          textInputAction: widget.action,
          readOnly: widget.read == true ? true : false,
          maxLines:
              widget.nullMax ? null : widget.maxLines ?? widget.minLines ?? 1,
          minLines: widget.minLines,
          autofocus: widget.autoFocus,
          maxLength: widget.isPhone ? 11 : widget.maxLength,
          obscureText: widget.isPassword ? _isHidden : false,
          keyboardType: widget.type,
          onChanged: widget.onChange,
          style: TextStyle(
            fontSize: 16.sp,
            color: kBlackColor,
          ),
          decoration: InputDecoration(
            errorStyle: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
            ),
            hintText: widget.hint,
            fillColor: widget.fillColor ?? kAccentColor,
            filled: widget.circularBorder ? true : widget.filled,
            contentPadding: EdgeInsets.symmetric(
                horizontal: widget.horizontalPadding ?? 25.w,
                vertical: (widget.minLines != null && widget.minLines! > 1)
                    ? 20.h
                    : widget.verticalPadding ?? 15.h),
            prefixIcon: widget.prefix != null
                ? Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset(
                          getAsset(widget.prefix!),
                          height: 24.h,
                          width: 24.w,
                          color: kMainColor,
                        ),
                        10.w.wSpace,
                      ],
                    ),
                  )
                : null,
            prefix: widget.flag == true ? const MainText(text: "+966  ") : null,
            icon: widget.isEdit == true ? const Icon(Icons.edit) : null,
            counterText: '',
            hintStyle: TextStyle(
                fontSize: widget.hintFont ?? 14.sp,
                color: widget.hintColor ?? kBorderColor),
            suffixIcon: widget.isPassword
                ? Padding(
                    padding: EdgeInsets.only(right: 8.w),
                    child: IconButton(
                      onPressed: _visibility,
                      alignment: Alignment.center,
                      icon: _isHidden
                          ? const Icon(Icons.visibility_off,
                              color: kBorderColor)
                          : const Icon(Icons.visibility, color: kBorderColor),
                    ),
                  )
                : widget.suffixIcon,
            enabledBorder: widget.circularBorder
                ? OutlineInputBorder(
                    borderSide: widget.hasBorder
                        ? BorderSide(
                            color: widget.borderColor ?? kGreyColor,
                            width: 1.0,
                          )
                        : BorderSide.none,
                    borderRadius: BorderRadius.circular(widget.radius ?? 50.r),
                  )
                : UnderlineInputBorder(
                    borderSide: widget.hasBorder
                        ? BorderSide(
                            color: widget.borderColor ?? kAccentColor,
                            width: 1.0,
                          )
                        : BorderSide.none,
                    borderRadius: BorderRadius.circular(widget.radius ?? 10.r),
                  ),
            focusedBorder: widget.circularBorder
                ? OutlineInputBorder(
                    borderSide: widget.hasBorder
                        ? BorderSide(
                      color: widget.borderColor ?? kGreyColor,
                      width: 1.0,
                          )
                        : BorderSide.none,
                    borderRadius: BorderRadius.circular(widget.radius ?? 50.r),
                  )
                : UnderlineInputBorder(
                    borderSide: widget.hasBorder
                        ? BorderSide(
                            color: widget.borderColor ?? kAccentColor,
                            width: 1.0,
                          )
                        : BorderSide.none,
                    borderRadius: BorderRadius.circular(widget.radius ?? 10.r),
                  ),
            border: widget.circularBorder
                ? OutlineInputBorder(
                    borderSide: widget.hasBorder
                        ? BorderSide(
                      color: widget.borderColor ?? kGreyColor,
                      width: 1.0,
                          )
                        : BorderSide.none,
                    borderRadius: BorderRadius.circular(widget.radius ?? 50.r),
                  )
                : UnderlineInputBorder(
                    borderSide: widget.hasBorder
                        ? BorderSide(
                            color: widget.borderColor ?? kAccentColor,
                            width: 1.0,
                          )
                        : BorderSide.none,
                    borderRadius: BorderRadius.circular(widget.radius ?? 10.r),
                  ),
          ),
        ),
      ],
    );
  }
}
