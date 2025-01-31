
import 'package:hive/hive.dart';

part 'product_model.g.dart'; // This must be at the top


@HiveType(typeId: 0)
class Product {
  @HiveField(0)
  int? id;
  @HiveField(1)
  String? name;
  @HiveField(2)
  String? brand;
  @HiveField(3)
  double? originalPrice;
  @HiveField(4)
  double? discountedPrice;
  @HiveField(5)
  String? imageUrl;
  @HiveField(6)
  List<String>? imagesUrl;
  @HiveField(7)
  String? description;
  @HiveField(8)
  int? quantityAvailable;
  @HiveField(9)
  String? category;
  @HiveField(10)
  double? rating;

  Product(
      {this.id,
        this.name,
        this.brand,
        this.originalPrice,
        this.discountedPrice,
        this.imageUrl,
        this.imagesUrl,
        this.description,
        this.quantityAvailable,
        this.category,
        this.rating});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    brand = json['brand'];
    originalPrice = json['original_price'];
    discountedPrice = json['discounted_price'];
    imageUrl = json['image_url'];
    imagesUrl = json['images_url'].cast<String>();
    description = json['description'];
    quantityAvailable = json['quantity_available'];
    category = json['category'];
    rating = json['rating'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['brand'] = this.brand;
    data['original_price'] = this.originalPrice;
    data['discounted_price'] = this.discountedPrice;
    data['image_url'] = this.imageUrl;
    data['images_url'] = this.imagesUrl;
    data['description'] = this.description;
    data['quantity_available'] = this.quantityAvailable;
    data['category'] = this.category;
    data['rating'] = this.rating;
    return data;
  }
}
