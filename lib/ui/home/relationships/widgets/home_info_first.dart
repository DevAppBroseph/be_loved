import 'dart:async';
import 'package:be_loved/core/helpers/shared_prefs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class HomeInfoFirst extends StatefulWidget {
  @override
  State<HomeInfoFirst> createState() => _HomeInfoFirstState();
}

class _HomeInfoFirstState extends State<HomeInfoFirst> {
  int days = 0;
  int hour = 0;
  int minute = 0;
  Timer? _timer;

  final streamController = StreamController<bool>();

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    streamController.close();
    _timer!.cancel();
    super.dispose();
  }

  void startTimer() {
    var oneSec = const Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (DateTime.now().second == 0) {
          _timer!.cancel();
          Timer.periodic(const Duration(seconds: 60), (Timer timer) {
            setTime();
          });
        }
        setTime();
      },
    );
  }

  void setTime() async {
    MySharedPrefs date = MySharedPrefs();
    date.user.then((value) {
      final startTime = value.date as String;
      final array = startTime.split('-');

      DateTime berlinWallFell = DateTime.now();
      DateTime moonLanding = DateTime(
          int.parse(array[0]), int.parse(array[1]), int.parse(array[2]));

      final difference = berlinWallFell.difference(moonLanding);

      days = difference.inDays;
      hour = difference.inHours - difference.inDays * 24;
      minute = difference.inMinutes - difference.inHours * 60;

      streamController.add(true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      padding: EdgeInsets.only(top: 11.h, left: 20.w, right: 25.w),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.r), color: Colors.white),
      child: StreamBuilder<bool>(
          stream: streamController.stream,
          builder: (context, snapshot) {
            return Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Text(
                          'Вы встречаетесь уже:',
                          style: TextStyle(
                              color: const Color(0xFF969696),
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w700),
                        ),
                        SizedBox(
                          height: 9.h,
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 5.h),
                      child: SvgPicture.asset(
                        'assets/icons/settings.svg',
                        height: 18.67.h,
                        width: 18.67.h,
                      ),
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '$days',
                      style: TextStyle(
                          color: const Color(0xFF171717),
                          fontSize: 50.sp,
                          fontWeight: FontWeight.w700),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 7.h),
                      child: Text(
                        'д',
                        style: TextStyle(
                            color: const Color(0xFF969696),
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    Text(
                      '$hour',
                      style: TextStyle(
                          color: const Color(0xFF171717),
                          fontSize: 50.sp,
                          fontWeight: FontWeight.w700),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 7.h),
                      child: Text(
                        'ч',
                        style: TextStyle(
                            color: const Color(0xFF969696),
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    Text(
                      '$minute',
                      style: TextStyle(
                          color: const Color(0xFF171717),
                          fontSize: 50.sp,
                          fontWeight: FontWeight.w700),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 7.h),
                      child: Text(
                        'мин',
                        style: TextStyle(
                            color: const Color(0xFF969696),
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                  ],
                )
              ],
            );
          }),
    );
  }
}
