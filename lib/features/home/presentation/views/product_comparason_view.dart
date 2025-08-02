// /lib/presentation/view/product_comparison_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mansoury/core/utils/app_colors.dart';
import 'package:mansoury/features/home/data/models/products_model.dart';
import 'package:mansoury/features/home/presentation/view_model/products_cubit/product_cubit.dart';

class ProductComparisonView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Compare Devices", style: TextStyle(color: AppColors.text)),
        backgroundColor: AppColors.primary,
        actions: [
          IconButton(
            icon: Icon(Icons.close, color: AppColors.text),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
      body: BlocBuilder<ProductCubit, ProductState>(
        builder: (context, state) {
          if (state is ProductCompared) {
            final products = state.comparedProducts;

            if (products.isEmpty) {
              return Center(child: Text("No devices added for comparison"));
            }

            return Column(
              children: [
                // Header: Scrollable devices (as columns)
                SizedBox(
                  height: 500,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        for (var product in products)
                          _buildComparisonColumn(context, product),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }
          return Center(child: Text("Compare your devices here"));
        },
      ),
    );
  }

  Widget _buildComparisonColumn(BuildContext context, ProductModel product) {
    return Container(
      width: 280,
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.primary.withOpacity(0.3)),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          // Device Image
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
            child: Image.network(
              product.image,
              height: 120,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),

          // Device Title
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              product.title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: AppColors.text,
              ),
              textAlign: TextAlign.center,
            ),
          ),

          // Divider
          Divider(color: AppColors.border, height: 1),

          // Price
          _buildRow("Price", "\$${product.price.toStringAsFixed(2)}"),

          // RAM
          _buildRow("RAM", "${product.ram} GB"),

          // Storage (لو متوفر، أو نضيفه لاحقًا)
          _buildRow("Storage", "128 GB"),

          // Camera (افتراضي)
          _buildRow("Camera", "48 MP"),

          // Battery
          _buildRow("Battery", "5000 mAh"),

          // Spacer
          SizedBox(height: 16),

          // Delete Button
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ElevatedButton.icon(
              onPressed: () {
                context.read<ProductCubit>().removeFromComparison(product);
              },
              icon: Icon(Icons.delete, size: 18, color: Colors.white),
              label: Text("Remove", style: TextStyle(color: Colors.white)),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                padding: EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRow(String label, String value) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Text(
              label,
              style: TextStyle(
                color: AppColors.text,
                fontSize: 14,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              value,
              style: TextStyle(
                color: AppColors.text,
                fontWeight: FontWeight.w500,
                fontSize: 14,
              ),
              textAlign: TextAlign.end,
            ),
          ),
        ],
      ),
    );
  }
}