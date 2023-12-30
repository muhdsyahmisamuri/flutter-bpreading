import 'package:bp_reading/module/home/controller/item_data.dart';
import 'package:flutter/material.dart';
import 'package:bp_reading/core.dart';
import 'package:hive/hive.dart';
import '../view/home_view.dart';

class HomeController extends State<HomeView> {
  static late HomeController instance;
  late HomeView view;

  late Box<ItemData> itemBox;

  @override
  void initState() {
    super.initState();
    instance = this; // Initialize the instance here
    itemBox = Hive.box<ItemData>('items');
  }

  @override
  void dispose() => super.dispose();

  @override
  Widget build(BuildContext context) => widget.build(context, this);

  void addItem(ItemData item) {
    setState(() {
      itemBox.add(item);
    });
  }

  void removeItem(int index) {
    setState(() {
      itemBox.deleteAt(index);
    });
  }

  void clearItems() {
    setState(() {
      itemBox.clear();
    });
  }

  Color getColorForStatus(String status) {
    switch (status) {
      case 'normal':
        return Colors.green;
      case 'elevated':
        return Colors.yellow;
      case 'high':
        return Colors.red;
      default:
        return Colors.brown; // Default color for unknown status
    }
  }
}
