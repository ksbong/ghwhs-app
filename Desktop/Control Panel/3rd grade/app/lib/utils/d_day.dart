// String getTestDday() {
//   late String dday;

//   DateTime date1 = DateTime.now();

//   DateTime date2 = DateTime(1, 1, 1);

//   int temp = date2.difference(date1).inDays;

//   dday = temp < 0 ? '+${temp.abs()}' : '-${temp.abs()}';
//   return dday;
// }

String getSNDday() {
  late String dday;

  DateTime date1 = DateTime.now();

  DateTime date2 = DateTime(2024, 11, 14);

  int temp = date2.difference(date1).inDays;

  dday = temp == 0
      ? '-day'
      : temp < 0
          ? '+${temp.abs()}'
          : '-${temp.abs()}';

  return dday;
}
