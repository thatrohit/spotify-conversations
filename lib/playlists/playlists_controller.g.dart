// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'playlists_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$PlaylistsController on _PlaylistsController, Store {
  final _$loadingAtom = Atom(name: '_PlaylistsController.loading');

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

  final _$playlistsAtom = Atom(name: '_PlaylistsController.playlists');

  @override
  Playlists? get playlists {
    _$playlistsAtom.reportRead();
    return super.playlists;
  }

  @override
  set playlists(Playlists? value) {
    _$playlistsAtom.reportWrite(value, super.playlists, () {
      super.playlists = value;
    });
  }

  final _$isHoveredAtom = Atom(name: '_PlaylistsController.isHovered');

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

  final _$fetchPlaylistsAsyncAction =
      AsyncAction('_PlaylistsController.fetchPlaylists');

  @override
  Future<Playlists?> fetchPlaylists() {
    return _$fetchPlaylistsAsyncAction.run(() => super.fetchPlaylists());
  }

  @override
  String toString() {
    return '''
loading: ${loading},
playlists: ${playlists},
isHovered: ${isHovered}
    ''';
  }
}
