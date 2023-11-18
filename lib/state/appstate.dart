import 'package:flutter/material.dart';
import 'package:openshelves/products/models/product_model.dart';
import 'package:openshelves/scanner/income/income_form.dart';
import 'package:openshelves/warehouse/warehouse_model.dart';
import 'package:openshelves/warehouseplace/warehouseplace_model.dart';

@immutable
class AppState {
  final String _loginToken;
  final List<IncomingModel> _incoming = [];
  Product? _selectedProduct;
  Warehouse? _selectedWarehouse;
  WarehousePlace? _selectedWarehousePlace;

  IncomingStateModel? _incomingStateModel;
  AppState(this._loginToken, this._selectedProduct, this._selectedWarehouse,
      this._selectedWarehousePlace);

  AppState.initialState() : _loginToken = "";
  String get loginToken => _loginToken;
  Product? get selectedProduct => _selectedProduct;
  Warehouse? get selectedWarehouse => _selectedWarehouse;
  WarehousePlace? get selectedWarehousePlace => _selectedWarehousePlace;
  List<IncomingModel> get incoming => _incoming;
  IncomingStateModel? get incomingStateModel => _incomingStateModel;
}

class LogInAction {
  final String _loginToken;

  LogInAction(this._loginToken);
}

class SelectProductAction {
  final Product? _product;

  SelectProductAction(this._product);
}

class SelectWarehouseAction {
  final Warehouse _warehouse;

  SelectWarehouseAction(this._warehouse);
}

class SelectWarehousePlaceAction {
  final WarehousePlace _warehousePlace;

  SelectWarehousePlaceAction(this._warehousePlace);
}

class SelectIncomingStateModelAction {
  final IncomingStateModel _incomingStateModel;

  SelectIncomingStateModelAction(this._incomingStateModel);
}

AppState selectIncomingStateModelReducer(AppState prev, dynamic action) {
  print('selectIncomingStateModelReducer called with action: $action');
  return AppState(prev._loginToken, prev.selectedProduct,
      prev._selectedWarehouse, prev._selectedWarehousePlace);
}

AppState selectWarehousePlaceReducer(AppState prev, dynamic action) {
  print('selectWarehousePlaceReducer called with action: $action');
  return AppState(prev._loginToken, prev.selectedProduct,
      prev._selectedWarehouse, action._warehousePlace);
}

AppState selectWarehouseReducer(AppState prev, dynamic action) {
  print('selectWarehouseReducer called with action: $action');
  return AppState(prev._loginToken, prev.selectedProduct, action._warehouse,
      prev._selectedWarehousePlace);
}

AppState loginReducer(AppState prev, dynamic action) {
  print('loginreducer called with action: $action');
  return AppState(action._loginToken, prev.selectedProduct,
      prev._selectedWarehouse, prev._selectedWarehousePlace);
}

AppState selectProductReducer(AppState prev, dynamic action) {
  print('loginreducer called with action: $action');
  return AppState(prev.loginToken, action._product, prev._selectedWarehouse,
      prev._selectedWarehousePlace);
}

AppState reducer(AppState prev, dynamic action) {
  print('reducer called with action: $action');
  if (action is LogInAction) {
    return loginReducer(prev, action);
  } else if (action is SelectProductAction) {
    return selectProductReducer(prev, action);
  } else if (action is SelectWarehouseAction) {
    return selectWarehouseReducer(prev, action);
  } else if (action is SelectIncomingStateModelAction) {
    return selectIncomingStateModelReducer(prev, action);
  } else if (action is SelectWarehousePlaceAction) {
    return selectWarehousePlaceReducer(prev, action);
  } else {
    return prev;
  }
}
