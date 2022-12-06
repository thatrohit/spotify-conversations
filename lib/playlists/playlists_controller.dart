import 'package:mobx/mobx.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spotify_conversations/models/playlists.dart';
import 'package:spotify_conversations/playlists/playlists_api_client.dart';

part 'playlists_controller.g.dart';

class PlaylistsController = _PlaylistsController with _$PlaylistsController;

abstract class _PlaylistsController with Store {
  @observable
  bool loading = false;

  SharedPreferences? prefs;

  @observable
  Playlists? playlists;

  @observable
  bool isHovered = false;

  final PlaylistsApiClient _apiClient = PlaylistsApiClient();

  @action
  Future<Playlists?> fetchPlaylists() async {
    loading = true;
    try {
      prefs ??= await SharedPreferences.getInstance();
      String token = prefs?.getString('token') ?? "";
      int offset = 0;
      int limit = 5;
      List<Items> items = [];
      Playlists? tempPlaylists;
      print("called fetchPlaylists. token -> $token");
      do {
        tempPlaylists =
            (await _apiClient.getCollaborativePlaylists(token, offset, limit))
                .responseObject;
        if (tempPlaylists?.items != null) {
          items.addAll(tempPlaylists!.items!.where((element) => true));
        }
        print("tempPlaylists.next -> ${tempPlaylists?.next}");
        if (tempPlaylists?.next != null) {
          Uri next = Uri.parse(tempPlaylists!.next!);
          offset = int.parse(next.queryParameters["offset"] ?? "0");
          print("next offset -> $offset");
        } else {
          tempPlaylists?.items = items;
          playlists = tempPlaylists;
          break;
        }
      } while (true);
    } catch (ex) {
      print("failed to get playlists. ${ex.toString()}");
    }
    loading = false;
    print(
        "nostalgia props -> ${playlists?.items?[0].name} | ${playlists?.items?[0].collaborative} | ${playlists?.items?[0].owner?.displayName}");
    print(
        "yeh suno props -> ${playlists?.items?[2].name} | ${playlists?.items?[2].collaborative} | ${playlists?.items?[2].owner?.displayName}");
    return playlists;
  }
}
