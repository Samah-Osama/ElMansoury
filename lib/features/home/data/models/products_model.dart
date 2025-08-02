import 'package:equatable/equatable.dart';

class ProductModel extends Equatable {
  final int id;
  final String title;
  final double price;
  final String image;
  final String category;
  final int ram;
  final int storage; // مثلاً 64, 128, 256 GB
  final String camera; // مثلاً "48 MP + 12 MP"
  final int battery; // بالمللي أمبير
  final String processor; // معالج

  ProductModel({
    required this.id,
    required this.title,
    required this.price,
    required this.image,
    required this.category,
    required this.ram,
    required this.storage,
    required this.camera,
    required this.battery,
    required this.processor,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json, int ram) {
    return ProductModel(
      id: json['id'],
      title: json['title'],
      price: json['price'].toDouble(),
      image: json['image'],
      category: json['category'],
      ram: ram,
      storage: _extractStorage(json['title']), // نستنتج من الاسم أو نخليه ثابت
      camera: _extractCamera(json['title']),
      battery: _extractBattery(json['title']),
      processor: _extractProcessor(json['title']),
    );
  }

  // دوال مساعدة لاستخلاص بيانات وهمية (لأن الـ API الأصلي ما بيحتش كده)
  static int _extractStorage(String title) {
    if (title.toLowerCase().contains('128')) return 128;
    if (title.toLowerCase().contains('256')) return 256;
    if (title.toLowerCase().contains('64')) return 64;
    return 128;
  }

  static String _extractCamera(String title) {
    if (title.toLowerCase().contains('pro')) return "48 MP + 12 MP + 8 MP";
    if (title.toLowerCase().contains('max')) return "64 MP + 12 MP";
    return "48 MP";
  }

  static int _extractBattery(String title) {
    if (title.toLowerCase().contains('max')) return 5000;
    if (title.toLowerCase().contains('plus')) return 4500;
    return 4000;
  }

  static String _extractProcessor(String title) {
    if (title.toLowerCase().contains('pro')) return "Snapdragon 8 Gen 3";
    if (title.toLowerCase().contains('max')) return "Apple A17 Pro";
    return "Snapdragon 7 Gen 2";
  }

  @override
  List<Object?> get props => [id, title, price, image, category, ram, storage, camera, battery, processor];
}