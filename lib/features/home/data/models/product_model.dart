class ProductModel {
  final int? id; // Changed to int? to match API
  final String? title;
  final String? description;
  final String? imageUrl;
  final double? price;
  final String? category;
  final double? rating;
       final double? discountPercentage;
  ProductModel( {
    this.id,
    this.title,
    this.description,
    this.imageUrl,
    this.price,
    this.category,
    this.rating,
    this.discountPercentage
  });
  factory ProductModel.fromJson(Map<String,dynamic> json){
    return ProductModel(
       id: json['id'] as int?,
      title: json['title'] as String?,
      description: json['description'] as String?,
      imageUrl: json['thumbnail'] as String?,
      price: (json['price'] as num?)?.toDouble(),
      category: json['category'] as String?,
      rating: (json['rating'] as num?)?.toDouble(),
      discountPercentage:(json['discountPercentage'] as num?)?.toDouble(),
    );
  }
}