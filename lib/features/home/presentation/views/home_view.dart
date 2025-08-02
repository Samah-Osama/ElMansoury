// /lib/presentation/view/home_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mansoury/core/utils/app_colors.dart';
import 'package:mansoury/core/utils/app_text_style.dart';
import 'package:mansoury/features/home/presentation/view_model/products_cubit/product_cubit.dart';
import 'package:mansoury/features/home/presentation/views/product_comparason_view.dart';
import 'package:mansoury/features/home/presentation/views/widgets/product_details_view.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final TextEditingController _searchController = TextEditingController();
  double _minPrice = 0;
  double _maxPrice = 1000;
  int _selectedRam = 0;

  @override
  void initState() {
    context.read<ProductCubit>().loadProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "El Mansoury Store",
          style: TextStyle(color: AppColors.textWhite),
        ),
        backgroundColor: AppColors.primary,
        actions: [
          IconButton(
            icon: Icon(Icons.compare, color: AppColors.textWhite),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductComparisonView(),
                ),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Search
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: "Search devices...",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                context.read<ProductCubit>().search(value);
              },
            ),
            SizedBox(height: 10),

            // Filters
            Row(
              children: [
                Expanded(
                  child: Slider(
                    value: _maxPrice,
                    min: 0,
                    max: 1000,
                    onChanged: (value) {
                      setState(() => _maxPrice = value);
                      context.read<ProductCubit>().filterByPriceRange(
                        _minPrice,
                        value,
                      );
                    },
                  ),
                ),
                Text("\EGP${_maxPrice.toInt()}"),
              ],
            ),
            Row(
              spacing: 8,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: (){
                    context.read<ProductCubit>().loadProducts();
                  },
                  child: Text("All" ,style: AppTextStyles.instance.textStyle18)),
                Wrap(
                  spacing: 8,
                  children: [4, 6, 8, 12].map((ram) {
                    return FilterChip(
                      label: Text("$ram GB"),
                      selected: _selectedRam == ram,
                      onSelected: (bool selected) {
                        setState(() {
                          _selectedRam = selected ? ram : 0;
                        });
                        if (selected) {
                          context.read<ProductCubit>().filterByRam(ram);
                        } else {
                          context.read<ProductCubit>().loadProducts();
                        }
                      },
                    );
                  }).toList(),
                ),
              ],
            ),

            SizedBox(height: 10),

            // Products List
            Expanded(
              child: BlocBuilder<ProductCubit, ProductState>(
                builder: (context, state) {
                  if (state is ProductLoading) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (state is ProductError) {
                    return Center(child: Text(state.message));
                  }
                  if (state is ProductLoaded) {
                    return ListView.builder(
                      itemCount: state.products.length,
                      itemBuilder: (context, index) {
                        final product = state.products[index];
                        return Card(
                          child: ListTile(
                            leading: Image.network(product.image, width: 50),
                            title: Text(
                              product.title,
                              style: TextStyle(fontSize: 14),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Price: \$${product.price}"),
                                Text("RAM: ${product.ram} GB"),
                              ],
                            ),
                            trailing: IconButton(
                              icon: Icon(Icons.compare_arrows),
                              onPressed: () {
                                context.read<ProductCubit>().addToComparison(
                                  product,
                                );
                              },
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      ProductDetailsScreen(product: product),
                                ),
                              );
                            },
                          ),
                        );
                      },
                    );
                  }
                  return Container();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
