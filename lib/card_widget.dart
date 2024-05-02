import 'package:flutter/material.dart';

class card_widget extends StatefulWidget {
  const card_widget({
    super.key,
    required this.cardNames,
    required this.item,
    required this.imgSrc,
  });

  final List<String> cardNames;
  final Map<String, dynamic> item;
  final String imgSrc;


  @override
  State<card_widget> createState() => _card_widgetState();
}

class _card_widgetState extends State<card_widget> {

  @override
  Widget build(BuildContext context) {

    // print(widget.imgSrc);

    return Card(
      child: Row(
        children: [
          IconButton(
            onPressed: (){
              setState(() {
                String value = widget.item["館名"];
                // print(value);
                if (widget.cardNames.contains(value)){
                  widget.cardNames.remove(value);
                }
                else{
                  widget.cardNames.add(value);
                }
                debugPrint(widget.cardNames.toString());
              });
            },
            icon: (widget.cardNames.contains(widget.item["館名"]) == true) ? Icon((Icons.favorite)) : Icon(Icons.favorite_border),
          ),
          Expanded(
            child: ListTile(
              title: Text(widget.item['館名']),
              subtitle: Text(widget.item['縣市']),
            ),
          ),
          Image.network(
            widget.imgSrc,
            width: 100,
            height: 100,
          )
        ],
      ),
    );
  }
}