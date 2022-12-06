import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:spotify_conversations/app_colors.dart';
import 'package:spotify_conversations/app_theme.dart';
import 'package:spotify_conversations/models/playlists.dart';
import 'package:spotify_conversations/playlist_details/details_view.dart';
import 'package:spotify_conversations/playlists/playlists_controller.dart';

import '../models/me.dart';

class PlaylistsPage extends StatefulWidget {
  Me? me;
  PlaylistsPage(this.me, {Key? key}) : super(key: key);

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
        child: Container(
          color: AppColors.grayBG2,
          width: 800,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 400,
                  width: 800,
                  child: Container(
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.me?.displayName ?? "No Name",
                            style: AppTheme.heroTextStyle,
                          ),
                          Text(
                            "Your Collaborative Playlists",
                            style: AppTheme.heroRunningText,
                          )
                        ],
                      ),
                    ),
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          AppColors.grayBG2,
                        ],
                      ),
                    ),
                  ),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                        widget.me?.images?.first.url ?? "",
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(12, 20, 12, 12),
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        return Observer(
                          builder: (_) => GridView.builder(
                            itemCount:
                                _controller.playlists?.items?.length ?? 0,
                            itemBuilder: (context, index) =>
                                ItemTile(_controller.playlists?.items?[index]),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 4,
                              mainAxisExtent: 240,
                            ),
                          ),
                        );
                      },
                    ),
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

class ItemTile extends StatefulWidget {
  final Items? playlist;

  const ItemTile(this.playlist);

  @override
  State<ItemTile> createState() => _ItemTileState();
}

class _ItemTileState extends State<ItemTile> {
  bool highlight = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          FluentPageRoute(
              builder: (context) => DetailsView(
                  widget.playlist?.name ?? "Unnamed Playlist",
                  widget.playlist?.images?.first.url ?? "",
                  widget.playlist?.id ?? "")),
        );
      },
      child: MouseRegion(
        onEnter: (e) => setState(() {
          highlight = true;
        }),
        onExit: (e) => setState(() {
          highlight = false;
        }),
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.grayBG,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              highlight
                  ? const BoxShadow(color: AppColors.primary, blurRadius: 8)
                  : const BoxShadow(color: Colors.transparent, blurRadius: 0)
            ],
          ),
          margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.fromLTRB(0, 12, 0, 0),
                width: 160,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    widget.playlist?.images?.first.url ?? "",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                child: ListTile(
                  title: Text(
                    widget.playlist?.name ?? "N/A",
                    style: AppTheme.runningText,
                  ),
                  subtitle: Text(
                    "By ${widget.playlist?.owner?.displayName ?? 'N/A'}",
                    style: AppTheme.runningTextSubtext,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
