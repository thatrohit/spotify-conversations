mixin SpotifyApi {
  static const baseUrl = "https://api.spotify.com/v1/";
  static const Map<String, String> apiHeaders = {
    "Content-Type": "application/x-www-form-urlencoded; charset=UTF-8",
  };

  static const endpointMe = "me/";

  static const endpointMyPlaylists = "me/playlists";

  static endpointPlaylistDetails(String playlistId) => "playlists/$playlistId";

  static endpointTracks(String playlistId) => "playlists/$playlistId/tracks";
}
