import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:spotify_conversations/playlist_details/details_controller.dart';

import '../app_colors.dart';
import '../app_theme.dart';
import '../models/playlist_details.dart';

class DetailsView extends StatefulWidget {
  final String? profilePhotoUrl;
  final String playlistName;
  final String playlistId;
  const DetailsView(this.playlistName, this.profilePhotoUrl, this.playlistId,
      {Key? key})
      : super(key: key);

  @override
  State<DetailsView> createState() => _DetailsViewState();
}

class TrackTile extends StatelessWidget {
  final Track? selectedTrack;
  const TrackTile(this.selectedTrack, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        margin: const EdgeInsets.fromLTRB(0, 12, 0, 0),
        width: 160,
        height: 160,
        child: Image.network(
          selectedTrack?.album?.images?.first.url ?? "",
          fit: BoxFit.cover,
        ),
      ),
      title: Text(
        "${selectedTrack?.artists?.first.name} - ${selectedTrack?.name}",
        style: AppTheme.runningText,
      ),
    );
  }
}

class _DetailsViewState extends State<DetailsView> {
  final DetailsController _controller = DetailsController();

  @override
  void initState() {
    super.initState();
    _makeAsyncCalls();
  }

  _makeAsyncCalls() async {
    await _controller.fetchTracks(widget.playlistId);
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
                            widget.playlistName,
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
                        widget.profilePhotoUrl ?? "",
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
                            builder: (_) => ListView.builder(
                                itemCount: _controller.tracks?.items?.length,
                                itemBuilder: (context, index) {
                                  final selectedTrack =
                                      _controller.tracks?.items?[index].track;
                                  return TrackTile(selectedTrack);
                                }));
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
