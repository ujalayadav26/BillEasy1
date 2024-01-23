part of 'shop_model_cubit.dart';

@immutable
abstract class ShopModelState {}

class ShopModelInitial extends ShopModelState {}


class ShopModelLoading extends ShopModelState {}

class ShopModelLoaded extends ShopModelState {
  final ShopModel shops;
  ShopModelLoaded(this.shops);
}

class ShopModelError extends ShopModelState {
  final String error;
  ShopModelError(this.error);
}

class ShopModelAdding extends ShopModelState {}
