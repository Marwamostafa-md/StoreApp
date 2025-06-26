import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:storeapp/presentation/mapper/to_ui_model.dart';
import 'package:storeapp/presentation/uimodel/product.dart';

import '../../core/error/failures.dart';
import '../../domain/usecases/get_all_ products.dart';

part 'product_event.dart';

part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final GetAllProductsUseCase getAllProductUseCase;

  ProductBloc({required this.getAllProductUseCase}) : super(ProductInitial()) {
    on<ProductEvent>((event, emit) async {
      emit(LoadingProductState());
      print("loading/////////////////");
      final failureOrPosts = await getAllProductUseCase();
      failureOrPosts.fold(
        (failure) {
          emit(ErrorProductState(message: mapFailureToMessage(failure)));
          print("error state/////////////////");
        },
        (products) {
          emit(
            LoadedProductState(
              products: products.map((e) => e.toUiModel()).toList(),
            ),
          );
        },
      );
    });
  }

  String mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return ("please try again later");
      case EmptyCacheFailure:
        return ("No products");
      case OffLineFailure:
        return ("Please check your internet connection");
      default:
        return ("Unexpected Error,please try again later");
    }
  }
}
