import 'package:be_loved/core/helpers/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ArchivePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(color: backgroundColorGrey),
        content(),
      ],
    );
  }

  Widget content() {
    TextStyle style3 = TextStyle(
        color: greyColor, fontWeight: FontWeight.w700, fontSize: 15.sp);

    TextStyle style4 = TextStyle(fontWeight: FontWeight.w700, fontSize: 25.sp);

    return Stack(
      children: [
        SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 38.h, left: 25.w, right: 25.w),
                child: Row(
                  children: [
                    SizedBox(
                      width: 45.w,
                      height: 45.h,
                      child: const Icon(Icons.more_horiz),
                    ),
                    const Spacer(),
                    SizedBox(
                      width: 45.w,
                      height: 45.h,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          SvgPicture.asset('assets/icons/add_new_event.svg'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 11.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 82.w),
                child: Column(
                  children: [
                    Text('Общий архив', style: style4),
                    SizedBox(height: 9.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text('Главная',
                            style: style3.copyWith(color: redColor)),
                        Text('События', style: style3),
                        Text('Моменты', style: style3),
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(height: 38.h),
              ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: ((context, index) {
                    if (index % 5 == 0) {
                      return Padding(
                        padding: EdgeInsets.only(bottom: 4.h),
                        child: Container(
                          height: 284.h,
                          color: greyColor2,
                        ),
                      );
                    } else {
                      return Padding(
                        padding: EdgeInsets.only(bottom: 4.h),
                        child: Row(
                          children: [
                            Container(
                              height: 140.h,
                              width: 140.w,
                              color: greyColor2,
                            ),
                            SizedBox(width: 4.w),
                            Container(
                              height: 140.h,
                              width: 140.w,
                              color: greyColor2,
                            ),
                            SizedBox(width: 4.w),
                            Container(
                              height: 140.h,
                              width: 140.w,
                              color: greyColor2,
                            ),
                          ],
                        ),
                      );
                    }
                  }),
                  itemCount: 20),
              SizedBox(height: 117.h),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(bottom: 161.h),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 40.h,
              margin: EdgeInsets.symmetric(horizontal: 45.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15.r),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text('Дни', style: style3),
                  Text('Месяца', style: style3),
                  Text('Годы', style: style3),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
