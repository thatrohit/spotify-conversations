import 'package:spotify_conversations/models/me.dart';
import 'package:spotify_conversations/utils/api_helpers.dart';

mixin HomeRepository on SpotifyApi {
  Future<Me> getProfile(String token);
}
