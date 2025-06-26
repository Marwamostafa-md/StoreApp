import 'package:flutter/material.dart';
import 'package:storeapp/presentation/productbloc/product_bloc.dart';
import 'package:storeapp/presentation/screens/products_page.dart';
import 'injection_container.dart' as di;
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => di.getIt<ProductBloc>()..add(GetAllProductsEvent()),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: ProductsPage(),
      ),
    ),
  );
}
