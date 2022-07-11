// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'detail_page_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$DetailPageStore on _DetailPageStore, Store {
  Computed<bool>? _$hasResultComputed;

  @override
  bool get hasResult =>
      (_$hasResultComputed ??= Computed<bool>(() => super.hasResult,
              name: '_DetailPageStore.hasResult'))
          .value;

  late final _$cityNameAtom =
      Atom(name: '_DetailPageStore.cityName', context: context);

  @override
  String get cityName {
    _$cityNameAtom.reportRead();
    return super.cityName;
  }

  @override
  set cityName(String value) {
    _$cityNameAtom.reportWrite(value, super.cityName, () {
      super.cityName = value;
    });
  }

  late final _$positionAtom =
      Atom(name: '_DetailPageStore.position', context: context);

  @override
  LatLng get position {
    _$positionAtom.reportRead();
    return super.position;
  }

  @override
  set position(LatLng value) {
    _$positionAtom.reportWrite(value, super.position, () {
      super.position = value;
    });
  }

  late final _$forecastFutureAtom =
      Atom(name: '_DetailPageStore.forecastFuture', context: context);

  @override
  ObservableFuture<Forecast?> get forecastFuture {
    _$forecastFutureAtom.reportRead();
    return super.forecastFuture;
  }

  @override
  set forecastFuture(ObservableFuture<Forecast?> value) {
    _$forecastFutureAtom.reportWrite(value, super.forecastFuture, () {
      super.forecastFuture = value;
    });
  }

  late final _$fetchForecastAsyncAction =
      AsyncAction('_DetailPageStore.fetchForecast', context: context);

  @override
  Future<void> fetchForecast() {
    return _$fetchForecastAsyncAction.run(() => super.fetchForecast());
  }

  late final _$_DetailPageStoreActionController =
      ActionController(name: '_DetailPageStore', context: context);

  @override
  void setCityName(String name) {
    final _$actionInfo = _$_DetailPageStoreActionController.startAction(
        name: '_DetailPageStore.setCityName');
    try {
      return super.setCityName(name);
    } finally {
      _$_DetailPageStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setPosition(LatLng latLng) {
    final _$actionInfo = _$_DetailPageStoreActionController.startAction(
        name: '_DetailPageStore.setPosition');
    try {
      return super.setPosition(latLng);
    } finally {
      _$_DetailPageStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setLatLng(double lat, double lng) {
    final _$actionInfo = _$_DetailPageStoreActionController.startAction(
        name: '_DetailPageStore.setLatLng');
    try {
      return super.setLatLng(lat, lng);
    } finally {
      _$_DetailPageStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
cityName: ${cityName},
position: ${position},
forecastFuture: ${forecastFuture},
hasResult: ${hasResult}
    ''';
  }
}
