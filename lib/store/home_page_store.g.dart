// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_page_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$HomePageStore on _HomePageStore, Store {
  Computed<bool>? _$hasGetMajorCitiesWeatherCompletedComputed;

  @override
  bool get hasGetMajorCitiesWeatherCompleted =>
      (_$hasGetMajorCitiesWeatherCompletedComputed ??= Computed<bool>(
              () => super.hasGetMajorCitiesWeatherCompleted,
              name: '_HomePageStore.hasGetMajorCitiesWeatherCompleted'))
          .value;

  late final _$userLocationWeatherFutureAtom =
      Atom(name: '_HomePageStore.userLocationWeatherFuture', context: context);

  @override
  ObservableFuture<CurrentWeather?> get userLocationWeatherFuture {
    _$userLocationWeatherFutureAtom.reportRead();
    return super.userLocationWeatherFuture;
  }

  @override
  set userLocationWeatherFuture(ObservableFuture<CurrentWeather?> value) {
    _$userLocationWeatherFutureAtom
        .reportWrite(value, super.userLocationWeatherFuture, () {
      super.userLocationWeatherFuture = value;
    });
  }

  late final _$majorCitiesWeatherFuturesAtom =
      Atom(name: '_HomePageStore.majorCitiesWeatherFutures', context: context);

  @override
  ObservableFuture<List<CurrentWeather?>> get majorCitiesWeatherFutures {
    _$majorCitiesWeatherFuturesAtom.reportRead();
    return super.majorCitiesWeatherFutures;
  }

  @override
  set majorCitiesWeatherFutures(ObservableFuture<List<CurrentWeather?>> value) {
    _$majorCitiesWeatherFuturesAtom
        .reportWrite(value, super.majorCitiesWeatherFutures, () {
      super.majorCitiesWeatherFutures = value;
    });
  }

  late final _$getUserLocationWeatherAsyncAction =
      AsyncAction('_HomePageStore.getUserLocationWeather', context: context);

  @override
  Future<void> getUserLocationWeather() {
    return _$getUserLocationWeatherAsyncAction
        .run(() => super.getUserLocationWeather());
  }

  late final _$getMajorCitiesWeatherAsyncAction =
      AsyncAction('_HomePageStore.getMajorCitiesWeather', context: context);

  @override
  Future<void> getMajorCitiesWeather() {
    return _$getMajorCitiesWeatherAsyncAction
        .run(() => super.getMajorCitiesWeather());
  }

  @override
  String toString() {
    return '''
userLocationWeatherFuture: ${userLocationWeatherFuture},
majorCitiesWeatherFutures: ${majorCitiesWeatherFutures},
hasGetMajorCitiesWeatherCompleted: ${hasGetMajorCitiesWeatherCompleted}
    ''';
  }
}
