import 'package:mobx/mobx.dart';
import 'package:spotify_conversations/home/home_api_client.dart';

import '../models/me.dart';
part 'home_controller.g.dart';

class HomeController = _HomeController with _$HomeController;

abstract class _HomeController with Store {
  final HomeApiClient _apiClient = HomeApiClient();

  @observable
  Me? profile;

  @observable
  bool loading = false;

  @action
  Future<Me?> getProfile(String token) async {
    loading = true;
    profile = await _apiClient.getProfile(token);
    loading = false;
    return profile;
  }
}
