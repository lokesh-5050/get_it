class ProductModel {
  String? sId;
  String? vendorId;
  String? productName;
  String? description;
  List<ImageObj>? image;
  double? originalPrice;
  double? discountPrice;
  int? discount;
  bool? discountActive;
  String? mainCategory;
  String? categoryId;
  String? subCategoryId;
  String? rating;
  int? numOfReviews;
  List<String>? size;
  List<String>? color;
  int? stock;
  bool? status;
  bool? isProductVerified;
  List<Reviews>? reviews;
  String? createdAt;
  String? updatedAt;
  int? iV;
  bool? isDeal;

  ProductModel(
      {this.sId,
      this.vendorId,
      this.productName,
      this.description,
      this.image,
      this.originalPrice,
      this.discountPrice,
      this.discount,
      this.discountActive,
      this.mainCategory,
      this.categoryId,
      this.subCategoryId,
      this.rating,
      this.numOfReviews,
      this.size,
      this.color,
      this.stock,
      this.status,
      this.isProductVerified,
      this.reviews,
      this.createdAt,
      this.updatedAt,
      this.iV,
      this.isDeal});

  ProductModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    vendorId = json['vendorId'];
    productName = json['productName'];
    description = json['description'];
    if (json['image'] != null) {
      image = <ImageObj>[];
      json['image'].forEach((v) {
        image!.add(new ImageObj.fromJson(v));
      });
    }
    originalPrice = json['originalPrice'].toDouble();
    discountPrice = json['discountPrice'].toDouble();
    discount = json['discount'];
    discountActive = json['discountActive'];
    mainCategory = json['mainCategory'];
    categoryId = json['categoryId'];
    subCategoryId = json['subCategoryId'];
    rating = json['rating'].toString();
    numOfReviews = json['numOfReviews'];
    size = json['size'].cast<String>();
    color = json['color'].cast<String>();
    stock = json['stock'];
    status = json['status'];
    isProductVerified = json['isProductVerified'];
    if (json['reviews'] != null) {
      reviews = <Reviews>[];
      json['reviews'].forEach((v) {
        reviews!.add(new Reviews.fromJson(v));
      });
    }
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    isDeal = json['isDeal'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['vendorId'] = this.vendorId;
    data['productName'] = this.productName;
    data['description'] = this.description;
    if (this.image != null) {
      data['image'] = this.image!.map((v) => v.toJson()).toList();
    }
    data['originalPrice'] = this.originalPrice;
    data['discountPrice'] = this.discountPrice;
    data['discount'] = this.discount;
    data['discountActive'] = this.discountActive;
    data['mainCategory'] = this.mainCategory;
    data['categoryId'] = this.categoryId;
    data['subCategoryId'] = this.subCategoryId;
    data['rating'] = this.rating;
    data['numOfReviews'] = this.numOfReviews;
    data['size'] = this.size;
    data['color'] = this.color;
    data['stock'] = this.stock;
    data['status'] = this.status;
    data['isProductVerified'] = this.isProductVerified;
    if (this.reviews != null) {
      data['reviews'] = this.reviews!.map((v) => v.toJson()).toList();
    }
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    data['isDeal'] = this.isDeal;
    return data;
  }
}

class ImageObj {
  String? url;
  String? sId;

  ImageObj({this.url, this.sId});

  ImageObj.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    data['_id'] = this.sId;
    return data;
  }
}

class Reviews {
  String? user;
  String? name;
  int? rating;
  String? comment;
  String? sId;

  Reviews({this.user, this.name, this.rating, this.comment, this.sId});

  Reviews.fromJson(Map<String, dynamic> json) {
    user = json['user'];
    name = json['name'];
    rating = json['rating'];
    comment = json['comment'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user'] = this.user;
    data['name'] = this.name;
    data['rating'] = this.rating;
    data['comment'] = this.comment;
    data['_id'] = this.sId;
    return data;
  }
}
