class ProductModel {
  int id;
  int catid;
  String productname;
  double price;
  String image;
  String description;

  ProductModel({
    required this.id,
    required this.catid,
    required this.productname,
    required this.price,
    required this.image,
    required this.description,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        id: json["id"],
        catid: json["catid"],
        productname: json["productname"],
        price: json["price"]?.toDouble() ?? 0.0,
        image: json["image"],
        description: json["description"],
      );
}