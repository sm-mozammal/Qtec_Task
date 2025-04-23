// data/models/product_model.dart

import 'package:qtec_task/features/home/data/models/review_model.dart';
import 'package:qtec_task/features/home/domain/entities/product.dart';

class ProductModel extends Product {
  ProductModel(
      {super.id,
      super.title,
      super.description,
      super.category,
      super.price,
      super.discountPercentage,
      super.rating,
      super.stock,
      super.tags,
      super.brand,
      super.sku,
      super.weight,
      super.warrantyInformation,
      super.shippingInformation,
      super.availabilityStatus,
      super.returnPolicy,
      super.minimumOrderQuantity,
      super.images,
      super.thumbnail,
      super.reviews});

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      category: json['category'],
      price: (json['price'] ?? 0).toDouble(),
      discountPercentage: (json['discountPercentage'] ?? 0).toDouble(),
      rating: (json['rating'] ?? 0).toDouble(),
      stock: json['stock'],
      tags: json['tags'] == null ? [] : List<String>.from(json['tags']),
      brand: json['brand'],
      sku: json['sku'],
      weight: json['weight'],
      warrantyInformation: json['warrantyInformation'],
      shippingInformation: json['shippingInformation'],
      availabilityStatus: json['availabilityStatus'],
      returnPolicy: json['returnPolicy'],
      minimumOrderQuantity: json['minimumOrderQuantity'],
      images: json['images'] == null ? [] : List<String>.from(json['images']),
      thumbnail: json['thumbnail'],
      reviews: json["reviews"] == null
          ? []
          : List<ReviewModel>.from(
              json["reviews"].map((x) => ReviewModel.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "category": category,
        "price": price,
        "discountPercentage": discountPercentage,
        "rating": rating,
        "stock": stock,
        "tags": tags,
        "brand": brand,
        "sku": sku,
        "weight": weight,
        "warrantyInformation": warrantyInformation,
        "shippingInformation": shippingInformation,
        "availabilityStatus": availabilityStatus,
        "returnPolicy": returnPolicy,
        "minimumOrderQuantity": minimumOrderQuantity,
        "images": images,
        "thumbnail": thumbnail,
        "reviews": reviews == null
            ? []
            : List<Map<String, dynamic>>.from(
                (reviews as List<ReviewModel>).map((x) => x.toJson())),
      };
}
