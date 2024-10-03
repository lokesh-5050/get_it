import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:ecommerce_seller/core/failure.dart';
import 'package:ecommerce_seller/core/shared_pref.dart';
import 'package:ecommerce_seller/utilz/enums.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' as GET;
import 'package:logger/logger.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

final logger = Logger(
  printer: PrettyPrinter(
    methodCount: 2,
    errorMethodCount: 8,
    lineLength: 50,
    colors: true,
    printEmojis: true,
    printTime: true,
  ),
);

class Helpers {
  static Future<String?> getApiToken() async {
    return SharedPrefs.instance.getKey('apiToken');
  }

  static Future<Map<String, dynamic>> getApiHeaders() async {
    String? token = await getApiToken();

    final Map<String, dynamic> headers = {
      'Authorization': 'Bearer $token',
    };
    return headers;
  }

  static String convertFailureToMessage(Failure failure) {
    if (failure is ServerFailure) {
      return failure.message.replaceAll("Exception:", "");
    }
    return "Unknown error occurred";
  }

  static cupertinoAlertPopUp(
    String title,
    Function() onTapAction, {
    String desc = "",
    String optionText = "Okay",
    bool secondOption = false,
    Function()? secondOnTap,
    bool? canHeDismiss,
    String secondOptionText = "Yes",
    bool? isBtnStatusOne = false,
    bool? isBtnStatusTwo = false,
    GET.Rx<Status>? statusOne,
    GET.Rx<Status>? statusTwo,
    bool? isFromSub = false,
  }) {
    return showCupertinoModalPopup(
      context: GET.Get.context!,
      builder: (context) {
        return CupertinoAlertDialog(
            content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 15,
            ),
            Center(
              child: Text(
                title,
                style: Theme.of(GET.Get.context!)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(fontWeight: FontWeight.w400, fontSize: 20.px),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                desc,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(fontWeight: FontWeight.w400, fontSize: 18.px),
              ),
            ),
            SizedBox(
              height: 5.h,
            ),
            const Divider(
              thickness: 2,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                isBtnStatusOne == true && statusOne!.value == Status.loading
                    ? const SizedBox(
                        width: 100,
                        height: 40,
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      )
                    : GestureDetector(
                        onTap: () {
                          onTapAction();
                        },
                        child: Center(
                          child: Container(
                            height: 40,
                            width: 100,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              gradient: isFromSub == true
                                  ? const LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      colors: <Color>[
                                          Color(0xffF05152),
                                          Color(0xffF05152),
                                          Color(0xffF05152),
                                        ])
                                  : const LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      colors: <Color>[
                                          Colors.transparent,
                                          Colors.transparent,
                                        ]),
                              borderRadius: const BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                            child: GestureDetector(
                              onTap: () {
                                onTapAction();
                              },
                              child: Text(
                                optionText,
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  color:
                                      isFromSub == true ? Colors.white : null,
                                  fontSize: 16.px,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                secondOption
                    ? isBtnStatusTwo == true &&
                            statusTwo?.value == Status.loading
                        ? const SizedBox(
                            width: 100,
                            height: 40,
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          )
                        : GestureDetector(
                            onTap: () {
                              secondOnTap!();
                            },
                            child: Center(
                              child: Container(
                                height: 40,
                                width: 100,
                                alignment: Alignment.center,
                                decoration: const BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                child: GestureDetector(
                                  onTap: () {
                                    secondOnTap!();
                                  },
                                  child: Text(
                                    secondOptionText,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 18.px),
                                  ),
                                ),
                              ),
                            ),
                          )
                    : const SizedBox(),
              ],
            ),
          ],
        ));
      },
    );
  }

  static Future<Map<String, dynamic>> sendRequest(
    Dio dio,
    RequestType type,
    String path, {
    Map<String, dynamic>? queryParams,
    Map<String, dynamic>? headers,
    bool encoded = false,
    Map<String, dynamic>? data,
  }) async {
    try {
      log(
        "Request Hitting : ${dio.options.baseUrl}$path , data : $data, queryParams : $queryParams",
      );

      Response response;
      switch (type) {
        case RequestType.get:
          response = await dio.get(path,
              queryParameters: queryParams,
              options: Options(
                headers: headers ?? await getApiHeaders(),
                followRedirects: true,
                validateStatus: (status) {
                  return status! < 500;
                },
              ));
          break;
        case RequestType.post:
          response = (await dio.post(path,
              options: Options(
                headers: headers ?? await getApiHeaders(),
                contentType:
                    encoded == true ? Headers.formUrlEncodedContentType : null,
                validateStatus: (code) => true,
              ),
              data: queryParams ?? FormData.fromMap(data ?? {})));
          break;
        case RequestType.patch:
          response = (await dio.patch(path,
              options: Options(
                headers: headers ?? await getApiHeaders(),
                contentType:
                    encoded == true ? Headers.formUrlEncodedContentType : null,
                validateStatus: (code) => true,
              ),
              data: queryParams ?? FormData.fromMap(data ?? {})));
          break;
        case RequestType.delete:
          response = (await dio.delete(path,
              data: queryParams ?? FormData.fromMap(data ?? {}),
              queryParameters: queryParams,
              options: Options(headers: headers ?? await getApiHeaders())));
          break;
        case RequestType.put:
          response = (await dio.put(path,
              data: queryParams ?? FormData.fromMap(data ?? {}),
              queryParameters: queryParams,
              options: Options(headers: headers ?? await getApiHeaders())));
          break;
        default:
          response = await dio.get(path,
              queryParameters: queryParams,
              options: Options(headers: headers ?? await getApiHeaders()));
          break;
      }

      if (response.statusCode == 200 || response.statusCode == 202) {
        logger.d(
            "Path :: $path\n${dio.options.baseUrl}$path ,\nRequestType => $type,\npayLoad => ${queryParams ?? data}\nSuccess Data => ${response.data}");
        return response.data as Map<String, dynamic>;
      } else if (response.statusCode == 400) {
        logger.d(
            "Path /$path\nStatus Code ${response.statusCode} \nResponse ${response.data}");
        throw Exception(response.data['message']);
      } else if (response.statusCode == 404) {
        throw Exception(response.data['message']);
      } else if (response.statusCode == 500) {
        throw Exception(response.data);
      } else {
        debugPrint(response.data.toString());
        throw Exception(response.data['message'].toString());
      }
    } on SocketException {
      throw await Helpers.cupertinoAlertPopUp("Internet Error", () {});
    }
  }
}
