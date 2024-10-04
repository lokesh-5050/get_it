import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_seller/presentation/main_section/home_screen/controller/product_controller.dart';
import 'package:ecommerce_seller/presentation/main_section/home_screen/top_products/filter_by_clicking_top_product/filter_screen.dart';
import 'package:ecommerce_seller/presentation/main_section/home_screen/top_products/product_screen/product_details_screen.dart';
import 'package:ecommerce_seller/presentation/main_section/notification/notification_screen.dart';
import 'package:ecommerce_seller/src/model/product/product_model.dart';
import 'package:ecommerce_seller/utilz/colors.dart';
import 'package:ecommerce_seller/utilz/enums.dart';
import 'package:ecommerce_seller/utilz/sized_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shimmer/flutter_shimmer.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:velocity_x/velocity_x.dart';

class TopProductScreen extends StatefulWidget {
  final String categoryId;
  final String type;

  const TopProductScreen(
      {super.key, required this.categoryId, required this.type});

  @override
  State<TopProductScreen> createState() => _TopProductScreenState();
}

class _TopProductScreenState extends State<TopProductScreen> {
  final ProductController productController = Get.find<ProductController>();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((e) {
      _onInitialRun();
    });
    super.initState();
  }

  void _onInitialRun() async {
    switch (widget.type) {
      case "mainCategory":
        await productController.getProductsByMainCategory(
            mainCategoryId: widget.categoryId);
        break;
      case "subCategory":
        break;
    }
  }

  @override
  void dispose() {
    productController.products = [];
    productController.productsStatus = Status.success;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: buttonColor,
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(
              Icons.arrow_back_ios,
              size: 16.px,
            )),
        title: Text(
          'Top Products',
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
              Row(
                children: [
                  GestureDetector(
                      onTap: () {
                        Get.to(() => const FilterScreen());
                      },
                      child: Image.asset('assets/images/topproduct.png')),
                  sizedBoxWidth10,
                  Text(
                    'Filters',
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w500, fontSize: 15.px),
                  ),
                  Spacer(),
                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.sp),
                        color: Color(0xffE2E5D7)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Sort By',
                          style: GoogleFonts.poppins(
                              fontSize: 13.px, fontWeight: FontWeight.w500),
                        ),
                        const Icon(Icons.arrow_drop_down_sharp)
                      ],
                    ),
                  )
                ],
              ),
              sizedBoxHeight10,
              GetBuilder<ProductController>(
                builder: (controller) {
                  if (controller.productsStatus == Status.loading) {
                    return const Column(
                      children: [
                        ListTileShimmer(),
                        ListTileShimmer(),
                        ListTileShimmer(),
                        ListTileShimmer()
                      ],
                    );
                  } else if (controller.products.isEmpty ||
                      controller.productsStatus == Status.failed) {
                    return Center(
                      child: Text("No products found"),
                    );
                  }
                  return Container(
                      // height: 50.h,
                      width: 100.w,
                      // height: 50.h,
                      //   color: green,
                      child: GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2, // Number of columns
                                crossAxisSpacing: 5, // Spacing between columns
                                mainAxisSpacing: 9.0, // Spacing between rows
                                childAspectRatio: 0.75),
                        itemCount: controller.products.length,
                        itemBuilder: (context, index) {
                          ProductModel product = controller.products[index];
                          return InkWell(
                            onTap: () {
                              Get.to(() => ProductDetailsScreen(
                                    productId: product.sId ?? '',
                                  ));
                              // Navigator.push(context, MaterialPageRoute(builder: (context) => AnimalDetails(),));
                            },
                            child: Container(
                              margin: const EdgeInsets.only(left: 0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color:
                                      const Color.fromARGB(255, 230, 227, 227),
                                ),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(0),
                                child: Column(
                                  children: [
                                    SizedBox(
                                      // height: 11.h,
                                      width: 100.w,
                                      // color: green,
                                      child: CachedNetworkImage(
                                          width: 100.w,
                                          imageUrl: product.image!.isNotEmpty
                                              ? product.image!.first.url ?? ''
                                              : ""),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        left: 5,
                                        right: 5,
                                      ),
                                      child: Row(
                                        children: [
                                          Text(
                                            product.productName ?? '',
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
                                            product.description ?? '',
                                            maxLines: 2,
                                            style: TextStyle(
                                                color: Colors.black38,
                                                fontSize: 10.px,
                                                fontWeight: FontWeight.bold),
                                          )),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 5),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            '₹${product.discountPrice}',
                                            style: TextStyle(
                                                color: black,
                                                fontSize: 13.px,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          Spacer(),
                                          Text(
                                            'MOQ: ${product.stock} Pcs',
                                            style: GoogleFonts.poppins(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 13.px),
                                          )
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 5),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            '₹${product.originalPrice}',
                                            style: TextStyle(
                                                decoration:
                                                    TextDecoration.lineThrough,
                                                color: Colors.black26,
                                                fontSize: 13.px,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          sizedBoxWidth10,
                                          Text(
                                            '${product.discount}%Off',
                                            style: GoogleFonts.poppins(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 13.px,
                                                color: Colors.green),
                                          )
                                        ],
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        VxRating(
                                          count: double.tryParse(
                                                      product.rating.toString())
                                                  ?.toInt() ??
                                              0,
                                          selectionColor: buttonColor,
                                          onRatingUpdate: (value) {},
                                        ),
                                        Text(
                                          '${product.numOfReviews}',
                                          style: TextStyle(
                                              color: grey, fontSize: 12.px),
                                        )
                                      ],
                                    ),
                                    // sizedBoxHeight20,
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ));
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
