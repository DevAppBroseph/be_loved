import 'dart:math';
import 'package:be_loved/core/helpers/constants.dart';
import 'package:be_loved/models/home/hashTag.dart';
import 'package:be_loved/models/home/upcoming_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EventsPage extends StatelessWidget {
  List<HashTagData> hashTags = [
    HashTagData(title: 'Важно', type: TypeHashTag.main),
    HashTagData(title: 'Арбуз', type: TypeHashTag.user),
    HashTagData(title: 'Название', type: TypeHashTag.custom),
    HashTagData(type: TypeHashTag.add),
  ];

  List<UpcomingInfo> upComingInfo = [
    UpcomingInfo(
      title: 'Годовщина',
      subTitle: 'Beloved :)',
      days: 'Завтра',
    ),
    UpcomingInfo(
      title: 'Арбузный вечер',
      subTitle: 'Добавил(а) Никита Белых',
      days: 'Через три дня',
    ),
    UpcomingInfo(
      title: 'Я роняю запад',
      subTitle: 'от Кремля',
      days: 'Через 7 дней',
    )
  ];

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
    TextStyle style1 = TextStyle(
        color: Colors.white, fontWeight: FontWeight.w800, fontSize: 15.sp);

    TextStyle style2 = TextStyle(
        color: Colors.black, fontWeight: FontWeight.w800, fontSize: 25.sp);

    TextStyle style3 = TextStyle(
        color: greyColor, fontWeight: FontWeight.w700, fontSize: 15.sp);

    TextStyle style4 = TextStyle(
        color: redColor, fontWeight: FontWeight.w800, fontSize: 25.sp);

    TextStyle style5 = TextStyle(
        color: accentColor, fontWeight: FontWeight.w800, fontSize: 15.sp);

    TextStyle style6 = TextStyle(
        color: Colors.black, fontWeight: FontWeight.w800, fontSize: 50.sp);

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 59.h, left: 15.w, right: 15.w),
            child: Row(
              children: [
                SizedBox(
                  width: 55.w,
                  height: 55.h,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      SvgPicture.asset('assets/icons/calendar.svg'),
                    ],
                  ),
                ),
                const Spacer(),
                SizedBox(
                  width: 55.w,
                  height: 55.h,
                  child: const Icon(Icons.more_horiz),
                )
              ],
            ),
          ),
          SizedBox(height: 37.h),
          SizedBox(
            height: 38.h,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.only(
                      left: index == 0 ? 25.w : 15.w,
                      right: index == hashTags.length - 1 ? 25.w : 0),
                  child: Builder(builder: (context) {
                    Color color;
                    switch (hashTags[index].type) {
                      case TypeHashTag.main:
                        color = redColor;
                        break;
                      case TypeHashTag.user:
                        color = accentColor;
                        break;
                      case TypeHashTag.custom:
                        color = blueColor;
                        break;
                      default:
                        color = Colors.transparent;
                    }

                    return Container(
                      decoration: BoxDecoration(
                        border: hashTags[index].type == TypeHashTag.add
                            ? Border.all(color: greyColor)
                            : null,
                        borderRadius: BorderRadius.circular(10.r),
                        color: color,
                      ),
                      padding: EdgeInsets.symmetric(
                          horizontal: 25.w, vertical: 10.h),
                      child: Center(
                          child: hashTags[index].type == TypeHashTag.add
                              ? SizedBox(
                                  height: 34.h,
                                  width: 34.w,
                                  child: Transform.rotate(
                                      angle: pi / 4,
                                      child: SvgPicture.asset(
                                          'assets/icons/add.svg')),
                                )
                              : Text('#${hashTags[index].title}',
                                  style: style1)),
                    );
                  }),
                );
              },
              itemCount: hashTags.length,
            ),
          ),
          SizedBox(height: 38.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 25.w),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.r),
                color: Colors.white,
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 11.h),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Сегодня', style: style4),
                        Text('Арбуз', style: style6),
                      ],
                    ),
                    const Spacer(),
                    Text('#Арбуз', style: style5)
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 38.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 25.w),
            child: Container(
              height: 1,
              color: greyColor,
            ),
          ),
          SizedBox(height: 38.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 25.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Предстоящие события', style: style2),
                SizedBox(height: 8.h),
                Text('1 событие', style: style3),
              ],
            ),
          ),
          SizedBox(height: 26.h),
          events(),
          SizedBox(height: 42.h),
          button(),
        ],
      ),
    );
  }

  Widget events() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 25.w),
      child: Column(children: upComingInfo.map((e) => itemEvent(e)).toList()),
    );
  }

  Widget itemEvent(UpcomingInfo info) {
    TextStyle style1 = TextStyle(
        color: Colors.black, fontWeight: FontWeight.w800, fontSize: 20.sp);
    TextStyle style2 = TextStyle(
        color: greyColor, fontWeight: FontWeight.w700, fontSize: 15.sp);

    TextStyle style3 = TextStyle(fontWeight: FontWeight.w800, fontSize: 15.sp);

    TextStyle style4 = TextStyle(
        color: redColor, fontWeight: FontWeight.w800, fontSize: 15.sp);

    return Padding(
      padding: EdgeInsets.only(bottom: 20.h),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(info.title, style: style1),
              info.subTitle.contains('Beloved')
                  ? RichText(
                      text: TextSpan(children: [
                        TextSpan(text: 'от ', style: style2),
                        TextSpan(text: info.subTitle, style: style4),
                      ]),
                    )
                  : RichText(
                      text: TextSpan(children: [
                        TextSpan(text: info.subTitle, style: style2),
                      ]),
                    )
            ],
          ),
          const Spacer(),
          Text(
            info.days,
            style: style3,
          )
        ],
      ),
    );
  }

  Widget button() {
    TextStyle style = TextStyle(
        color: greyColor, fontWeight: FontWeight.w800, fontSize: 20.sp);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 25.w),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            height: 55.h,
            decoration: BoxDecoration(
              border: Border.all(color: greyColor),
              borderRadius: BorderRadius.circular(20.r),
            ),
          ),
          Align(
              alignment: Alignment.center,
              child: Text('Новое событие', style: style)),
          Align(
            alignment: Alignment.centerRight,
            child: SizedBox(
              height: 55.h,
              width: 55.w,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 17.h),
                child: SvgPicture.asset(
                  'assets/icons/add_new_event.svg',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}