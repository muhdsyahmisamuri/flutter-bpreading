import 'package:hive/hive.dart';

part 'item_data.g.dart';

@HiveType(typeId: 0)
class ItemData extends HiveObject {
  @HiveField(0)
  final String systolic;

  @HiveField(1)
  final String diastolic;

  @HiveField(2)
  final String pulse;

  @HiveField(3)
  final String dateTime;

  ItemData({
    required this.systolic,
    required this.diastolic,
    required this.pulse,
    required this.dateTime,
  });
}
