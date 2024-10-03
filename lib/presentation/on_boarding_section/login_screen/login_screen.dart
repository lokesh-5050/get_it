import 'package:ecommerce_seller/presentation/on_boarding_section/create_account/create_account_screen.dart';
import 'package:ecommerce_seller/presentation/on_boarding_section/login_screen/components/login_with_email.dart';
import 'package:ecommerce_seller/presentation/on_boarding_section/login_screen/components/login_with_phone.dart';
import 'package:ecommerce_seller/presentation/on_boarding_section/login_screen/controller/login_controller.dart';
import 'package:ecommerce_seller/utilz/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  PageController pageController = PageController();

  final LoginController loginController = Get.find<LoginController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          children: [
            SizedBox(
              height: Adaptive.h(5),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // IconButton(onPressed: (){}, icon: Icon(Icons.arrow_back)),
                InkWell(
                  onTap: () => Get.back(),
                  child: Text(
                    'Back',
                    style: GoogleFonts.poppins(
                        fontSize: 14.px, color: buttonColor),
                  ),
                ),
                // SizedBox(width: Adaptive.w(5),),
                InkWell(
                  onTap: () {
                    Get.to(() => CreateAccountScreen());
                  },
                  child: Text(
                    'Sign up',
                    style: GoogleFonts.poppins(
                        fontSize: 14.px, color: buttonColor),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: Adaptive.h(4),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Login using Mobile\nNumber or Email',
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600, fontSize: 30.px),
              ),
            ),
            SizedBox(
              height: Adaptive.h(2),
            ),
            Container(
              // padding: EdgeInsets.symmetric(horizontal: 5.w,vertical: 1.5.h),
              margin: EdgeInsets.symmetric(horizontal: 6.w),
              decoration: BoxDecoration(
                color: Color(0xffE6E6E6),
                borderRadius: BorderRadius.circular(Adaptive.w(8)),
              ),
              child: Obx(() {
                return Row(
                  children: [
                    loginController.selectedValue.value == 'Login'
                        ? GestureDetector(
                            onTap: () {
                              //  loginController.changingSelectedOption('login');
                              pageController.previousPage(
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.linear);
                            },
                            child: Material(
                              elevation: 5,
                              borderRadius:
                                  BorderRadius.circular(Adaptive.w(8)),
                              child: Container(
                                width: Adaptive.w(45),
                                height: Adaptive.h(6),
                                // padding: EdgeInsets.only(left: 5.w,right: 5.w,top: 1.h,bottom: 1.h),
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.circular(Adaptive.w(12)),
                                  color: buttonColor,
                                ),
                                child: Center(
                                  child: Text(
                                    'Mobile Number',
                                    style: GoogleFonts.roboto(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ),
                            ),
                          )
                        : GestureDetector(
                            onTap: () {
                              loginController.changingSelectedOption('Login');
                              pageController.previousPage(
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.linear);
                            },
                            child: Container(
                              padding: EdgeInsets.only(
                                  left: 5.w, right: 5.w, top: 1.h, bottom: 1.h),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.transparent,
                              ),
                              child: Center(
                                child: Text(
                                  'Mobile Number',
                                  style: GoogleFonts.roboto(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),
                          ),
                    Spacer(),
                    loginController.selectedValue.value == 'Email'
                        ? GestureDetector(
                            onTap: () {
                              loginController.changingSelectedOption('Email');
                              pageController.nextPage(
                                  duration: Duration(milliseconds: 300),
                                  curve: Curves.linear);
                            },
                            child: Container(
                              width: Adaptive.w(45),
                              height: Adaptive.h(6),
                              // padding: EdgeInsets.only(left: 5.w,right: 5.w,top: 1.h,bottom: 1.h),
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.circular(Adaptive.w(12)),
                                color: buttonColor,
                              ),
                              child: Center(
                                child: Text(
                                  'Email',
                                  style: GoogleFonts.roboto(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),
                          )
                        : GestureDetector(
                            onTap: () {
                              loginController.changingSelectedOption('Email');
                              pageController.nextPage(
                                  duration: Duration(milliseconds: 300),
                                  curve: Curves.linear);
                            },
                            child: Container(
                              padding: EdgeInsets.only(
                                  left: 12.w,
                                  right: 12.w,
                                  top: 1.h,
                                  bottom: 1.h),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                // color: Colors.transparent,
                              ),
                              child: Center(
                                child: Text(
                                  ' Email',
                                  style: GoogleFonts.roboto(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),
                          )
                  ],
                );
              }),
            ),
            SizedBox(
              height: 2.h,
            ),
            Expanded(
              child: Container(
                //  height: Adaptive.h(6),
                color: Colors.amber,
                child: PageView(
                  scrollDirection: Axis.horizontal,
                  physics: AlwaysScrollableScrollPhysics(),
                  controller: pageController,
                  children: [
                    LoginScreenWithPhone(),
                    LoginScreenWithEmail()
                    // LoginScreenWithPhone(),
                    // LoginWithEmail()
                  ],
                  onPageChanged: (value) {
                    print("index:$value");
                    if (value == 0) {
                      // loginController.changingSelectedOption("login");
                    } else {
                      // loginController.changingSelectedOption("email");
                    }
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
