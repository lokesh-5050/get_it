class CategoryModel {
  String? sId;
  String? name;
  String? image;
  bool? status;
  String? mainCategory;
  String? category;

  CategoryModel(
      {this.sId,
      this.name,
      this.image,
      this.status,
      this.mainCategory,
      this.category});

  CategoryModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    image = json['image'];
    status = json['status'];
    mainCategory = json['mainCategory'];
    category = json['category'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['image'] = this.image;
    data['status'] = this.status;
    data['mainCategory'] = this.mainCategory;
    data['category'] = this.category;
    return data;
  }
}
