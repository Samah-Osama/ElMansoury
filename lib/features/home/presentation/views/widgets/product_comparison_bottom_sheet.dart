// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:mansoury/core/utils/app_colors.dart';
// import 'package:mansoury/features/home/data/models/products_model.dart';
// import 'package:mansoury/features/home/presentation/view_model/products_cubit/product_cubit.dart';

// class ProductComparisonBottomSheet extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<ProductCubit, ProductState>(
//       builder: (context, state) {
//         if (state is ProductCompared) {
//           final products = state.comparedProducts;

//           if (products.isEmpty) {
//             return Container(
//               padding: EdgeInsets.all(16),
//               child: Center(
//                 child: Text(
//                   "No devices added for comparison",
//                   style: TextStyle(color: AppColors.text),
//                 ),
//               ),
//             );
//           }

//           return Container(
//             padding: EdgeInsets.all(16),
//             child: SingleChildScrollView(
//               child: Column(
//                 children: [
//                   // عنوان
//                   Text(
//                     "Compare Devices",
//                     style: TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                       color: AppColors.text,
//                     ),
//                   ),
//                   SizedBox(height: 16),

//                   // الأجهزة جنب بعض
//                   SizedBox(
//                     height: 400,
//                     child: SingleChildScrollView(
//                       scrollDirection: Axis.horizontal,
//                       child: Row(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: products
//                             .map((product) => _buildComparisonColumn(context, product))
//                             .toList(),
//                       ),
//                     ),
//                   ),

//                   // زر الإغلاق
//                   SizedBox(height: 16),
//                   ElevatedButton(
//                     onPressed: () => Navigator.pop(context),
//                     child: Text("Close"),
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: AppColors.primary,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           );
//         }
//         return Container(
//           padding: EdgeInsets.all(16),
//           child: Center(child: CircularProgressIndicator()),
//         );
//       },
//     );
//   }

//   Widget _buildComparisonColumn(BuildContext context, ProductModel product) {
//     return Container(
//       width: 260,
//       margin: EdgeInsets.symmetric(horizontal: 8),
//       decoration: BoxDecoration(
//         border: Border.all(color: AppColors.primary.withOpacity(0.3)),
//         borderRadius: BorderRadius.circular(12),
//       ),
//       child: Column(
//         children: [
//           // صورة الجهاز
//           ClipRRect(
//             borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
//             child: Image.network(
//               product.image,
//               height: 100,
//               width: double.infinity,
//               fit: BoxFit.cover,
//             ),
//           ),

//           // اسم الجهاز
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Text(
//               product.title,
//               style: TextStyle(
//                 fontWeight: FontWeight.bold,
//                 fontSize: 14,
//                 color: AppColors.text,
//               ),
//               textAlign: TextAlign.center,
//             ),
//           ),

//           Divider(color: AppColors.border, height: 1),

//           // السعر
//           _buildRow("Price", "\$${product.price}"),
//           _buildRow("RAM", "${product.ram} GB"),
//           _buildRow("Storage", "${product.storage} GB"),
//           _buildRow("Camera", product.camera),
//           _buildRow("Battery", "${product.battery} mAh"),
//           _buildRow("Processor", product.processor.split(" ").sublist(0, 2).join(" ")),
//         ],
//       ),
//     );
//   }

//   Widget _buildRow(String label, String value) {
//     return Container(
//       padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//       child: Row(
//         children: [
//           Expanded(
//             flex: 1,
//             child: Text(
//               label,
//               style: TextStyle(fontSize: 12, color: AppColors.),
//             ),
//           ),
//           Expanded(
//             flex: 2,
//             child: Text(
//               value,
//               style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
//               textAlign: TextAlign.end,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }