import 'package:spotify_conversations/models/playlists.dart';

import '../models/response.dart';
import '../utils/api_helpers.dart';

mixin PlaylistsRepository on SpotifyApi {
  Future<ResponseWrapper<Playlists?>> getCollaborativePlaylists(
    String token,
    int offset,
    int limit,
  );
}
