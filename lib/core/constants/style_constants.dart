import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StyleConstants {
  static StyleConstants instance = StyleConstants._init();
  StyleConstants._init();

  TextStyle newsTitleStyle =
      const TextStyle(fontSize: 20, fontWeight: FontWeight.bold);
}
