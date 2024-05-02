import 'package:flutter/material.dart';

import 'API/TTS.dart';

class DrugInformationPage extends StatefulWidget {
  const DrugInformationPage(
      {Key? key, required this.data, required this.imgSrc})
      : super(key: key);

  final Map<String, dynamic> data;
  final String imgSrc;

  @override
  State<DrugInformationPage> createState() => _DrugInformationPageState();
}

class _DrugInformationPageState extends State<DrugInformationPage> {
  
  String displayLanguage = "國語";
  String selectedLanguage = "chinese";
  List<String> items = ["國語", "台語", "英語", "印尼語"];
  final player = SoundPlayer(); //音檔播放器

  @override
  void initState() {
    super.initState();
    player.init();
  }

  Future play(String pathToReadAudio) async {
    await player.play(pathToReadAudio);
    setState(() {
      print("Playing");
      player.isPlaying;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        title: Text("博物館資訊"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              child: Image.network(
                widget.imgSrc,
                height: 200,
                fit: BoxFit.contain,
              ),
            ),
            IconButton(
              icon: Icon(Icons.volume_up,size: 30),
              onPressed: () async {
                if (widget.data["館名"].isEmpty) return;
                await Text2Speech().connect(play, widget.data["館名"], selectedLanguage);
              },
            ),
            Card(
              child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                              flex: 2,
                              child: Text("館名", style: TextStyle(fontSize: 24))),
                          Expanded(
                            flex: 3,
                            child: Text(
                              widget.data["館名"],
                              style: TextStyle(fontSize: 24),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                              flex: 2,
                              child: Text("縣市", style: TextStyle(fontSize: 24))),
                          Expanded(
                            flex: 3,
                            child: Text(
                              widget.data["縣市"],
                              style: TextStyle(fontSize: 24),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                              flex: 2,
                              child: Text("鄉鎮市區", style: TextStyle(fontSize: 24))),
                          Expanded(
                            flex: 3,
                            child: Text(
                              widget.data["鄉鎮市區"],
                              style: TextStyle(fontSize: 24),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                              flex: 2,
                              child: Text("地址", style: TextStyle(fontSize: 24))),
                          Expanded(
                            flex: 3,
                            child: Text(
                              widget.data["地址"],
                              style: TextStyle(fontSize: 24),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                              flex: 2,
                              child: Text("市話", style: TextStyle(fontSize: 24))),
                          Expanded(
                            flex: 3,
                            child: Text(
                              widget.data["市話"],
                              style: TextStyle(fontSize: 24),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                              flex: 2,
                              child: Text("網址", style: TextStyle(fontSize: 24))),
                          Expanded(
                            flex: 3,
                            child: Text(
                              widget.data["網址"],
                              style: TextStyle(fontSize: 24),
                            ),
                          ),
                        ],
                      ),
                    ],
                  )),
            ),
          ],
        ),
      ),
    );
  }
}