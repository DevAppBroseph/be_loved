import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';

class DilogTabs extends StatelessWidget {
  final String image;
  final String title;
  final Function(ImageSource source)? onTap;
  final Function()? mirror;
  const DilogTabs({
    Key? key,
    required this.image,
    required this.title,
    required this.onTap,
    this.mirror,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45.h,
      width: 248.w,
      margin: EdgeInsets.symmetric(vertical: 3.h),
      child: Material(
        color: Colors.white,
        child: InkWell(
          onTap: () {
            try {
              onTap!(ImageSource.gallery);
            } catch (_) {
              mirror!();
            }
          },
          child: Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 21.w),
              child: Row(
                children: [
                  SvgPicture.asset(image),
                  Padding(
                    padding: EdgeInsets.only(left: 15.h),
                    child: Text(
                      title,
                      style: GoogleFonts.inter(
                        fontSize: 15.sp,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
