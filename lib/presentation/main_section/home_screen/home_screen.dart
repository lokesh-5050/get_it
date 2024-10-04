import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_seller/core/shared_prefs/shared_pref.dart';
import 'package:ecommerce_seller/core/shared_prefs/shared_prefs_key_constants.dart';
import 'package:ecommerce_seller/presentation/main_section/home_screen/category/category_by_clicking_cat/category_screen.dart';
import 'package:ecommerce_seller/presentation/main_section/home_screen/components/extracted_homewidgets.dart';
import 'package:ecommerce_seller/presentation/main_section/home_screen/controller/product_controller.dart';
import 'package:ecommerce_seller/presentation/main_section/home_screen/flash_sale/flash_sale_screen.dart';
import 'package:ecommerce_seller/presentation/main_section/home_screen/top_products/top_product_screen.dart';
import 'package:ecommerce_seller/presentation/main_section/profile/controller/profile_controller.dart';
import 'package:ecommerce_seller/presentation/main_section/search_screen/search_screen.dart';
import 'package:ecommerce_seller/presentation/on_boarding_section/login_screen/login_screen.dart';
import 'package:ecommerce_seller/presentation/widgets/bottomsheet_function.dart';
import 'package:ecommerce_seller/src/model/product/product_model.dart';
import 'package:ecommerce_seller/utilz/colors.dart';
import 'package:ecommerce_seller/utilz/enums.dart';
import 'package:ecommerce_seller/utilz/helpers.dart';
import 'package:ecommerce_seller/utilz/sized_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shimmer/flutter_shimmer.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:velocity_x/velocity_x.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final ProfileController _profileController = Get.find<ProfileController>();

  @override
  Widget build(BuildContext context) {
    debugPrint(
        'Token : ${SharedPrefs.instance.getKey(SharedPrefKeyConstants.apiToken)}');

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: Adaptive.h(20),
              width: Adaptive.w(100),
              color: chatColor,
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // sizedBoxHeight50,
                  sizedBoxHeight50,
                  Row(
                    children: [
                      sizedBoxWidth40,
                      Image.asset(
                        'assets/images/home_screen_logo.png',
                        color: grey,
                      ),
                      Spacer(),
                      InkWell(
                          onTap: () {
                            Helpers.cupertinoAlertPopUp(
                                "This will log out your account!",
                                () => Get.back(),
                                optionText: "Cancel", secondOnTap: () {
                              _profileController.logout().then((value) {
                                if (value) {
                                  Get.offAll(LoginScreen());
                                }
                              });
                            }, secondOptionText: "Logout", secondOption: true);
                          },
                          child: Icon(Icons.logout)),
                      sizedBoxWidth30,
                      GestureDetector(
                          onTap: () {
                            // Get.to(() => NotificationScreen());
                          },
                          child: Image.asset('assets/images/appbar1.png')),
                      sizedBoxWidth30,
                      GestureDetector(
                          onTap: () {
                            showCustomBottomSheet(context);
                          },
                          child: Image.asset('assets/images/appbar2.png')),
                      sizedBoxWidth30,
                      Image.asset('assets/images/carbon_delivery.png'),
                      sizedBoxWidth40,
                    ],
                  ),
                  Spacer(),
                  GestureDetector(
                    onTap: () {
                      Get.to(() => const SearchScreen());
                    },
                    child: Container(
                      height: Adaptive.h(6),
                      width: Adaptive.w(90),
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: whiteColor,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          Text(
                            'Search your products...',
                            style: GoogleFonts.poppins(
                                color: grey,
                                fontWeight: FontWeight.w400,
                                fontSize: 15.px),
                          ),
                          Spacer(),
                          Icon(
                            Icons.search,
                            color: buttonColor,
                          ),
                          sizedBoxWidth20,
                          Container(
                            height: Adaptive.h(2),
                            width: Adaptive.w(0.4),
                            color: grey,
                          ),
                          sizedBoxWidth20,
                          Image.asset('assets/images/home2.png'),
                          sizedBoxWidth15
                        ],
                      ),
                    ),
                  ),
                  sizedBoxHeight20,
                ],
              ),
            ),
            sizedBoxHeight10,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                children: [
                  Text(
                    'Categories',
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w500, fontSize: 16.px),
                  ),
                  Spacer(),
                  Text(
                    'SeeAll',
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w400,
                        fontSize: 14.px,
                        color: chatColor,
                        decorationColor: chatColor,
                        decoration: TextDecoration.underline),
                  )
                ],
              ),
            ),
            GestureDetector(
                onTap: () {
                  Get.to(() => CategoryScreen());
                },
                child: HomeCatWidgets()),
            GetBuilder<ProductController>(
              builder: (controller) {
                if (controller.getNewArrivalsStatus == Status.loading) {
                  return const PlayStoreShimmer(
                    hasBottomFirstLine: false,
                    hasCustomColors: true,
                    hasBottomSecondLine: false,
                    padding: EdgeInsets.only(right: 16, top: 12),
                    margin: EdgeInsets.only(right: 16, top: 12),
                  );
                } else if (controller.getNewArrivals.isEmpty ||
                    controller.getNewArrivalsStatus == Status.failed) {
                  return const Text("No new arrivals found");
                }
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'New Arrivals',
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500, fontSize: 16.px),
                      ),
                      sizedBoxHeight10,
                      SizedBox(
                        height: Adaptive.h(22),
                        child: GestureDetector(
                            onTap: () {
                              Get.to(() => const FlashSaleScreen());
                            },
                            child: PageView.builder(
                              controller: PageController(),
                              itemCount: controller.getNewArrivals.length,
                              itemBuilder: (context, index) {
                                return Container(
                                  width: Get.width,
                                  child: GestureDetector(
                                      onTap: () {
                                        Get.to(() => const FlashSaleScreen());
                                      },
                                      child: CachedNetworkImage(
                                        imageUrl: controller
                                                .getNewArrivals[index]
                                                .image!
                                                .isNotEmpty
                                            ? controller.getNewArrivals[index]
                                                .image!.first.url
                                                .toString()
                                            : "",
                                        fit: BoxFit.cover,
                                        alignment: Alignment.topCenter,
                                      )),
                                );
                              },
                            )),
                      ),
                    ],
                  ),
                );
              },
            ),

            sizedBoxHeight20,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: GestureDetector(
                  onTap: () {
                    Get.to(() => const TopProductScreen());
                  },
                  child: Image.asset('assets/images/homeban2.png')),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Shop By Price',
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w500, fontSize: 16.px),
                ),
              ),
            ),
            sizedBoxHeight30,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: SizedBox(
                // color: grey,
                height: Adaptive.h(15),
                width: Adaptive.w(100),

                child: ListView.separated(
                  shrinkWrap: true,
                  physics: AlwaysScrollableScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemCount: 3,
                  separatorBuilder: (context, index) => sizedBoxWidth30,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Image.asset('assets/images/homeprice.png'),
                      ],
                    );
                  },
                ),
              ),
            ),
            sizedBoxHeight30,
            Container(
              height: Adaptive.h(6),
              width: Adaptive.w(90),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: red,
              ),
              child: Center(
                child: Container(
                  height: Adaptive.h(5),
                  width: Adaptive.w(70),
                  margin: EdgeInsets.symmetric(horizontal: 8),
                  decoration: BoxDecoration(
                    color: whiteColor,
                    // borderRadius: BorderRadius.circular(12)
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'MY COUPONS',
                        style: GoogleFonts.poppins(
                            fontSize: 24.px,
                            color: red,
                            fontWeight: FontWeight.w600),
                      ),
                      sizedBoxWidth10,
                      CircleAvatar(
                          radius: 16.sp,
                          backgroundColor: red,
                          child: Icon(
                            Icons.keyboard_arrow_right,
                            color: whiteColor,
                          ))
                    ],
                  ),
                ),
              ),
            ),
            sizedBoxHeight30,
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Discount for you',
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w500, fontSize: 16.px),
                ),
              ),
            ),
            sizedBoxHeight20,
            SizedBox(
              height: Adaptive.h(24),
              child: ListView.separated(
                  shrinkWrap: true,
                  physics: AlwaysScrollableScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black.withOpacity(0.1),
                          ),
                          borderRadius: BorderRadius.circular(12)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.asset('assets/images/homelap.png'),
                          sizedBoxHeight10,
                          Text(
                            'Vinta Bags',
                            style: GoogleFonts.poppins(
                                fontSize: 14.px, fontWeight: FontWeight.w500),
                          ),
                          Text(
                            'Min.60% Off',
                            style: GoogleFonts.poppins(
                                color: Colors.green,
                                fontSize: 14.px,
                                fontWeight: FontWeight.w500),
                          )
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => sizedBoxWidth20,
                  itemCount: 2),
            ),
            sizedBoxHeight20,
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Text(
                    'Deal of the Day',
                    style: GoogleFonts.poppins(
                        fontSize: 16.px, fontWeight: FontWeight.w500),
                  ),
                  Spacer(),
                  CircleAvatar(
                      radius: 16.sp,
                      backgroundColor: buttonColor,
                      child: Icon(
                        Icons.keyboard_arrow_right,
                        color: whiteColor,
                      ))
                ],
              ),
            ),
            GetBuilder<ProductController>(
              builder: (controller) {
                if (controller.getTodayDealsStatus == Status.loading) {
                  return const PlayStoreShimmer(
                    hasBottomFirstLine: false,
                    hasCustomColors: true,
                    hasBottomSecondLine: false,
                    padding: EdgeInsets.only(right: 16, top: 12),
                    margin: EdgeInsets.only(right: 16, top: 12),
                  );
                } else if (controller.getTodayDeals.isEmpty ||
                    controller.getTodayDealsStatus == Status.failed) {
                  return const Text("No deals at the moment");
                }
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: SizedBox(
                    height: Adaptive.h(30),
                    width: Adaptive.w(100),
                    child: ListView.separated(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      physics: AlwaysScrollableScrollPhysics(),
                      itemCount: controller.getTodayDeals.length,
                      separatorBuilder: (context, index) => sizedBoxWidth10,
                      itemBuilder: (context, index) {
                        return itemsOfProducts(controller.getTodayDeals[index]);
                      },
                    ),
                  ),
                );
              },
            ),
            sizedBoxHeight20,
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Trending Products',
                        style: GoogleFonts.poppins(
                            fontSize: 16.px, fontWeight: FontWeight.w500),
                      ),
                      Row(
                        children: [
                          Icon(Icons.calendar_month),
                          sizedBoxWidth20,
                          Text(
                            'Last Date 20-03-2024',
                            style: GoogleFonts.poppins(
                                fontSize: 14.px, fontWeight: FontWeight.w500),
                          ),
                        ],
                      )
                    ],
                  ),
                  Spacer(),
                  CircleAvatar(
                      radius: 16.sp,
                      backgroundColor: buttonColor,
                      child: Icon(
                        Icons.keyboard_arrow_right,
                        color: whiteColor,
                      ))
                ],
              ),
            ),
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 8.0),
            //   child: SizedBox(
            //     height: Adaptive.h(30),
            //     width: Adaptive.w(100),
            //     child: ListView.separated(
            //       shrinkWrap: true,
            //       scrollDirection: Axis.horizontal,
            //       physics: AlwaysScrollableScrollPhysics(),
            //       itemCount: 2,
            //       separatorBuilder: (context, index) => sizedBoxWidth10,
            //       itemBuilder: (context, index) {
            //         return itemsOfProducts(index, name);
            //       },
            //     ),
            //   ),
            // )
          ],
        ),
      ),
    );
  }

  InkWell itemsOfProducts(ProductModel deal) {
    return InkWell(
      onTap: () {
        // Navigator.push(context, MaterialPageRoute(builder: (context) => AnimalDetails(),));
      },
      child: Container(
        width: Adaptive.w(50),
        height: Adaptive.h(25),
        margin: const EdgeInsets.only(left: 0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: const Color.fromARGB(255, 230, 227, 227),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(0),
          child: Stack(
            children: [
              Column(
                children: [
                  SizedBox(
                    // height: 11.h,
                    width: 100.w,
                    // color: green,
                    // child: Image.asset(
                    //   'assets/images/wishlist${index + 1}.png',
                    //   fit: BoxFit.cover,
                    //   width: 100.w,
                    // ),
                    child: CachedNetworkImage(
                      imageUrl:
                          "${deal.image!.isNotEmpty ? deal.image!.first.url : ""}",
                      width: 100.w,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 5,
                      right: 5,
                    ),
                    child: Row(
                      children: [
                        Text(
                          deal.productName ?? '',
                          style: TextStyle(
                              color: black,
                              fontSize: 13.px,
                              fontWeight: FontWeight.w600),
                        )

                        // Icon(Icons.share,size: 12.sp,color: green,)
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          deal.description ?? '',
                          maxLines: 2,
                          style: TextStyle(
                              color: black,
                              fontSize: 10.px,
                              fontWeight: FontWeight.bold),
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '₹${deal.discountPrice}',
                          style: TextStyle(
                              color: black,
                              fontSize: 13.px,
                              fontWeight: FontWeight.w500),
                        ),
                        Spacer(),
                        Text(
                          'MOQ: ${deal.stock} Pcs',
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w400, fontSize: 13.px),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '₹${deal.originalPrice}',
                          style: TextStyle(
                              decoration: TextDecoration.lineThrough,
                              color: Colors.black26,
                              fontSize: 13.px,
                              fontWeight: FontWeight.w500),
                        ),
                        Spacer(),
                        Text(
                          'MOQ: 4 Pcs',
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w400, fontSize: 13.px),
                        )
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      VxRating(
                        count: int.tryParse(deal.rating.toString()) ?? 0,
                        selectionColor: buttonColor,
                        onRatingUpdate: (value) {},
                      ),
                      Text(
                        '${deal.numOfReviews}',
                        style: TextStyle(color: grey, fontSize: 12.px),
                      )
                    ],
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Spacer(),
                    // (),
                    Icon(
                      Icons.favorite,
                      color: red,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
