import 'package:mobx/mobx.dart';

part 'playlists_controller.g.dart';

class PlaylistsController = _PlaylistsController with _$PlaylistsController;

abstract class _PlaylistsController with Store {
  @observable
  bool loading = false;
}
