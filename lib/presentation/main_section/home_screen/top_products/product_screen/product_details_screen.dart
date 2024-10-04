import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_seller/presentation/main_section/home_screen/cart/cart_screen.dart';
import 'package:ecommerce_seller/presentation/main_section/home_screen/controller/product_controller.dart';
import 'package:ecommerce_seller/presentation/main_section/home_screen/top_products/product_screen/widgets/productdetails_widget.dart';
import 'package:ecommerce_seller/presentation/main_section/home_screen/top_products/rating_and_review_screen/rating_And_review_screen.dart';
import 'package:ecommerce_seller/src/model/product/product_model.dart';
import 'package:ecommerce_seller/utilz/colors.dart';
import 'package:ecommerce_seller/utilz/enums.dart';
import 'package:ecommerce_seller/utilz/sized_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shimmer/flutter_shimmer.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

// import 'package:readmore/readmore.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:velocity_x/velocity_x.dart';

class ProductDetailsScreen extends StatefulWidget {
  final String productId;

  const ProductDetailsScreen({super.key, required this.productId});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  final ProductController productController = Get.find<ProductController>();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((e) {
      _onInitialRun();
    });
    super.initState();
  }

  void _onInitialRun() async {
    await productController.getProductId(productId: widget.productId);
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
              size: 17.sp,
            )),
        title: Text(
          'Products Details',
          style:
              GoogleFonts.poppins(fontSize: 18.px, fontWeight: FontWeight.w500),
        ),
      ),
      body: GetBuilder<ProductController>(
        builder: (controller) {
          if (controller.productStatus == Status.loading) {
            return const Column(
              children: [ProfilePageShimmer(), ListTileShimmer()],
            );
          } else if (controller.product.sId == null ||
              controller.productStatus == Status.failed) {
            return const Text("Unable to find the product detail");
          }
          return _buildProduct(controller.product);
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            height: Adaptive.h(6),
            width: Adaptive.w(45),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.sp),
              border: Border.all(
                color: buttonColor,
              ),
              color: whiteColor,
            ),
            child: Center(
              child: Text(
                'Add To Cart',
                style: GoogleFonts.poppins(
                    fontSize: 15.px,
                    color: buttonColor,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ).onTap(() {
            Get.to(() => CartScreen());
          }),
          Container(
            height: Adaptive.h(6),
            width: Adaptive.w(45),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.sp),
              border: Border.all(
                color: buttonColor,
              ),
              color: buttonColor,
            ),
            child: Center(
              child: Text(
                'Buy Now',
                style: GoogleFonts.poppins(
                    fontSize: 15.px,
                    color: whiteColor,
                    fontWeight: FontWeight.w600),
              ),
            ),
          )
        ],
      ),
    );
  }

  String getRatingText(double rating) {
    if (rating >= 4.5) {
      return "Excellent";
    } else if (rating >= 4.0) {
      return "Very Good";
    } else if (rating >= 3.0) {
      return "Good";
    } else if (rating >= 2.0) {
      return "Average";
    } else {
      return "Below Average";
    }
  }

  Widget _buildProduct(ProductModel product) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Stack(
        children: [
          SizedBox(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  sizedBoxHeight20,
                  Stack(
                    children: [
                      SizedBox(
                          // height: Adaptive.h(26),
                          width: Get.width,
                          // color: black,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CachedNetworkImage(
                                imageUrl: product.image!.isNotEmpty
                                    ? product.image!.first.url ?? ''
                                    : "",
                                fit: BoxFit.cover,
                                width: Get.width,
                                alignment: Alignment.topCenter,
                                height: Adaptive.h(25),
                              ),
                            ],
                          )),
                      Positioned(
                        bottom: 0,
                        child: Row(
                          children: [
                            SizedBox(
                              height: Adaptive.h(8),
                              child: ListView.separated(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                separatorBuilder: (context, index) =>
                                    sizedBoxWidth05,
                                itemCount: product.image?.length ?? 0,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  return CachedNetworkImage(
                                      imageUrl: product.image!.isNotEmpty
                                          ? product.image![index].url ?? ''
                                          : "");
                                },
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                  sizedBoxHeight20,
                  Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: 15.sp, vertical: 10.sp),
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black45,
                        ),
                        borderRadius: BorderRadius.circular(22.sp)),
                    child: IntrinsicWidth(
                      child: Center(
                        child: Text(
                          'tap to see in 360',
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w400, fontSize: 15.px),
                        ),
                      ),
                    ),
                  ),
                  sizedBoxHeight20,
                  Row(
                    children: [
                      Text(
                        "Color: ${product.color!.isNotEmpty ? product.color!.first : ''}",
                        style: GoogleFonts.poppins(
                            fontSize: 15.px,
                            fontWeight: FontWeight.w400,
                            color: Colors.black54),
                      ),
                      Spacer(),
                      Text(
                        'Available color: ${product.color?.length}',
                        style: GoogleFonts.poppins(
                            fontSize: 15.px,
                            fontWeight: FontWeight.w400,
                            color: Colors.black54),
                      ),
                    ],
                  ),
                  sizedBoxHeight20,
                  SizedBox(
                    height: Adaptive.h(10),
                    child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return SizedBox(
                              width: Adaptive.w(23),
                              height: Adaptive.h(7),
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(12.sp),
                                  child: CachedNetworkImage(
                                      imageUrl: product.image!.isNotEmpty
                                          ? product.image![index].url ?? ''
                                          : "")));
                        },
                        separatorBuilder: (context, index) => sizedBoxWidth10,
                        itemCount: product.image?.length ?? 0),
                  ),
                  sizedBoxHeight10,
                  Row(
                    children: [
                      Text(
                        product.productName ?? '',
                        style: GoogleFonts.poppins(
                          fontSize: 15.px,
                          fontWeight: FontWeight.w500,
                          // color: Colors.black54
                        ),
                      ),
                      Spacer(),
                      Text(
                        product.stock != 0 ? "Available" : "Out of stock",
                        style: GoogleFonts.poppins(
                            fontSize: 15.px,
                            fontWeight: FontWeight.w400,
                            color: Colors.green),
                      ),
                    ],
                  ),
                  sizedBoxHeight15,
                  Row(
                    children: [
                      VxRating(
                        count: 5,
                        selectionColor: buttonColor,
                        onRatingUpdate: (value) {},
                      ),
                      sizedBoxWidth10,
                      Text(
                        getRatingText(
                            double.tryParse(product.rating.toString()) ?? 0.0),
                        style: GoogleFonts.poppins(
                            fontSize: 11.px,
                            fontWeight: FontWeight.w400,
                            color: chatColor),
                      ),
                      sizedBoxWidth10,
                      Text(
                        '${product.numOfReviews} ',
                        style: GoogleFonts.poppins(
                            fontSize: 11.px,
                            fontWeight: FontWeight.w400,
                            color: grey),
                      ),
                      sizedBoxWidth10,
                      Text(
                        'ratings ',
                        style: GoogleFonts.poppins(
                            fontSize: 11.px,
                            fontWeight: FontWeight.w400,
                            color: grey),
                      )
                    ],
                  ),
                  sizedBoxHeight10,
                  Row(
                    children: [
                      Text(
                        '₹ ${product.originalPrice}',
                        style: TextStyle(
                            decoration: TextDecoration.lineThrough,
                            color: Colors.black26,
                            fontSize: 16.px,
                            fontWeight: FontWeight.w500),
                      ),
                      sizedBoxWidth10,
                      Text(
                        '₹ ${product.discountPrice}',
                        style: TextStyle(
                            color: black,
                            fontSize: 17.px,
                            fontWeight: FontWeight.w600),
                      ),
                      sizedBoxWidth10,
                      Text(
                        '${product.discount}% off',
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500,
                            fontSize: 16.px,
                            color: Colors.green),
                      ),
                      Spacer(),
                      Text(
                        'MOQ: ${product.stock} Pcs',
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w400, fontSize: 13.px),
                      )
                    ],
                  ),
                  sizedBoxHeight10,
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Free Delivery ',
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500, color: Colors.green),
                      )),
                  sizedBoxHeight10,
                  Row(
                    children: [
                      Text(
                        'Deliver to:Pune-411045',
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w400, fontSize: 15.px),
                      ),
                      Spacer(),
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: Adaptive.w(2), vertical: Adaptive.h(1)),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.sp),
                            border: Border.all(
                              color: buttonColor,
                            )),
                        child: Center(
                          child: Text(
                            'Change',
                            style: TextStyle(color: buttonColor),
                          ),
                        ),
                      )
                    ],
                  ),
                  sizedBoxHeight10,
                  Divider(
                    color: black,
                  ),
                  sizedBoxHeight20,
                  delivaryContainer(),
                  sizedBoxHeight20,
                  containerFunctions('delivary2', '10 Days Return Policy'),
                  sizedBoxHeight20,
                  containerFunctions('delivary3', 'Cash on Delivery Available'),
                  sizedBoxHeight20,
                  Divider(
                    color: black,
                  ),
                  sizedBoxHeight20,
                  Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: 12.sp, vertical: Adaptive.h(2.5)),
                    decoration: BoxDecoration(
                        color: Color(0xffF2F2F2),
                        borderRadius: BorderRadius.circular(10.sp)),
                    child: Row(
                      children: [
                        // Image.asset('assets/images/$.png'),
                        // sizedBoxWidth20,
                        Text('All Offers & Coupons ',
                            style: GoogleFonts.poppins(
                              // decoration: TextDecoration.lineThrough,
                              // decorationColor: Colors.grey,
                              color: black,
                              fontWeight: FontWeight.w500,
                              fontSize: 16.px,
                            )),
                        Spacer(),
                        Icon(Icons.keyboard_arrow_right)
                      ],
                    ),
                  ),
                  sizedBoxHeight15,
                  Divider(
                    color: black,
                  ),
                  sizedBoxHeight20,
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Product Details',
                        style: GoogleFonts.poppins(
                          // decoration: TextDecoration.lineThrough,
                          // decorationColor: Colors.grey,
                          color: black,
                          fontWeight: FontWeight.w500,
                          fontSize: 16.px,
                        )),
                  ),
                  sizedBoxHeight10,
                  const ProductDetailsWidget(
                    title1: 'Material ',
                    title2: 'Synthetic Leather',
                    isColor: false,
                  ),
                  const ProductDetailsWidget(
                    title1: 'Number of compartments ',
                    title2: '1',
                    isColor: true,
                  ),
                  const ProductDetailsWidget(
                    title1: 'Closure ',
                    title2: 'Zipper',
                    isColor: false,
                  ),
                  const ProductDetailsWidget(
                    title1: 'Width ',
                    title2: '11 inch',
                    isColor: true,
                  ),
                  const ProductDetailsWidget(
                    title1: 'Capacity  ',
                    title2: '5 L',
                    isColor: false,
                  ),
                  sizedBoxHeight10,
                  Row(
                    children: [
                      Text('Product Details',
                          style: GoogleFonts.poppins(
                            // decoration: TextDecoration.lineThrough,
                            // decorationColor: Colors.grey,
                            color: black,
                            fontWeight: FontWeight.w500,
                            fontSize: 16.px,
                          )),
                      Spacer(),
                      Text('AllDetails',
                          style: GoogleFonts.poppins(
                            decoration: TextDecoration.underline,
                            decorationColor: buttonColor,
                            color: buttonColor,
                            fontWeight: FontWeight.w500,
                            fontSize: 16.px,
                          ))
                    ],
                  ),
                  sizedBoxHeight10,
                  Text(product.description ?? ''),
                  sizedBoxHeight20,
                  Row(
                    children: [
                      Text('Similar From Popular Brand',
                          style: GoogleFonts.poppins(
                            // decoration: TextDecoration.lineThrough,
                            // decorationColor: Colors.grey,
                            color: black,
                            fontWeight: FontWeight.w500,
                            fontSize: 16.px,
                          )),
                      Spacer(),
                      CircleAvatar(
                          radius: 16.sp,
                          backgroundColor: buttonColor,
                          child: Icon(
                            Icons.keyboard_arrow_right,
                            color: whiteColor,
                          )),
                    ],
                  ),
                  sizedBoxHeight15,
                  Container(
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
                                childAspectRatio: 0.8),
                        itemCount: 2,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              // Navigator.push(context, MaterialPageRoute(builder: (context) => AnimalDetails(),));
                            },
                            child: SimilarPopularBrandWidget(index: index),
                          );
                        },
                      )),
                  sizedBoxHeight20,
                  Row(
                    children: [
                      Text('Rating & Reviews',
                          style: GoogleFonts.poppins(
                            // decoration: TextDecoration.lineThrough,
                            // decorationColor: Colors.grey,
                            color: black,
                            fontWeight: FontWeight.w500,
                            fontSize: 16.px,
                          )),
                      Spacer(),
                      GestureDetector(
                        onTap: () {
                          Get.to(() => const RatingReviewScreen());
                        },
                        child: Text('AllDetails',
                            style: GoogleFonts.poppins(
                              decoration: TextDecoration.underline,
                              decorationColor: buttonColor,
                              color: buttonColor,
                              fontWeight: FontWeight.w500,
                              fontSize: 14.px,
                            )),
                      )
                    ],
                  ),
                  Flex(
                    direction: Axis.horizontal,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                          flex: 1, child: _buildIndicatorAndText("Quality")),
                      Expanded(
                          flex: 1,
                          child: _buildIndicatorAndText("Strong space")),
                      Expanded(
                          flex: 1, child: _buildIndicatorAndText("Design ")),
                      Expanded(
                          flex: 1, child: _buildIndicatorAndText("Durability")),
                    ],
                  ),
                  sizedBoxHeight20,
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Photos',
                        style: GoogleFonts.poppins(
                          // decoration: TextDecoration.lineThrough,
                          // decorationColor: Colors.grey,
                          color: black,
                          fontWeight: FontWeight.w400,
                          fontSize: 13.px,
                        )),
                  ),
                  SizedBox(
                    height: Adaptive.h(10),
                    child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return SizedBox(
                              width: Adaptive.w(23),
                              height: Adaptive.h(7),
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(12.sp),
                                  child: Image.asset(
                                    'assets/images/detailscolor1.png',
                                    fit: BoxFit.fill,
                                  )));
                        },
                        separatorBuilder: (context, index) => sizedBoxWidth10,
                        itemCount: 4),
                  ),
                  sizedBoxHeight30,
                  SizedBox(
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: 3,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            Row(
                              children: [
                                Text('Priya',
                                    style: GoogleFonts.poppins(
                                      // decoration: TextDecoration.lineThrough,
                                      // decorationColor: Colors.grey,
                                      color: black,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14.px,
                                    )),
                                Spacer(),
                                Text('18-03-2024|10:00 AM',
                                    style: GoogleFonts.poppins(
                                      // decoration: TextDecoration.underline,
                                      // decorationColor: buttonColor,
                                      color: grey,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12.px,
                                    ))
                              ],
                            ),
                            Row(
                              children: [
                                VxRating(
                                  size: Adaptive.h(2),
                                  count: 5,
                                  selectionColor: buttonColor,
                                  onRatingUpdate: (value) {},
                                ),
                                Spacer(),
                                Text('18-03-2024|10:00 AM',
                                    style: GoogleFonts.poppins(
                                      // decoration: TextDecoration.underline,
                                      // decorationColor: buttonColor,
                                      color: grey,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12.px,
                                    ))
                              ],
                            ),
                            Text(
                              "is simply dummy text of the printing and type setting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s,",
                              style: GoogleFonts.poppins(
                                  fontSize: 13.px, fontWeight: FontWeight.w500),
                            ),
                            sizedBoxHeight20
                          ],
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
          Positioned(
              bottom: Adaptive.h(10),
              right: Adaptive.w(3),
              child: Image.asset('assets/images/detailsstack.png'))
        ],
      ),
    );
  }

//=================================================================
  Widget _buildIndicatorAndText(String text) {
    return Column(
      children: [
        CircularPercentIndicator(
          radius: Adaptive.w(10),
          lineWidth: 5.0,
          percent: 0.8,
          center: new Text("4.4"),
          progressColor: Colors.green,
        ),
        sizedBoxHeight10,
        Text(
          text,
          style: GoogleFonts.poppins(
            decoration: TextDecoration.underline,
            decorationColor: buttonColor,
            fontWeight: FontWeight.w600,
            fontSize: 12.px,
          ),
          textAlign: TextAlign.center, // Adjust the alignment if needed
        ),
      ],
    );
  }

  Container containerFunctions(String image, String title) {
    return Container(
      padding:
          EdgeInsets.symmetric(horizontal: 12.sp, vertical: Adaptive.h(2.5)),
      decoration: BoxDecoration(
          color: Color(0xffF2F2F2), borderRadius: BorderRadius.circular(10.sp)),
      child: Row(
        children: [
          Image.asset('assets/images/$image.png'),
          sizedBoxWidth20,
          Text('$title ',
              style: GoogleFonts.poppins(
                // decoration: TextDecoration.lineThrough,
                // decorationColor: Colors.grey,
                color: black,
                fontWeight: FontWeight.w500,
                fontSize: 16.px,
              )),
          Spacer(),
          Icon(Icons.keyboard_arrow_right)
        ],
      ),
    );
  }

  Container delivaryContainer() {
    return Container(
      padding: EdgeInsets.all(12.sp),
      decoration: BoxDecoration(
          color: Color(0xffF2F2F2), borderRadius: BorderRadius.circular(10.sp)),
      child: Row(
        children: [
          Image.asset('assets/images/delivary.png'),
          sizedBoxWidth20,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                  text: TextSpan(children: [
                TextSpan(
                    text: 'Free Delivery',
                    style: GoogleFonts.poppins(
                        decoration: TextDecoration.underline,
                        decorationColor: Colors.green,
                        color: Colors.green,
                        fontWeight: FontWeight.w400,
                        fontSize: 16.px)),
                WidgetSpan(
                  child: SizedBox(width: 2.w), // Add space between text spans
                ),
                TextSpan(
                    text: '₹40 ',
                    style: GoogleFonts.poppins(
                        decoration: TextDecoration.lineThrough,
                        decorationColor: Colors.grey,
                        color: grey,
                        fontWeight: FontWeight.w400,
                        fontSize: 16.px)),
                WidgetSpan(
                  child: SizedBox(width: 2.w), // Add space between text spans
                ),
                TextSpan(
                    text: 'Delivery by ',
                    style: GoogleFonts.poppins(
                      // decoration: TextDecoration.lineThrough,
                      // decorationColor: Colors.grey,
                      color: black,
                      fontWeight: FontWeight.w500,
                      fontSize: 16.px,
                    ))
              ])),
              Text('21 Mar, Thursday ',
                  style: GoogleFonts.poppins(
                    // decoration: TextDecoration.lineThrough,
                    // decorationColor: Colors.grey,
                    color: black,
                    fontWeight: FontWeight.w500,
                    fontSize: 16.px,
                  ))
            ],
          )
        ],
      ),
    );
  }
}

class SimilarPopularBrandWidget extends StatelessWidget {
  const SimilarPopularBrandWidget({super.key, required this.index});

  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
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
                  child: Image.asset(
                    'assets/images/wishlist${index + 1}.png',
                    fit: BoxFit.cover,
                    width: 100.w,
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
                        'Levis',
                        style: TextStyle(
                            color: black,
                            fontSize: 13.px,
                            fontWeight: FontWeight.w600),
                      )

                      // Icon(Icons.share,size: 12.sp,color: green,)
                    ],
                  ),
                ),

                // Padding(
                //   padding: const EdgeInsets.only(left: 5),
                //   child: Align(
                //     alignment: Alignment.centerLeft,
                //     child: Text('Neque porro quisquam est qui dolorem ipsum quia',maxLines: 2, style:
                //     TextStyle(color: black,fontSize: 10.px,fontWeight: FontWeight.bold),)),
                // ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'black shing Bag |',
                        style: TextStyle(
                            color: Colors.black38,
                            fontSize: 11.px,
                            fontWeight: FontWeight.w500),
                      ),
                      Spacer(),
                      Text(
                        'MOQ:4 Pcs',
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w400, fontSize: 12.px),
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
                        '6500',
                        style: TextStyle(
                            decoration: TextDecoration.lineThrough,
                            color: Colors.black26,
                            fontSize: 13.px,
                            fontWeight: FontWeight.w500),
                      ),

                      sizedBoxWidth10,
                      Text(
                        '₹ 949',
                        style: TextStyle(
                            color: black,
                            fontSize: 13.px,
                            fontWeight: FontWeight.w600),
                      ),
                      sizedBoxWidth10,
                      Spacer(),
                      Text(
                        '74% off',
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500,
                            fontSize: 13.px,
                            color: Colors.green),
                      ),
                      // Spacer(),
                      // Text(
                      //   'MOQ: 4 Pcs',
                      //   style: GoogleFonts.poppins(
                      //       fontWeight: FontWeight.w400, fontSize: 13.px),
                      // )
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    VxRating(
                      count: 5,
                      selectionColor: buttonColor,
                      onRatingUpdate: (value) {},
                    ),
                    Text(
                      '56890',
                      style: TextStyle(color: grey, fontSize: 12.px),
                    )
                  ],
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Free Delivary By',
                        style: TextStyle(
                            color: Colors.black38,
                            fontSize: 11.px,
                            fontWeight: FontWeight.w500),
                      ),
                      Spacer(),
                      Text(
                        '18 March',
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w400, fontSize: 12.px),
                      )
                    ],
                  ),
                ),
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
    );
  }
}
