import 'package:spotify_conversations/models/playlist_details.dart';
import 'package:spotify_conversations/utils/api_helpers.dart';

import '../models/response.dart';

mixin DetailsRepository on SpotifyApi {
  Future<ResponseWrapper<PlaylistDetails?>> getPlaylistDetails(
      String token, String playlistId);
  Future<ResponseWrapper<Tracks?>> getTracks(
      String token, String playlistId, int offset, int limit);
}
