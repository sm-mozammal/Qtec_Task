import 'package:qtec_task/features/home/domain/entities/review.dart';

class ReviewModel extends Review {
  ReviewModel({
    required int rating,
    required String comment,
    required DateTime date,
    required String reviewerName,
    required String reviewerEmail,
  }) : super(
          rating: rating,
          comment: comment,
          date: date,
          reviewerName: reviewerName,
          reviewerEmail: reviewerEmail,
        );

  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    return ReviewModel(
      rating: json["rating"] ?? 0,
      comment: json["comment"] ?? '',
      date:
          json["date"] == null ? DateTime.now() : DateTime.parse(json["date"]),
      reviewerName: json["reviewerName"] ?? '',
      reviewerEmail: json["reviewerEmail"] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        "rating": rating,
        "comment": comment,
        "date": date?.toIso8601String(),
        "reviewerName": reviewerName,
        "reviewerEmail": reviewerEmail,
      };
}
