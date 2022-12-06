import 'dart:convert';

import 'package:spotify_conversations/home/home_repostiroy.dart';
import 'package:spotify_conversations/models/me.dart';
import 'package:spotify_conversations/models/response.dart';
import 'package:spotify_conversations/utils/api_helpers.dart';
import 'package:http/http.dart' as http;

class HomeApiClient implements HomeRepository {
  @override
  Future<ResponseWrapper<Me?>> getProfile(String token) async {
    ResponseWrapper<Me?> response;
    ResponseError? error;
    final apiRequest = Uri.parse(SpotifyApi.baseUrl + SpotifyApi.endpointMe);
    final authHeader = <String, String>{"Authorization": token};
    final meHeaders = {...SpotifyApi.apiHeaders};
    meHeaders.addEntries(authHeader.entries);
    final apiResponse = await http.get(apiRequest, headers: meHeaders);
    if (apiResponse.statusCode != 200) {
      error = ResponseError(apiResponse.statusCode, apiResponse.reasonPhrase);
    }
    final Map<String, dynamic> parsedJson = jsonDecode(apiResponse.body);
    final Me result = Me.fromJson(parsedJson);
    response = ResponseWrapper(result, error: error);
    return response;
  }
}
