import 'dart:io';

import 'package:flutter/material.dart';
import 'package:record/record.dart';

import 'API/STT.dart';
import 'drug_information_page.dart';
import 'card_widget.dart';
import 'get_imgSrc.dart';
import 'load_data.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key,});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  String keyword = "";
  List<String> favoriteCards = [];

  bool isLoadedModelList = false;
  List<String> modelList = [];
  bool isRecord = false;
  String speechRecognitionAudioPath = "";
  bool isNeedSendSpeechRecognition = false;
  String base64String = "";
  List<String> items = ["國語", "台語", "英語", "客語", "印尼語"];
  String selectedLanguage = "國語";
  String selectedModel = "mandarin";
  AudioEncoder encoder = AudioEncoder.wav;

  Future<String> askForService(String base64String, String model) {
    return STTClient().askForService(base64String, model);
  }

  @override
  void initState() {
    super.initState();
    //********* 根據設備決定錄音的encoder *********//
    if (Platform.isIOS) {
      encoder = AudioEncoder.pcm16bit;
    } else {
      encoder = AudioEncoder.wav;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary, // app bar background
          foregroundColor: Theme.of(context).colorScheme.onSecondary, //title text color
          title: Text('原住民族相關博物館'),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () async {
                // Navigator.pushNamed(context, "/favorite",arguments: favoriteCards);
                dynamic result = await Navigator.pushNamed(context, "/favorite",arguments: favoriteCards);
                setState(() {
                  favoriteCards = result["newList"];
                });
              },
              icon: Icon(Icons.favorite),
            ),
          ],
        ),
        // 重要 FutureBuilder
        body: Column(
          children: [
            Row(
              children: [
                IconButton(
                  onPressed: (){

                  },
                  icon: Icon(Icons.mic),
                ),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: "Search",
                      prefixIcon: Icon(Icons.search),
                    ),
                    onChanged: (value) {
                      // print("value : $value");
                      keyword = value;
                      // print("keyword : $keyword");
                    },
                  ),
                ),
                IconButton(
                  onPressed: (){
                    setState(() {});
                  },
                  icon: Icon(Icons.check),
                ),
              ],
            ),
            Expanded(
              child: FutureBuilder<Map<String, dynamic>>(
                future: LoadData().loadData(),
                builder: (BuildContext context,
                    AsyncSnapshot<Map<String, dynamic>> snapshot) {
                  if (snapshot.hasData) {
                    final data = snapshot.data;

                    // 判斷是否有點擊資訊
                    List<dynamic> newData = [];
                    if (keyword != ""){
                      for (int i = 0; i < data!["DLI"][0]["result"]["records"].length; i++){
                        if (data["DLI"][0]["result"]["records"][i]["館名"].contains(keyword) || data["DLI"][0]["result"]["records"][i]["縣市"].contains(keyword) || data["DLI"][0]["result"]["records"][i]["鄉鎮市區"].contains(keyword)) {
                          newData.add(data["DLI"][0]["result"]["records"][i]);
                          // print(keyword);
                        }
                      }
                      data!["DLI"][0]["result"]["records"] = newData;
                      // print(newData);
                    }

                    // 重要 ListView.builder
                    return ListView.builder(
                      itemCount: data!["DLI"][0]["result"]["records"].length,
                      itemBuilder: (BuildContext context, int index) {

                        // 取得 圖片位址
                        String imgSrc = GetImgSrc(data: data,index: index).getImgSrc();

                        // 重要 手勢感測元件
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DrugInformationPage(
                                  data: data['DLI'][0]["result"]["records"][index],
                                  imgSrc: imgSrc,
                                ),
                              ),
                            );
                          },
                          // 重要 在App上要顯示的內容
                          child: card_widget(cardNames: favoriteCards,item: data['DLI'][0]["result"]["records"][index], imgSrc: imgSrc,),
                        );
                      },
                    );
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    return CircularProgressIndicator();
                  }
                },
              ),
            ),
          ],
        ));
  }
}