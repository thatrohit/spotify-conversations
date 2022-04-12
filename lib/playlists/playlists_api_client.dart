import 'dart:convert';

import 'package:spotify_conversations/models/playlists.dart';
import 'package:spotify_conversations/playlists/playlists_repository.dart';
import 'package:spotify_conversations/utils/api_helpers.dart';
import 'package:http/http.dart' as http;

class PlaylistsApiClient implements PlaylistsRepository {
  @override
  Future<Playlists> getCollaborativePlaylists(String token) async {
    final apiRequest =
        Uri.parse(SpotifyApi.baseUrl + SpotifyApi.endpointMyPlaylists);
    final authHeader = <String, String>{"Authorization": token};
    final meHeaders = {...SpotifyApi.apiHeaders};
    meHeaders.addEntries(authHeader.entries);
    final apiResponse = await http.get(apiRequest, headers: meHeaders);
    if (apiResponse.statusCode != 200) {
      throw Exception(
          "The network returned a failure. Please try again after some time");
    }
    final Map<String, dynamic> parsedJson = jsonDecode(apiResponse.body);
    final Playlists result = Playlists.fromJson(parsedJson);
    return result;
  }
}
