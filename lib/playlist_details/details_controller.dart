import 'package:mobx/mobx.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spotify_conversations/models/playlist_details.dart';
import 'package:spotify_conversations/playlist_details/details_api_client.dart';

part 'details_controller.g.dart';

class DetailsController = _DetailsController with _$DetailsController;

abstract class _DetailsController with Store {
  @observable
  bool loading = false;

  SharedPreferences? prefs;

  @observable
  bool isHovered = false;

  @observable
  Tracks? tracks;

  final DetailsApiClient _apiClient = DetailsApiClient();

  @action
  Future<Tracks?> fetchTracks(String playlistId) async {
    loading = true;
    try {
      prefs ??= await SharedPreferences.getInstance();
      String token = prefs?.getString('token') ?? "";
      int offset = 0;
      int limit = 5;
      List<Items> items = [];
      Tracks? tempTracks;
      do {
        tempTracks =
            (await _apiClient.getTracks(token, playlistId, offset, limit))
                .responseObject;
        if (tempTracks?.items != null) {
          items.addAll(tempTracks!.items!);
        }
        print("tempTracks.next -> ${tempTracks?.next}");
        if (tempTracks?.next != null) {
          Uri next = Uri.parse(tempTracks!.next!);
          offset = int.parse(next.queryParameters["offset"] ?? "0");
          print("next offset -> $offset");
        } else {
          tempTracks?.items = items;
          tracks = tempTracks;
          break;
        }
      } while (true);
    } catch (ex) {
      print("failed to get tracks for playlist");
    }
    for (var trk in tracks!.items!) {
      print("${trk.track?.artists?.first.name} - ${trk.track?.name}");
    }
    return tracks;
  }
}
