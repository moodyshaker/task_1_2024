import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../constants.dart';
import 'main_text.dart';

class RetryWidget extends StatelessWidget {
  final VoidCallback retryCallback;

  const RetryWidget({required this.retryCallback, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          MainText(
            text: 'An error has occurred please try again',
            font: 18.sp,
            weight: FontWeight.bold,
            color: kMainColor,
          ),
          SizedBox(height: 10.h),
          ElevatedButton(
            onPressed: retryCallback,
            style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(kMainColor)),
            child: MainText(
              text: 'Try Again',
              font: 16.sp,
              color: kAccentColor,
              weight: FontWeight.bold,
            ),
          )
        ],
      ),
    );
  }
}
