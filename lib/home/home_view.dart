import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:lottie/lottie.dart';
import 'package:spotify_conversations/app_colors.dart';
import 'package:spotify_conversations/home/home_controller.dart';

import '../playlists/playlists_view.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _controller = HomeController();

  @override
  void initState() {
    super.initState();
    _makeAsyncCalls();
  }

  _makeAsyncCalls() async {
    await _controller.initProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      color: Colors.black,
      child: Center(
          child: Column(
        children: [
          SizedBox(
            height: (MediaQuery.of(context).size.height / 4),
          ),
          Lottie.network(
            'https://assets9.lottiefiles.com/packages/lf20_a6hjf7nd.json',
            height: 100,
            width: 100,
            repeat: false,
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: SizedBox(
              width: 400,
              child: Observer(
                builder: (_) => FilledButton(
                  onPressed: _controller.profile == null
                      ? _controller.getAccessToken
                      : () {
                          Navigator.push(
                            context,
                            FluentPageRoute(
                                builder: (context) =>
                                    PlaylistsPage(_controller.profile)),
                          );
                        },
                  child: Center(
                    child: Observer(
                      builder: (_) => _controller.loading
                          ? const ProgressRing()
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'assets/logo.png',
                                  height: 30,
                                  width: 30,
                                ),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(8, 0, 0, 0),
                                  child: _controller.profile == null
                                      ? const Text("Login with Spotify")
                                      : const Text("Let me in!"),
                                ),
                              ],
                            ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          UserInfo(controller: _controller),
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                constraints: BoxConstraints(
                    maxHeight: 24, minWidth: MediaQuery.of(context).size.width),
                color: Colors.grey,
                child: const Padding(
                  padding: EdgeInsets.all(1.0),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text("thatrohit ",
                        style: TextStyle(
                          fontStyle: FontStyle.italic,
                          color: Colors.white,
                        )),
                  ),
                ),
              ),
            ),
          )
        ],
      )),
    );
  }
}

class UserInfo extends StatefulWidget {
  const UserInfo({
    Key? key,
    required HomeController controller,
  })  : _controller = controller,
        super(key: key);

  final HomeController _controller;

  @override
  State<UserInfo> createState() => _UserInfoState();
}

class _UserInfoState extends State<UserInfo> {
  bool highlight = false;
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (e) => setState(() {
        highlight = true;
      }),
      onExit: (e) => setState(() {
        highlight = false;
      }),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
        child: SizedBox(
          width: (MediaQuery.of(context).size.width / 3),
          child: Observer(
            builder: (_) => widget._controller.profile == null
                ? const Text("No profile loaded yet",
                    style: TextStyle(
                      fontStyle: FontStyle.italic,
                      color: Colors.white,
                    ))
                : Container(
                    decoration: BoxDecoration(
                      border: highlight
                          ? Border.all(color: AppColors.primary)
                          : Border.all(color: Colors.transparent),
                    ),
                    child: TappableListTile(
                      tileColor: ButtonState.all(Colors.black),
                      isThreeLine: true,
                      onTap: widget._controller.profile == null
                          ? null
                          : widget._controller.logout,
                      leading: CircleAvatar(
                        backgroundColor: Colors.green,
                        child: Image.network(
                            widget._controller.profile?.images?.first.url ??
                                ""),
                      ),
                      title: Text(widget._controller.profile?.displayName ?? "",
                          style: const TextStyle(
                            fontStyle: FontStyle.italic,
                            color: Colors.white,
                          )),
                      subtitle: Text(
                          "${widget._controller.profile?.followers?.total ?? "0"} followers\n(not you? click to logout)",
                          style: const TextStyle(
                            fontSize: 10,
                            fontStyle: FontStyle.italic,
                            color: Colors.white,
                          )),
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
