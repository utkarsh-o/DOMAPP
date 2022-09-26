import 'package:hive/hive.dart';
import '../cache/constants.dart';

part 'Credits.g.dart';

@HiveType(typeId: CREDITS_BOX)
class Credits extends HiveObject {
  @HiveField(0)
  int practicals;
  @HiveField(1)
  int lectures;
  @HiveField(2)
  int units;

  Credits({required this.practicals, required this.lectures})
      : this.units = practicals + lectures;
}
