import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:mansoury/core/utils/app_colors.dart';
import 'package:mansoury/features/home/data/models/products_model.dart';
import 'package:mansoury/features/home/presentation/view_model/products_cubit/product_cubit.dart';

class ProductDetailsScreen extends StatelessWidget {
  final ProductModel product;

  const ProductDetailsScreen({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Product Details", style: TextStyle(color: AppColors.text)),
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.text,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // صورة المنتج
            Container(
              width: double.infinity,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.network(
                  product.image,
                  height: 300,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 16),

            // اسم المنتج
            Text(
              product.title,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.text,
              ),
            ),
            SizedBox(height: 8),

            // السعر
            Text(
              "Price: \$${product.price.toStringAsFixed(2)}",
              style: TextStyle(
                fontSize: 18,
                color: AppColors.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),

            // الجدول التفصيلي
            _buildDetailRow("RAM", "${product.ram} GB"),
            _buildDetailRow("Storage", "${product.storage} GB"),
            _buildDetailRow("Camera", product.camera),
            _buildDetailRow("Battery", "${product.battery} mAh"),
            _buildDetailRow("Processor", product.processor),
            _buildDetailRow("Category", product.category),

            SizedBox(height: 30),

            // زر المقارنة
            Center(
              child: ElevatedButton.icon(
                onPressed: () {
                  context.read<ProductCubit>().addToComparison(product);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("${product.title} added to comparison!")),
                  );
                },
                icon: Icon(Icons.compare_arrows, size: 18),
                label: Text("Add to Compare"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: AppColors.text,
                fontSize: 15,
              ),
            ),
          ),
          Expanded(
            child: Text(
              " : $value",
              style: TextStyle(fontSize: 15, color: AppColors.text),
            ),
          ),
        ],
      ),
    );
  }
}