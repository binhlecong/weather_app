// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorite_page_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$FavoritePageStore on _FavoritePageStore, Store {
  late final _$favoriteCitiesWeatherAtom =
      Atom(name: '_FavoritePageStore.favoriteCitiesWeather', context: context);

  @override
  ObservableList<CurrentWeather?> get favoriteCitiesWeather {
    _$favoriteCitiesWeatherAtom.reportRead();
    return super.favoriteCitiesWeather;
  }

  @override
  set favoriteCitiesWeather(ObservableList<CurrentWeather?> value) {
    _$favoriteCitiesWeatherAtom.reportWrite(value, super.favoriteCitiesWeather,
        () {
      super.favoriteCitiesWeather = value;
    });
  }

  late final _$getFavoriteCitiesWeatherAsyncAction = AsyncAction(
      '_FavoritePageStore.getFavoriteCitiesWeather',
      context: context);

  @override
  Future<void> getFavoriteCitiesWeather() {
    return _$getFavoriteCitiesWeatherAsyncAction
        .run(() => super.getFavoriteCitiesWeather());
  }

  @override
  String toString() {
    return '''
favoriteCitiesWeather: ${favoriteCitiesWeather}
    ''';
  }
}
