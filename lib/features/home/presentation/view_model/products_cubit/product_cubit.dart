import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:mansoury/features/home/data/models/products_model.dart';
import 'package:mansoury/features/home/data/repos/products_repo.dart';
import 'package:mansoury/features/home/presentation/views/widgets/product_comparison_bottom_sheet.dart';


part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  final ProductRepository repository;

  ProductCubit(this.repository) : super(ProductInitial());

  List<ProductModel> allProducts = [];
  List<ProductModel> filteredProducts = [];
  List<ProductModel> comparedProducts = [];

  void loadProducts() async {
    emit(ProductLoading());
    final result = await repository.getProducts();

    result.fold(
      (failure) {
        emit(ProductError(failure.errorMessage));
      },
      (products) {
        allProducts = products;
        filteredProducts = products;
        emit(ProductLoaded(filteredProducts));
      },
    );
  }

  void search(String query) {
  if (query.isEmpty) {
    filteredProducts = allProducts;
  } else {
    // حاول نشوف هل المدخل رقم (يعني يقصد سعر)
    final queryNum = double.tryParse(query);

    if (queryNum != null) {
      // لو كان رقم، نبحث بالسعر (نسمح بفارق ±100)
      // final minPrice = queryNum - 100;
      // final maxPrice = queryNum + 100;

      filteredProducts = allProducts
          .where((product) => product.price.toString().contains(query.toLowerCase().trim()))
          .toList();
    } else {
      // لو مش رقم، نبحث بالاسم
      filteredProducts = allProducts
          .where((product) =>
              product.title.toLowerCase().contains(query.toLowerCase().trim()))
          .toList();
    }
  }
  emit(ProductLoaded(filteredProducts));
}

  void filterByPriceRange(double min, double max) {
    filteredProducts = allProducts
        .where((product) => product.price >= min && product.price <= max)
        .toList();
    emit(ProductLoaded(filteredProducts));
  }

  void filterByRam(int ram) {
    if (ram == 0) {
      filteredProducts = allProducts;
    } else {
      filteredProducts = allProducts
          .where((product) => product.ram == ram)
          .toList();
    }
    emit(ProductLoaded(filteredProducts));
  }

  void addToComparison(ProductModel product) {
    if (!comparedProducts.contains(product)) {
      comparedProducts.add(product);
    }
    emit(ProductCompared(comparedProducts));
  }

  void removeFromComparison(ProductModel product) {
    comparedProducts.remove(product);
    emit(ProductCompared(comparedProducts));
  }
//   void showComparisonBottomSheet(BuildContext context) {
//   showModalBottomSheet(
//     context: context,
//     isScrollControlled: true,
//     shape: RoundedRectangleBorder(
//       borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
//     ),
//     builder: (context) {
//       return ProductComparisonBottomSheet();
//     },
//   );
// }
}