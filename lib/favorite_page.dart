import 'package:flutter/material.dart';

import 'package:lab2/load_data.dart';
import 'card_widget.dart';
import 'drug_information_page.dart';
import 'get_imgSrc.dart';

class Favorite extends StatefulWidget {
  const Favorite({super.key});

  @override
  State<Favorite> createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> {

  List<String> favoriteCards = [];
  @override
  Widget build(BuildContext context) {

    favoriteCards = ModalRoute.of(context)!.settings.arguments as List<String>;
    // print("sended data : $favoriteCards");

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        title: Text("我的收藏"),
        centerTitle: true,
        leading: Builder(
          builder: (BuildContext context){
            return IconButton(
              onPressed: (){
                Navigator.pop(context,{
                  "newList" : favoriteCards,
                });
              },
              icon: Icon(Icons.arrow_back),
            );
          },
        ),
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: LoadData().loadData(),
        builder: (BuildContext context,
            AsyncSnapshot<Map<String, dynamic>> snapshot) {
          if (snapshot.hasData) {
            final data = snapshot.data;

            // return Text("hi");
            // 重要 ListView.builder
            //toDo : fix the list builder
            return ListView.builder(
              itemCount: favoriteCards.length,
              itemBuilder: (BuildContext context, int index) {

                // 取得 圖片位址
                String imgSrc = GetImgSrc(data: data,index: index).getImgSrc();

                // 判斷是否為favorite card
                List<dynamic> newData = [];
                if(favoriteCards.isNotEmpty){
                  for(int i = 0; i < data!["DLI"][0]["result"]["records"].length; i++){
                    for(int j = 0; j < favoriteCards.length; j++){
                      if(data["DLI"][0]["result"]["records"][i]["館名"].contains(favoriteCards[j])){
                        newData.add(data["DLI"][0]["result"]["records"][i]);
                      }
                    }
                  }
                  data!["DLI"][0]["result"]["records"] = newData;
                }


                // 重要 手勢感測元件
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DrugInformationPage(
                          data: data!['DLI'][0]["result"]["records"][index],
                          imgSrc: imgSrc,
                        ),
                      ),
                    );
                  },
                  // 重要 在App上要顯示的內容
                  child: card_widget(cardNames: favoriteCards,item: data!['DLI'][0]["result"]["records"][index], imgSrc: imgSrc,),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            return CircularProgressIndicator();
            // return Text("there is nothing");
          }
        },
      ),
    );
  }
}

