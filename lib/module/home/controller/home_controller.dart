import 'package:bp_reading/module/home/controller/item_data.dart';
import 'package:flutter/material.dart';
import 'package:bp_reading/core.dart';
import '../view/home_view.dart';

class HomeController extends State<HomeView> {
  static late HomeController instance;
  late HomeView view;

  List<ItemData> itemList = [];

  @override
  void initState() {
    instance = this;
    super.initState();
  }

  @override
  void dispose() => super.dispose();

  @override
  Widget build(BuildContext context) => widget.build(context, this);

  void addItem(ItemData item) {
    setState(() {
      itemList.add(item);
    });
  }

  void removeItem(int index) {
    setState(() {
      itemList.removeAt(index);
    });
  }

  void clearItems() {
    setState(() {
      itemList.clear();
    });
  }
}
