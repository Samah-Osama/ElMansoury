import 'package:dartz/dartz.dart'; 
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:mansoury/core/errors/failuer.dart';
import 'package:mansoury/features/home/data/models/products_model.dart';

@injectable
class ProductRemoteDataSource {
  final Dio dio;

  ProductRemoteDataSource(this.dio);

  Future<Either<Failure, List<ProductModel>>> getProducts() async {
    try {
      final response = await dio.get('/products');
      final List<dynamic> data = response.data;

      final products = data
          .where((item) => item['category'] == "electronics")
          .map((item) {
            final title = (item['title'] ?? '').toLowerCase();
            final int ram = _extractRamFromTitle(title) ?? 4; // default to 4GB
            return ProductModel.fromJson(item, ram);
          })
          .toList();

      return Right(products);
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioException(e));
    } catch (e) {
      return Left(ServerFailure(errorMessage: "An unexpected error occurred"));
    }
  }

  /// Extracts RAM size from a product title like "Samsung 8GB" or "iPhone 12GB Max"
  int? _extractRamFromTitle(String title) {
    final ramPattern = RegExp(r'(\d{1,2})\s?(gb)', caseSensitive: false);
    final match = ramPattern.firstMatch(title);
    if (match != null) {
      return int.tryParse(match.group(1)!);
    }
    return null;
  }
}
