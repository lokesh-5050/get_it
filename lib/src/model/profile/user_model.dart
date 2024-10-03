class UserModel {
  User? user;
  String? memberSince;

  UserModel({this.user, this.memberSince});

  UserModel.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    memberSince = json['memberSince'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    data['memberSince'] = this.memberSince;
    return data;
  }
}

class User {
  FactoryLocation? factoryLocation;
  String? sId;
  String? userName;
  String? mobileNumber;
  String? email;
  String? password;
  String? otp;
  bool? isVerified;
  bool? isVendorVerified;
  int? wallet;
  String? userType;
  String? referralCode;
  String? referredBy;
  List<String>? dummyImage;
  String? createdAt;
  String? updatedAt;
  int? iV;
  bool? retailShop;

  User(
      {this.factoryLocation,
        this.sId,
        this.userName,
        this.mobileNumber,
        this.email,
        this.password,
        this.otp,
        this.isVerified,
        this.isVendorVerified,
        this.wallet,
        this.userType,
        this.referralCode,
        this.referredBy,
        this.dummyImage,
        this.createdAt,
        this.updatedAt,
        this.iV,
        this.retailShop});

  User.fromJson(Map<String, dynamic> json) {
    factoryLocation = json['factoryLocation'] != null
        ? new FactoryLocation.fromJson(json['factoryLocation'])
        : null;
    sId = json['_id'];
    userName = json['userName'];
    mobileNumber = json['mobileNumber'];
    email = json['email'];
    password = json['password'];
    otp = json['otp'];
    isVerified = json['isVerified'];
    isVendorVerified = json['isVendorVerified'];
    wallet = json['wallet'];
    userType = json['userType'];
    referralCode = json['referralCode'];
    referredBy = json['referredBy'];
    if (json['dummyImage'] != null) {
      dummyImage = <String>[];
      json['dummyImage'].forEach((v) {
        dummyImage!.add(v);
      });
    }
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    retailShop = json['retailShop'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.factoryLocation != null) {
      data['factoryLocation'] = this.factoryLocation!.toJson();
    }
    data['_id'] = this.sId;
    data['userName'] = this.userName;
    data['mobileNumber'] = this.mobileNumber;
    data['email'] = this.email;
    data['password'] = this.password;
    data['otp'] = this.otp;
    data['isVerified'] = this.isVerified;
    data['isVendorVerified'] = this.isVendorVerified;
    data['wallet'] = this.wallet;
    data['userType'] = this.userType;
    data['referralCode'] = this.referralCode;
    data['referredBy'] = this.referredBy;
    if (this.dummyImage != null) {
      data['dummyImage'] = this.dummyImage!.map((v) => v).toList();
    }
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    data['retailShop'] = this.retailShop;
    return data;
  }
}

class FactoryLocation {
  String? type;
  List<int>? coordinates;

  FactoryLocation({this.type, this.coordinates});

  FactoryLocation.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    coordinates = json['coordinates'].cast<int>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['coordinates'] = this.coordinates;
    return data;
  }
}