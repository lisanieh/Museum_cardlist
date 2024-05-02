class GetImgSrc {

  Map<String, dynamic>? data;
  int index;

  GetImgSrc({required this.data,required this.index});

  String getImgSrc(){

    String imgSrc = "";
    bool containsKey = data!["DA"].containsKey(data!['DLI'][0]["result"]["records"][index]['館名']);
    if (containsKey == true) {
      // print("image $index found");
      imgSrc = data!['DA'][data!['DLI'][0]["result"]["records"][index]['館名']];
      // print(imgSrc);
    } else {
      // print("can't find image in $index");
      imgSrc =
      "https://images.unsplash.com/photo-1682686581854-5e71f58e7e3f?ixlib=rb-4.0.3&ixid=M3wxMjA3fDF8MHxlZGl0b3JpYWwtZmVlZHw2fHx8ZW58MHx8fHx8&auto=format&fit=crop&w=2000&q=60";
    }

    return imgSrc;
  }
}