import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:mansoury/core/errors/failuer.dart';
import 'package:mansoury/features/home/data/data_source/product_remote_data_source.dart';
import 'package:mansoury/features/home/data/models/products_model.dart';

@injectable
class ProductRepository {
  final ProductRemoteDataSource dataSource;

  ProductRepository(this.dataSource);

  Future<Either<Failure, List<ProductModel>>> getProducts() async {
    return await dataSource.getProducts();
  }
}