import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_template/features/home/presentation/bloc/category/category_bloc.dart';
import 'package:my_template/features/home/presentation/bloc/products/products_bloc.dart';

import '../core/di/service_locator.dart';

class MyBlocProvider extends StatelessWidget {
  final Widget child;

  const MyBlocProvider({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CategoryBloc>(create: (context) => sl<CategoryBloc>()),
        BlocProvider<ProductsBloc>(create: (context) => sl<ProductsBloc>()),
      ],
      child: child,
    );
  }
}
