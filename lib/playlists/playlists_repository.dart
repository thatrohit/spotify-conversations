import 'package:spotify_conversations/models/playlists.dart';

import '../utils/api_helpers.dart';

mixin PlaylistsRepository on SpotifyApi {
  Future<Playlists> getCollaborativePlaylists(
    String token,
    int offset,
    int limit,
  );
}
