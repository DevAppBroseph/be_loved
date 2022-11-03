import 'package:be_loved/core/helpers/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';




class TimeItemTextFieldWidget extends StatelessWidget {
  final Function() validateText;
  final TextEditingController controller;
  const TimeItemTextFieldWidget({Key? key, required this.controller, required this.validateText}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    var maskFormatter = MaskTextInputFormatter(mask: '##:##', filter: { "#": RegExp(r'[0-9]') });
    TextStyle style3 = TextStyle(
      color: Colors.white,
      fontSize: 15.sp,
      fontWeight: FontWeight.w700
    );
    return SizedBox(
      width: 64.w,
      child: FocusScope(
        onFocusChange: (s){
          if(!s){
            validateText();
          }
        },
        child: TextFormField(
          controller: controller,
          keyboardType: TextInputType.number,
          style: style3,
          maxLines: 1,
          textAlign: TextAlign.center, 
          inputFormatters: [maskFormatter],
          decoration: InputDecoration(
            filled: true,
            isDense: true,
            contentPadding: EdgeInsets.symmetric(vertical: 8.5.h),
            fillColor: greyColor3,
            hintStyle: style3,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(7.r),
              borderSide: BorderSide.none
            ),
            
            hintText: '23:59'
          ),
        ),
      ),
    );
  }
}