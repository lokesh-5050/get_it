import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_seller/presentation/main_section/home_screen/controller/product_controller.dart';
import 'package:ecommerce_seller/presentation/main_section/home_screen/top_products/top_product_screen.dart';
import 'package:ecommerce_seller/presentation/main_section/notification/notification_screen.dart';
import 'package:ecommerce_seller/src/model/category/category_model.dart';
import 'package:ecommerce_seller/utilz/colors.dart';
import 'package:ecommerce_seller/utilz/enums.dart';
import 'package:ecommerce_seller/utilz/sized_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shimmer/flutter_shimmer.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: buttonColor,
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              size: 17,
            )),
        title: Text(
          'Clothes Category',
          style:
              GoogleFonts.poppins(fontSize: 18.px, fontWeight: FontWeight.w500),
        ),
        actions: [
          GestureDetector(
              onTap: () {
                Get.to(() => NotificationScreen());
              },
              child: Image.asset('assets/images/appbar1.png')),
          sizedBoxWidth20,
          Image.asset('assets/images/appbar2.png'),
          sizedBoxWidth20,
          Image.asset('assets/images/appbar3.png'),
          sizedBoxWidth20,
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              GetBuilder<ProductController>(
                builder: (controller) {
                  if (controller.categoryStatus == Status.loading) {
                    return const PlayStoreShimmer(
                      hasBottomFirstLine: false,
                      hasCustomColors: true,
                      hasBottomSecondLine: false,
                      padding: EdgeInsets.only(right: 16, top: 12),
                      margin: EdgeInsets.only(right: 16, top: 12),
                    );
                  } else if (controller.allSubCategory.isEmpty ||
                      controller.categoryStatus == Status.failed) {
                    return Text("No category found");
                  }
                  return SizedBox(
                      // height: Adaptive.h(20),
                      child: GridView.builder(
                    shrinkWrap: true,
                    // scrollDirection: Axis.horizontal,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 5,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        // Adjust the cross axis count to show 4 items in each row
                        mainAxisSpacing: 5,
                        crossAxisSpacing: 6,
                        childAspectRatio: 1),
                    itemBuilder: (context, index) {
                      CategoryModel category = controller.allCategory[index];
                      return GestureDetector(
                        onTap: () {
                          Get.to(() => TopProductScreen(
                                categoryId: category.mainCategory ?? '',
                                type: "mainCategory",
                              ));
                        },
                        child: Container(
                          height: Adaptive.h(13),
                          width: Adaptive.w(30),
                          // padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              color: index % 2 == 0
                                  ? const Color(0xffE3DEEC)
                                  : Color(0xffE2E5D7),
                              borderRadius: BorderRadius.circular(12.sp)),
                          child: CachedNetworkImage(
                            imageUrl: category.image ?? '',
                            height: Adaptive.h(8),
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    },
                  ));
                },
              ),
              sizedBoxHeight30,
              Container(
                  padding: const EdgeInsets.all(10),
                  decoration:
                      BoxDecoration(border: Border.all(color: Colors.amber)),
                  // height: Adaptive.h(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Western Wear',
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w600, fontSize: 15.px),
                      ),
                      sizedBoxHeight10,
                      GetBuilder<ProductController>(
                        builder: (controller) {
                          if (controller.subCategoryStatus == Status.loading) {
                            return const PlayStoreShimmer(
                              hasBottomFirstLine: false,
                              hasCustomColors: true,
                              hasBottomSecondLine: false,
                              padding: EdgeInsets.only(right: 16, top: 12),
                              margin: EdgeInsets.only(right: 16, top: 12),
                            );
                          } else if (controller.allSubCategory.isEmpty ||
                              controller.subCategoryStatus == Status.failed) {
                            return const Text("No sub category found");
                          }
                          return SizedBox(
                            child: GridView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: controller.allSubCategory.length,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 4,
                                      // Adjust the cross axis count to show 4 items in each row
                                      mainAxisSpacing: 1,
                                      crossAxisSpacing: 1,
                                      childAspectRatio: 0.55),
                              itemBuilder: (context, index) {
                                CategoryModel categoryModel =
                                    controller.allSubCategory[index];
                                return InkWell(
                                  onTap: () {
                                    Get.to(() => TopProductScreen(
                                          type: "subCategory",
                                          categoryId:
                                              categoryModel.category ?? "",
                                        ));
                                  },
                                  child: Column(
                                    children: [
                                      CachedNetworkImage(
                                        imageUrl: categoryModel.image ?? '',
                                        height: Adaptive.h(11),
                                        fit: BoxFit.contain,
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          );
                        },
                      ),
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
