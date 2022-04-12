// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$HomeController on _HomeController, Store {
  final _$profileAtom = Atom(name: '_HomeController.profile');

  @override
  Me? get profile {
    _$profileAtom.reportRead();
    return super.profile;
  }

  @override
  set profile(Me? value) {
    _$profileAtom.reportWrite(value, super.profile, () {
      super.profile = value;
    });
  }

  final _$loadingAtom = Atom(name: '_HomeController.loading');

  @override
  bool get loading {
    _$loadingAtom.reportRead();
    return super.loading;
  }

  @override
  set loading(bool value) {
    _$loadingAtom.reportWrite(value, super.loading, () {
      super.loading = value;
    });
  }

  final _$initProfileAsyncAction = AsyncAction('_HomeController.initProfile');

  @override
  Future<void> initProfile() {
    return _$initProfileAsyncAction.run(() => super.initProfile());
  }

  final _$getProfileAsyncAction = AsyncAction('_HomeController.getProfile');

  @override
  Future<Me?> getProfile(String token) {
    return _$getProfileAsyncAction.run(() => super.getProfile(token));
  }

  final _$getAccessTokenAsyncAction =
      AsyncAction('_HomeController.getAccessToken');

  @override
  Future<String> getAccessToken() {
    return _$getAccessTokenAsyncAction.run(() => super.getAccessToken());
  }

  final _$logoutAsyncAction = AsyncAction('_HomeController.logout');

  @override
  Future<void> logout() {
    return _$logoutAsyncAction.run(() => super.logout());
  }

  @override
  String toString() {
    return '''
profile: ${profile},
loading: ${loading}
    ''';
  }
}
