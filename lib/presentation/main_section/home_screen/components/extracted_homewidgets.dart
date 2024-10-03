import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_seller/presentation/main_section/home_screen/category/controller/category_controller.dart';
import 'package:ecommerce_seller/src/model/category/category_model.dart';
import 'package:ecommerce_seller/utilz/enums.dart';
import 'package:ecommerce_seller/utilz/sized_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shimmer/flutter_shimmer.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class HomeCatWidgets extends StatelessWidget {
  const HomeCatWidgets({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CategoryController>(
      builder: (controller) {
        if (controller.categoryStatus == Status.loading) {
          return const PlayStoreShimmer(
            hasBottomFirstLine: false,
            hasCustomColors: true,
            hasBottomSecondLine: false,
            padding: EdgeInsets.only(right: 16, top: 12),
            margin: EdgeInsets.only(right: 16, top: 12),
          );
        } else if (controller.allCategory.isEmpty ||
            controller.categoryStatus == Status.failed) {
          return const Text("No category found");
        }
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12),
          child: SizedBox(
            height: Adaptive.h(15),
            width: Adaptive.w(100),
            child: ListView.separated(
              shrinkWrap: true,
              physics: const AlwaysScrollableScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount: controller.allCategory.length,
              separatorBuilder: (context, index) => sizedBoxWidth30,
              itemBuilder: (context, index) {
                CategoryModel categoryModel = controller.allCategory[index];
                return Column(
                  children: [
                    CachedNetworkImage(
                      imageUrl: categoryModel.image ?? "",
                      height: Adaptive.h(9),
                    ),
                    Text(
                      '${categoryModel.name}',
                      style: GoogleFonts.poppins(
                          fontSize: 12.px, fontWeight: FontWeight.w400),
                    )
                  ],
                );
              },
            ),
          ),
        );
      },
    );
  }
}
