import 'package:fluent_ui/fluent_ui.dart';
import 'package:lottie/lottie.dart';
import 'package:spotify_conversations/home/home_controller.dart';
import 'package:spotify_conversations/models/me.dart';
import 'package:spotify_sdk/spotify_sdk.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _loading = false;
  final _controller = HomeController();

  Future<String> getAccessToken() async {
    setState(() {
      _loading = true;
    });
    var authenticationToken = await SpotifySdk.getAuthenticationToken(
        clientId: "a8b5087ee6bb4bf6beac9b7498727df1",
        redirectUrl: "https://thatrohit.github.io/test/",
        scope:
            "app-remote-control,user-modify-playback-state,playlist-read-private");
    print("SPOTIFY TOKEN -> $authenticationToken");
    await _controller.getProfile("Bearer $authenticationToken");
    setState(() {
      _loading = false;
    });
    return authenticationToken;
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
              child: FilledButton(
                onPressed: getAccessToken,
                child: Center(
                  child: _loading
                      ? const ProgressRing()
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/logo.png',
                              height: 30,
                              width: 30,
                            ),
                            const Padding(
                              padding: EdgeInsets.fromLTRB(8, 0, 0, 0),
                              child: Text("Login with Spotify"),
                            ),
                          ],
                        ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
            child: SizedBox(
              width: (MediaQuery.of(context).size.width / 3),
              child: _controller.profile == null
                  ? const Text("No profile loaded yet",
                      style: TextStyle(
                        fontStyle: FontStyle.italic,
                        color: Colors.white,
                      ))
                  : ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.green,
                        child: Image.network(
                            _controller.profile?.images?.first.url ?? ""),
                      ),
                      title: Text(_controller.profile?.displayName ?? "",
                          style: const TextStyle(
                            fontStyle: FontStyle.italic,
                            color: Colors.white,
                          )),
                      subtitle: Text(
                          "${_controller.profile?.followers?.total ?? "0"} followers",
                          style: const TextStyle(
                            fontStyle: FontStyle.italic,
                            color: Colors.white,
                          )),
                    ),
            ),
          ),
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
