part of 'product_bloc.dart';

@immutable
sealed class ProductState {}

final class ProductInitial extends ProductState {}
class LoadingProductState extends ProductState {}

class LoadedProductState extends ProductState {
  final List<ProductUiModel> products;

  LoadedProductState({required this.products});

  @override
  List<Object?> get props => [products];
}

class ErrorProductState extends ProductState {
  final String message;

  ErrorProductState({required this.message});

  @override
  List<Object?> get props => [message];
}
