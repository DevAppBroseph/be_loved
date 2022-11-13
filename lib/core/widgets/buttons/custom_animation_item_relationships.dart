import 'dart:async';
import 'dart:math';
import 'package:be_loved/constants/colors/color_styles.dart';
import 'package:be_loved/core/utils/helpers/events.dart';
import 'package:be_loved/core/utils/images.dart';
import 'package:cupertino_rounded_corners/cupertino_rounded_corners.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomAnimationItemRelationships extends StatefulWidget {
  final Function(int) delete;
  final int index;
  final Events events;
  const CustomAnimationItemRelationships({
    Key? key,
    required this.delete,
    required this.index,
    required this.events,
  }) : super(key: key);

  @override
  State<CustomAnimationItemRelationships> createState() =>
      _CustomAnimationItemRelationshipsState();
}

enum DirectionAnimation { left, right }

class _CustomAnimationItemRelationshipsState
    extends State<CustomAnimationItemRelationships>
    with TickerProviderStateMixin {
  final streamController = StreamController<bool>();
  ScrollController scrollController = ScrollController();

  double rotate = pi / 4;

  TextStyle style = const TextStyle(
      fontWeight: FontWeight.w700, fontSize: 12, color: ColorStyles.greyColor);

  @override
  void initState() {
    super.initState();

    streamController.add(true);
  }

  double pos = 0;

  late DirectionAnimation directionAnimation;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
      stream: streamController.stream,
      initialData: false,
      builder: (context, snapshot) {
        return GestureDetector(
          onHorizontalDragStart: (details) {
            pos = details.localPosition.dx;
          },
          onHorizontalDragUpdate: (details) {
            if (pos > details.localPosition.dx) {
              directionAnimation = DirectionAnimation.left;
              if (scrollController.offset < 55.w) {
                scrollController.jumpTo(scrollController.offset + 3);
              }
            } else {
              directionAnimation = DirectionAnimation.right;
              if (scrollController.offset > 0) {
                scrollController.jumpTo(scrollController.offset - 3);
              }
            }
            pos = details.localPosition.dx;
          },
          onHorizontalDragEnd: (details) {
            if (directionAnimation == DirectionAnimation.right) {
              scrollController.animateTo(
                0,
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeInOutQuint,
              );
            } else {
              scrollController.animateTo(
                55.w,
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeInOutQuint,
              );
            }
          },
          child: AnimatedOpacity(
            duration: const Duration(milliseconds: 1000),
            opacity: snapshot.data! ? 1 : 0,
            curve: Curves.easeInOutQuint,
            child: AnimatedContainer(
              curve: Curves.easeInOutQuint,
              duration: const Duration(milliseconds: 1000),
              height: snapshot.data! ? 155.h : 0.h,
              width: 378.w,
              // decoration: BoxDecoration(
              //   borderRadius: BorderRadius.circular(20.r),
              // ),
              // clipBehavior: Clip.hardEdge,
              child: Padding(
                padding: EdgeInsets.only(bottom: 15.h),
                child: AnimatedContainer(
                  curve: Curves.easeInOutQuint,
                  duration: const Duration(milliseconds: 1000),
                  height: snapshot.data! ? 155.h : 0.h,
                  width: 378.w,
                  // decoration: BoxDecoration(
                  //   borderRadius: BorderRadius.circular(20.r),
                  //   color: Colors.white,
                  // ),
                  // clipBehavior: Clip.hardEdge,
                  child: CupertinoCard(
                    radius: BorderRadius.circular(40.r),
                    color: Colors.white,
                    elevation: 0,
                    margin: EdgeInsets.zero,
                    child: SingleChildScrollView(
                      controller: scrollController,
                      physics: const NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      child: Stack(
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SingleChildScrollView(
                                physics: NeverScrollableScrollPhysics(),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 11.h, horizontal: 20.w),
                                  child: SizedBox(
                                    width: 338.w,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              'Предстоящее событие',
                                              style: TextStyle(
                                                color: ColorStyles.greyColor,
                                                fontSize: 15.sp,
                                                fontWeight: FontWeight.w700,
                                                height: 1,
                                              ),
                                            ),
                                            const Spacer(),
                                            Text(
                                              'Через ${widget.events.datetime} ${checkDays()}',
                                              style: TextStyle(
                                                color: const Color.fromRGBO(
                                                    128, 74, 142, 1),
                                                fontSize: 15.sp,
                                                fontWeight: FontWeight.w800,
                                                height: 1,
                                              ),
                                            ),
                                          ],
                                        ),
                                        AnimatedContainer(
                                          curve: Curves.easeInOutQuint,
                                          duration: const Duration(
                                              milliseconds: 1000),
                                          height: snapshot.data! ? 19.h : 0.h,
                                        ),
                                        Text(
                                          widget.events.name,
                                          style: TextStyle(
                                              color: const Color.fromRGBO(
                                                  23, 23, 23, 1),
                                              fontSize: 50.sp,
                                              fontWeight: FontWeight.w800,
                                              height: 1),
                                        ),
                                        AnimatedContainer(
                                          curve: Curves.easeInOutQuint,
                                          duration: const Duration(
                                              milliseconds: 1000),
                                          height: snapshot.data! ? 9.h : 0.h,
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              'Завтра:',
                                              style: TextStyle(
                                                  color: ColorStyles.greyColor,
                                                  fontSize: 15.sp,
                                                  fontWeight: FontWeight.w700,
                                                  height: 1),
                                            ),
                                            SizedBox(width: 10.w),
                                            Text(
                                              widget.events.description,
                                              style: TextStyle(
                                                  color: ColorStyles.greyColor,
                                                  fontSize: 15.sp,
                                                  fontWeight: FontWeight.w700),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              SingleChildScrollView(
                                physics: NeverScrollableScrollPhysics(),
                                child: Column(
                                  children: [
                                    Container(
                                      height: 70.h,
                                      width: 55.w,
                                      color: ColorStyles.greyColor2,
                                      child: Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          SvgPicture.asset(SvgImg.setting),
                                        ],
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        streamController.add(false);
                                        scrollController.animateTo(0,
                                            duration: const Duration(
                                                milliseconds: 1000),
                                            curve: Curves.easeInOutQuint);
                                        Future.delayed(
                                                Duration(milliseconds: 1000))
                                            .then((value) {
                                          // widget.delete(widget.index);
                                        });
                                      },
                                      child: Container(
                                        height: 70.h,
                                        width: 55.w,
                                        color: ColorStyles.redColor,
                                        child: Stack(
                                          alignment: Alignment.center,
                                          children: [
                                            SvgPicture.asset(SvgImg.trash),
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  String checkDays() {
    int days = int.parse(widget.events.datetime);
    int lastNumber = int.parse(widget.events.datetime[widget.events.datetime.length - 1]);
    if(lastNumber > 5 && lastNumber < 10) return 'дней';
    if(days % 5 == 0) return 'дней';
    if(days == 11) return 'дней';
    if(lastNumber == 1) return 'день';
    return 'дня';
  }

  // void closeOpen(bool state) {
  // if (!_controllerAnimationRotate!.isAnimating) {
  //   if (_controllerAnimationRotate!.isCompleted) {
  //     _controllerAnimationRotate!.reverse();
  //   } else {
  //     _controllerAnimationRotate!.forward(from: rotate);
  //   }
  //   streamController.add(!state);
  // }

  //   if (_controllerAnimationRow!.isCompleted) {
  //     _controllerAnimationRow!.reverse();
  //   } else {
  //     _controllerAnimationRow!.forward(from: 0.0);
  //   }
  // }
}
