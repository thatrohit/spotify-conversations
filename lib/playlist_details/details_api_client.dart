import 'dart:convert';

import 'package:spotify_conversations/models/playlist_details.dart';
import 'package:spotify_conversations/playlist_details/details_repository.dart';
import 'package:spotify_conversations/utils/api_helpers.dart';
import 'package:http/http.dart' as http;

import '../models/response.dart';

class DetailsApiClient implements DetailsRepository {
  @override
  Future<ResponseWrapper<PlaylistDetails?>> getPlaylistDetails(
      String token, String playlistId) async {
    ResponseWrapper<PlaylistDetails?> response;
    ResponseError? error;
    final apiRequest = Uri.parse(
        SpotifyApi.baseUrl + SpotifyApi.endpointPlaylistDetails(playlistId));
    final authHeader = <String, String>{"Authorization": token};
    final apiResponse = await http.get(apiRequest, headers: authHeader);
    if (apiResponse.statusCode != 200) {
      error = ResponseError(apiResponse.statusCode, apiResponse.reasonPhrase);
    }
    final Map<String, dynamic> parsedJson = jsonDecode(apiResponse.body);
    final PlaylistDetails result = PlaylistDetails.fromJson(parsedJson);
    response = ResponseWrapper(result, error: error);
    return response;
  }

  @override
  Future<ResponseWrapper<Tracks?>> getTracks(
      String token, String playlistId, int offset, int limit) async {
    ResponseWrapper<Tracks?> response;
    ResponseError? error;
    Map<String, String> query = {
      "offset": offset.toString(),
      "limit": limit.toString()
    };
    final apiRequest = Uri.parse(SpotifyApi.baseUrl +
        SpotifyApi.endpointTracks(playlistId) +
        "/?" +
        query.entries.map((e) => '${e.key}=${e.value}').join('&'));

    final authHeader = <String, String>{"Authorization": token};
    final apiResponse = await http.get(apiRequest, headers: authHeader);
    if (apiResponse.statusCode != 200) {
      error = ResponseError(apiResponse.statusCode, apiResponse.reasonPhrase);
    }
    final Map<String, dynamic> parsedJson = jsonDecode(apiResponse.body);
    final Tracks result = Tracks.fromJson(parsedJson);
    response = ResponseWrapper(result, error: error);
    return response;
  }
}
