import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:parcha_app/repositories/hive_operations.repo.dart';

import '../../model/shop_model/shop_model.dart';
import '../../utils/constents.dart';

part 'shop_model_state.dart';

class ShopModelCubit extends Cubit<ShopModelState> {
  final HiveOperationsRepository<ShopModel> repository;

  ShopModelCubit(this.repository) : super(ShopModelInitial()) {
    refreshShop();
  }

  Future<void> refreshShop() async {
    emit(ShopModelLoading());
    try {
      final shops = await repository.getById(KeyContents.shopKey);
      if(shops == null){
        emit(ShopModelAdding());
      }else {
        emit(ShopModelLoaded(shops!));
      }
    } catch (error) {
      emit(ShopModelError(error.toString()));
    }
  }

  Future<void> saveShop(ShopModel shop) async {
    emit(ShopModelLoading());
    try {
      await repository.save(shop, KeyContents.shopKey);
      refreshShop();
    } catch (error) {
      emit(ShopModelError(error.toString()));
    }
  }

  Future<void> deleteShop() async {
    emit(ShopModelLoading());
    try {
      await repository.delete(KeyContents.shopKey);
      refreshShop();
    } catch (error) {
      emit(ShopModelError(error.toString()));
    }
  }
}

