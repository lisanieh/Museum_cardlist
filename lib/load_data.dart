import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

class LoadData {
  Future<Map<String, dynamic>> loadData() async {
    String jsonDLIString = await rootBundle.loadString('assets/data/DLI.json');
    String jsonDAString = await rootBundle.loadString('assets/data/DA.json');

    Map<String, dynamic> data = {
      "DLI": jsonDecode(jsonDLIString),
      "DA": jsonDecode(jsonDAString),
    };

    return data;
  }
}