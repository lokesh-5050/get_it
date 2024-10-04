class CartModel {
  String? sId;
  String? user;
  List<Products>? products;
  String? coupon;
  bool? walletUsed;
  int? shippingPrice;
  double? totalPaidAmount;
  String? createdAt;
  String? updatedAt;
  int? iV;

  CartModel(
      {this.sId,
        this.user,
        this.products,
        this.coupon,
        this.walletUsed,
        this.shippingPrice,
        this.totalPaidAmount,
        this.createdAt,
        this.updatedAt,
        this.iV});

  CartModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    user = json['user'];
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products!.add(new Products.fromJson(v));
      });
    }
    coupon = json['coupon'];
    walletUsed = json['walletUsed'];
    shippingPrice = json['shippingPrice'];
    totalPaidAmount = json['totalPaidAmount'].toDouble();
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['user'] = this.user;
    if (this.products != null) {
      data['products'] = this.products!.map((v) => v.toJson()).toList();
    }
    data['coupon'] = this.coupon;
    data['walletUsed'] = this.walletUsed;
    data['shippingPrice'] = this.shippingPrice;
    data['totalPaidAmount'] = this.totalPaidAmount;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}

class Products {
  Product? product;
  String? vendorId;
  String? size;
  int? quantity;
  double? price;
  double? totalAmount;
  String? sId;

  Products(
      {this.product,
        this.vendorId,
        this.size,
        this.quantity,
        this.price,
        this.totalAmount,
        this.sId});

  Products.fromJson(Map<String, dynamic> json) {
    product =
    json['product'] != null ? new Product.fromJson(json['product']) : null;
    vendorId = json['vendorId'];
    size = json['size'];
    quantity = json['quantity'];
    price = json['price'].toDouble();
    totalAmount = json['totalAmount'].toDouble();
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.product != null) {
      data['product'] = this.product!.toJson();
    }
    data['vendorId'] = this.vendorId;
    data['size'] = this.size;
    data['quantity'] = this.quantity;
    data['price'] = this.price;
    data['totalAmount'] = this.totalAmount;
    data['_id'] = this.sId;
    return data;
  }
}

class Product {
  String? sId;
  String? productName;
  List<ProductImage>? image;

  Product({this.sId, this.productName, this.image});

  Product.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    productName = json['productName'];
    if (json['image'] != null) {
      image = <ProductImage>[];
      json['image'].forEach((v) {
        image!.add(new ProductImage.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['productName'] = this.productName;
    if (this.image != null) {
      data['image'] = this.image!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ProductImage {
  String? url;
  String? sId;

  ProductImage({this.url, this.sId});

  ProductImage.fromJson(Map<String, dynamic> json) {
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