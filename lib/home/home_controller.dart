import 'package:mobx/mobx.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spotify_conversations/home/home_api_client.dart';
import 'package:spotify_conversations/models/response.dart';
import 'package:spotify_sdk/spotify_sdk.dart';

import '../models/me.dart';
part 'home_controller.g.dart';

class HomeController = _HomeController with _$HomeController;

abstract class _HomeController with Store {
  final HomeApiClient _apiClient = HomeApiClient();

  @observable
  Me? profile;

  @observable
  bool loading = false;

  SharedPreferences? prefs;

  @observable
  ResponseError? error;

  @action
  Future<void> initProfile() async {
    loading = true;
    prefs = await SharedPreferences.getInstance();
    String? token = prefs?.getString('token');
    if (token != null) {
      await getProfile(token);
    }
    loading = false;
  }

  @action
  Future<Me?> getProfile(String token) async {
    loading = true;
    try {
      var response = await _apiClient.getProfile(token);
      profile = response.responseObject;
      error = response.error;
    } catch (ex) {
      print("fetching profile failed");
    }
    loading = false;
    return profile;
  }

  @action
  Future<String> getAccessToken() async {
    prefs ??= await SharedPreferences.getInstance();
    var authenticationToken = await SpotifySdk.getAuthenticationToken(
        clientId: "a8b5087ee6bb4bf6beac9b7498727df1",
        redirectUrl: "https://thatrohit.github.io/test/",
        scope: "playlist-read-collaborative");
    prefs?.setString('token', "Bearer $authenticationToken");
    await getProfile("Bearer $authenticationToken");
    return authenticationToken;
  }

  @action
  Future<void> logout() async {
    loading = true;
    prefs ??= await SharedPreferences.getInstance();
    prefs?.remove('token');
    profile = null;
    loading = false;
  }
}
