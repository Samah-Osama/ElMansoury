import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mansoury/core/di/di.dart';
import 'package:mansoury/core/utils/app_colors.dart';
import 'package:mansoury/features/home/data/repos/products_repo.dart';
import 'package:mansoury/features/home/presentation/view_model/products_cubit/product_cubit.dart';
import 'package:mansoury/features/home/presentation/views/home_view.dart';

void main() {
 WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();
  runApp(const Mansoury());
}

class Mansoury extends StatelessWidget {
  const Mansoury({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ProductCubit(getIt<ProductRepository>()),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Mobile Store',
        theme: ThemeData(
          primaryColor: AppColors.primary,
          scaffoldBackgroundColor: AppColors.background,
          appBarTheme: AppBarTheme(color: AppColors.primary, foregroundColor: Colors.black),
        ),
        home: HomeView(),
      ),
    );
  }
}
