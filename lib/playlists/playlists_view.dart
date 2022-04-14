import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:spotify_conversations/app_colors.dart';
import 'package:spotify_conversations/models/playlists.dart';
import 'package:spotify_conversations/playlists/playlists_controller.dart';

class PlaylistsPage extends StatefulWidget {
  const PlaylistsPage({Key? key}) : super(key: key);

  @override
  State<PlaylistsPage> createState() => _PlaylistsPageState();
}

class _PlaylistsPageState extends State<PlaylistsPage> {
  final PlaylistsController _controller = PlaylistsController();
  @override
  void initState() {
    super.initState();
    _makeAsyncCalls();
  }

  _makeAsyncCalls() async {
    await _controller.fetchPlaylists();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      color: Colors.black,
      child: Align(
        alignment: Alignment.center,
        child: SizedBox(
          width: 800,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "WIP collab playlists page",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
                Expanded(
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      return Observer(
                        builder: (_) => GridView.builder(
                          itemCount: _controller.playlists?.items?.length ?? 0,
                          itemBuilder: (context, index) =>
                              ItemTile(_controller.playlists?.items?[index]),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4,
                          ),
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ItemTile extends StatelessWidget {
  final Items? playlist;

  const ItemTile(
    this.playlist,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: NetworkImage(
              playlist?.images?.first.url ?? "",
            ),
            fit: BoxFit.cover),
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(4),
        boxShadow: const [
          BoxShadow(
              color: Colors.black, offset: const Offset(0, 2), blurRadius: 6)
        ],
      ),
      height: 200,
      width: 200,
      margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
      child: Column(children: [
        Expanded(
          child: Container(),
        ),
        Container(
          color: AppColors.primary,
          child: ListTile(
            leading: const Icon(FluentIcons.music_note),
            title: Text(
              playlist?.name ?? "N/A",
              style: TextStyle(
                fontSize: 12,
                color: Colors.white,
              ),
            ),
            subtitle: Text(
              "- ${playlist?.owner?.displayName ?? 'N/A'}",
              style: TextStyle(
                fontSize: 10,
                fontStyle: FontStyle.italic,
                color: Colors.white,
              ),
            ),
          ),
        )
      ]),
    );
  }
}
