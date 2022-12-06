// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'details_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$DetailsController on _DetailsController, Store {
  final _$loadingAtom = Atom(name: '_DetailsController.loading');

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

  final _$isHoveredAtom = Atom(name: '_DetailsController.isHovered');

  @override
  bool get isHovered {
    _$isHoveredAtom.reportRead();
    return super.isHovered;
  }

  @override
  set isHovered(bool value) {
    _$isHoveredAtom.reportWrite(value, super.isHovered, () {
      super.isHovered = value;
    });
  }

  final _$tracksAtom = Atom(name: '_DetailsController.tracks');

  @override
  Tracks? get tracks {
    _$tracksAtom.reportRead();
    return super.tracks;
  }

  @override
  set tracks(Tracks? value) {
    _$tracksAtom.reportWrite(value, super.tracks, () {
      super.tracks = value;
    });
  }

  final _$fetchTracksAsyncAction =
      AsyncAction('_DetailsController.fetchTracks');

  @override
  Future<Tracks?> fetchTracks(String playlistId) {
    return _$fetchTracksAsyncAction.run(() => super.fetchTracks(playlistId));
  }

  @override
  String toString() {
    return '''
loading: ${loading},
isHovered: ${isHovered},
tracks: ${tracks}
    ''';
  }
}
