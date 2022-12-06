import 'dart:convert';

import 'package:spotify_conversations/models/playlists.dart';
import 'package:spotify_conversations/playlists/playlists_repository.dart';
import 'package:spotify_conversations/utils/api_helpers.dart';
import 'package:http/http.dart' as http;

import '../models/response.dart';

class PlaylistsApiClient implements PlaylistsRepository {
  @override
  Future<ResponseWrapper<Playlists?>> getCollaborativePlaylists(
      String token, int offset, int limit) async {
    ResponseWrapper<Playlists?> response;
    ResponseError? error;
    Map<String, String> query = {
      "offset": offset.toString(),
      "limit": limit.toString()
    };
    final apiRequest = Uri.parse(SpotifyApi.baseUrl +
        SpotifyApi.endpointMyPlaylists +
        "/?" +
        query.entries.map((e) => '${e.key}=${e.value}').join('&'));
    final authHeader = <String, String>{"Authorization": token};
    final playlistHeaders = {...SpotifyApi.apiHeaders};
    playlistHeaders.addEntries(authHeader.entries);
    final apiResponse = await http.get(apiRequest, headers: playlistHeaders);
    if (apiResponse.statusCode != 200) {
      error = ResponseError(apiResponse.statusCode, apiResponse.reasonPhrase);
    }
    final Map<String, dynamic> parsedJson = jsonDecode(apiResponse.body);
    final Playlists result = Playlists.fromJson(parsedJson);
    response = ResponseWrapper(result, error: error);
    return response;
  }
}
