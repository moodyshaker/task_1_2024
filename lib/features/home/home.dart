import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:task/constants.dart';
import 'package:task/core/networkStatus/network_status.dart';
import 'package:task/core/notifications/firebase.dart';
import 'package:task/core/provider/auth_provider.dart';
import 'package:task/core/provider/home_provider.dart';
import 'package:task/widgets/customScaffold.dart';
import 'package:task/widgets/loading_widget.dart';
import 'package:task/widgets/main_text.dart';
import 'package:task/widgets/retry_widget.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
    HomeProvider.listenFalse(context).getUsers();
  }

  @override
  Widget build(BuildContext context) {
    final auth = AuthProvider.get(context);
    final home = HomeProvider.get(context);
    return CustomScaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
        child: AnimationConfiguration.synchronized(
          duration: const Duration(milliseconds: 375),
          child: SlideAnimation(
            verticalOffset: 50.h,
            child: FadeInAnimation(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: MainText(
                          text:
                              'Welcome, ${firebaseAuth.currentUser!.displayName}',
                          color: kBlackColor,
                          font: 16.sp,
                        ),
                      ),
                      InkWell(
                        onTap: () async {
                          await auth.logout();
                        },
                        child: Icon(
                          Icons.logout,
                          color: kMainColor,
                        ),
                      ),
                    ],
                  ),
                  20.h.hSpace,
                  Expanded(
                      child: home.usersStatus == NetworkStatus.loading
                          ? LoadingWidget()
                          : home.usersStatus == NetworkStatus.success
                              ? ListView.separated(
                                  itemBuilder: (context, i) => Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10.w, vertical: 10.h),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20.r),
                                            color: kAccentColor,
                                            border:
                                                Border.all(color: kUnselectedColor)),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            MainText(
                                              text: home.usersModel![i].name,
                                              color: kBlackColor,
                                              font: 20.sp,
                                            ),
                                            5.h.hSpace,
                                            MainText(
                                              text: home.usersModel![i].email,
                                              color: kUnselectedColor,
                                              font: 16.sp,
                                            ),
                                            5.h.hSpace,
                                            MainText(
                                              text: home.usersModel![i].address!
                                                  .street,
                                              color: kUnselectedColor,
                                              font: 16.sp,
                                            )
                                          ],
                                        ),
                                      ),
                                  separatorBuilder: (context, i) => 10.h.hSpace,
                                  itemCount: home.usersModel!.length)
                              : RetryWidget(retryCallback: () {
                                  home.getUsers();
                                }))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
