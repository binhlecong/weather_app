// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_page_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$HomePageStore on _HomePageStore, Store {
  late final _$userLocationWeatherAtom =
      Atom(name: '_HomePageStore.userLocationWeather', context: context);

  @override
  CurrentWeather? get userLocationWeather {
    _$userLocationWeatherAtom.reportRead();
    return super.userLocationWeather;
  }

  @override
  set userLocationWeather(CurrentWeather? value) {
    _$userLocationWeatherAtom.reportWrite(value, super.userLocationWeather, () {
      super.userLocationWeather = value;
    });
  }

  late final _$majorCitiesWeatherAtom =
      Atom(name: '_HomePageStore.majorCitiesWeather', context: context);

  @override
  ObservableList<CurrentWeather?> get majorCitiesWeather {
    _$majorCitiesWeatherAtom.reportRead();
    return super.majorCitiesWeather;
  }

  @override
  set majorCitiesWeather(ObservableList<CurrentWeather?> value) {
    _$majorCitiesWeatherAtom.reportWrite(value, super.majorCitiesWeather, () {
      super.majorCitiesWeather = value;
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
userLocationWeather: ${userLocationWeather},
majorCitiesWeather: ${majorCitiesWeather}
    ''';
  }
}