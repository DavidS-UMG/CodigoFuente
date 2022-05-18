import 'package:intl/intl.dart' as intl;

class DataEntry {
  DateTime dateReported;
  String countryCode;
  int newCases;
  int cumulativeCases;
  int newDeaths;
  int cumulativeDeaths;

  DataEntry(
    String dateReportedStr,
    this.countryCode,
    this.newCases,
    this.cumulativeCases,
    this.newDeaths,
    this.cumulativeDeaths,
  ) : dateReported = intl.DateFormat("yyyy-MM-dd").parse(dateReportedStr);
}