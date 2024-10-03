import 'package:ecommerce_seller/presentation/main_section/home_screen/home_screen.dart';
import 'package:ecommerce_seller/presentation/on_boarding_section/login_screen/controller/login_controller.dart';
import 'package:ecommerce_seller/presentation/on_boarding_section/reset_password/reset_password_screen.dart';
import 'package:ecommerce_seller/presentation/widgets/button_widgets.dart';
import 'package:ecommerce_seller/utilz/colors.dart';
import 'package:ecommerce_seller/utilz/enums.dart';
import 'package:ecommerce_seller/utilz/sized_box.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class LoginScreenWithEmail extends StatelessWidget {
  LoginScreenWithEmail({super.key});

  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();

  final LoginController loginController = Get.find<LoginController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 1.h,
            ),
            TextField(
              controller: email,
              decoration: InputDecoration(
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  labelText: 'Email',
                  labelStyle: GoogleFonts.poppins(
                      fontWeight: FontWeight.w500,
                      fontSize: 14.px,
                      color: black),
                  border: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: black,
                      ),
                      borderRadius: BorderRadius.circular(10)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: grey.withOpacity(0.3))),
                  //  border: OutlineInputBorder(borderSide: BorderSide.none),
                  hintText: 'example@gmail.com',
                  hintStyle: TextStyle(
                    color: grey.withOpacity(0.3),
                  ),
                  contentPadding: const EdgeInsets.all(10)),
            ),
            SizedBox(
              height: Adaptive.h(2),
            ),
            TextField(
              controller: password,
              decoration: InputDecoration(
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  labelText: 'Password',
                  labelStyle: GoogleFonts.poppins(
                      fontWeight: FontWeight.w500,
                      fontSize: 14.px,
                      color: black),
                  border: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: black,
                      ),
                      borderRadius: BorderRadius.circular(10)),
                  hintText: 'Password*',
                  hintStyle: TextStyle(
                    color: grey.withOpacity(0.3),
                  ),
                  contentPadding: EdgeInsets.all(10)),
            ),
            sizedBoxHeight20,

            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    Get.to(() => const ResetPassword());
                  },
                  child: RichText(
                      text: TextSpan(children: [
                    TextSpan(
                        text: 'Forget Your Password?',
                        style: GoogleFonts.roboto(
                            fontSize: 16.sp, color: Colors.black)),
                    const TextSpan(
                      text: ' Reset Here',
                      style: TextStyle(
                          fontSize: 14,
                          color: Colors.yellow,
                          fontWeight: FontWeight.w300,
                          decoration: TextDecoration.underline,
                          decorationColor: Colors.yellow),
                    ),
                  ])),
                )
              ],
            ),
            SizedBox(
              height: Adaptive.h(8),
            ),
            Obx(
              () => loginController.loginStatus.value != Status.loading
                  ? InkWell(
                      onTap: () {
                        //  Get.to(()=> OtpScreen());

                        loginController
                            .login(
                                password: password.text.trim(),
                                email: email.text.trim(),
                                loginWithEmail: true)
                            .then((value) {
                          if (value) {
                            Get.to(() => HomeScreen());
                          }
                        });
                      },
                      child: ButtonWidget(
                        backgroundColor: buttonColor,
                        title: 'Login',
                        textColor: Colors.white,
                        heights: Adaptive.h(6),
                      ))
                  : SizedBox(
                      height: Adaptive.h(6),
                      child: const Center(child: CircularProgressIndicator()),
                    ),
            ),
            SizedBox(
              height: 2.h,
            ),
            // InkWell(
            //   onTap: () {
            //     // Get.to(()=> CreateAccountScreeen());
            //   },
            //   child: RichText(text: TextSpan(
            //     children: [
            //       TextSpan(
            //         text: 'By continuing, I agree of the',
            //        style: GoogleFonts.roboto(
            //         color: Color(0XFF505050),
            //        ),

            //       ),
            //       TextSpan(
            //         text: ' Terms of Use',
            //         style: GoogleFonts.roboto(
            //           color: buttonColor,
            //           fontWeight: FontWeight.w500,
            //           fontSize: 14.px
            //         )
            //       ),
            //        TextSpan(
            //         text: '&',
            //        style: GoogleFonts.roboto(
            //         color: Color(0XFF505050),
            //        ),

            //       ),
            //        TextSpan(
            //         text: ' Privacy \npolicy ',
            //        style: GoogleFonts.roboto(
            //        color: buttonColor,
            //           fontWeight: FontWeight.w500,
            //           fontSize: 14.px
            //        ),

            //       ),
            //     ]
            //   )),
            // ),
          ],
        ),
      ),
    );
  }
}
