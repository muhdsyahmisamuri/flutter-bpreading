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

  // New field for status
  String get status {
    final int sys = int.tryParse(systolic) ?? 0;
    final int dia = int.tryParse(diastolic) ?? 0;

    if (sys < 120 && dia < 80) {
      return 'normal';
    } else if ((sys >= 120 && sys <= 129) && dia < 80) {
      return 'elevated';
    } else if ((sys >= 130 && sys <= 180) || (dia >= 80 && dia <= 120)) {
      return 'high';
    } else {
      return 'unknown'; // For other cases
    }
  }

  ItemData({
    required this.systolic,
    required this.diastolic,
    required this.pulse,
    required this.dateTime,
  });
}
