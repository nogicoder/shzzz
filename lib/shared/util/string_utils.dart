import 'dart:io';
import 'dart:math';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shzzz/generated/l10n.dart';

S tr() => S.of(Get.context!);

final viLocale = "vi_VN";
final usLocale = viLocale;
final _numFormat = NumberFormat("#,###", viLocale);
// final _numFormatDecimal = NumberFormat("#,##0.00", viLocale);
final _numFormatCurrency = NumberFormat("###,###,###.##", viLocale);
final _numFormatCurrencyNotDecimal = NumberFormat("###,###,###", viLocale);
final _dateFormatFull = DateFormat("dd/MM/yyyy HH:mm:ss");
final _dateFormatDMYHHmm = DateFormat("dd/MM/yyyy HH:mm");
final _dateFormatDMY = DateFormat("dd/MM/yyyy");
final _formatYMDHMS = DateFormat("yyyyMMddHHmmss");
final _dateFormatDM = DateFormat("dd/MM");
final _dateFormatY = DateFormat("yyyy");
final _dateFormatM = DateFormat("MM");
final _dateFormatD = DateFormat("dd");
final _dateFormatDMYcf = DateFormat("yyyy-MM-ddTHH:mm:ss");
final _dateFormat24h = DateFormat("hh:mm dd/MM/yyyy");
final numFormatter = NumberFormat("#,##0", viLocale);
final formatDate = DateFormat("dd-MM-yyyy");
final formatHours = DateFormat("hh:mm a");
final formatDateTime = DateFormat("hh:mm a dd/MM/yyyy");
final _formatMMMYYYY = DateFormat("MMMM yyyy");
final _formatMMYYYY = DateFormat("MM/yyyy");
final _formatEEE = DateFormat("EEE");

///this file's purpose is converting from dynamic to String
///and any files in the parent's folder (ext) work in similar rule

bool toBool(value, [bool defaultValue = false]) {
  if (value == null) return defaultValue;

  if (value is bool) {
    return value;
  }
  final String strValue = value?.toString().toLowerCase() ?? '0';
  if (strValue == 'true' || strValue == '1') {
    return true;
  } else if (strValue == 'false' || strValue == '0') {
    return false;
  }
  return defaultValue;
}

const _kb = 1024;
const _M = 1000000;
//exp: 1%
const _minRate = 1;

extension Nilly on num {
  num get safeNum => this;

  num? roundAsFixed(int frag) {
    return toStringAsFixed(frag).strSafeNum;
  }

  num get safePeriodMonth {
    final n = this;
    final x = (n == 0) ? 12 : n;
    return x;
  }

  //109.139.000 -> '109,14'
  //90.000.000 -> '90'
  //90.123.000 -> '90,12'
  //### 900.123 -> '900.123' //hâm => 900 tỉ 123 triệu
  //### min: _M
  //------------
  //9,012 -> '9,01'
  //90,812 -> '90,81'
  //90,689 -> '90,69'
  //90 -> '90'
  //999 -> '999'
  //999,123 -> '999,12'
  //999,999 -> '999,99'
  //max: 999,999 (because: 1000 triệu, hâm)
  String get millionFormat {
    final n = safeNum;
    final d = (n >= _M) ? (n / _M) : n;
    return d._decimalFormat();
  }

  String pad({int pad = 2}) {
    return safeNum.toString().padLeft(2, '0');
  }

  String get mbFormat {
    final n = safeNum / _kb;
    return "${n._decimalFormat()} Mb";
  }

  String get sign => safeNum >= 0 ? "+" : "";

  String get currencyFormat => _numFormatCurrency.format(safeNum);

  String get currencyFormatNotDecimal =>
      _numFormatCurrencyNotDecimal.format(safeNum);

  //for int, x >= 1000
  String get numFormat => _numFormat.format(safeNum);

  //đã chia cho total
  //=> nhân với 100
  String get dividedPercentFormat {
    //return "${(safeNum * 100)}%";
    return "${(safeNum * 100)._decimalFormat()}%";
  }

  //for double, nullable
  String get percentFormat {
    return "${safeNum._decimalFormat()}%";
  }

  String get interestRateFormat {
    return "${_real._decimalFormat()}%";
  }

  //có thể đã đc api chia 100
  //0.9 => 90
  //0.2 => 20
  //1.1 => 1.1
  //12 => 12
  num get _real {
    final n = safeNum;
    return (n >= _minRate) ? n : n * 100;
  }

  //for double not null
  String _decimalFormat({int fix = 1}) =>
      (this is int) ? numFormat : toStringAsFixed(fix);

  String get signNumFormat => "$sign$numFormat";
}

extension Dilly on DateTime? {
  String get formatDM => (this != null) ? _dateFormatDM.format(this!) : "";

  String get formatYY => (this != null) ? _dateFormatY.format(this!) : "";

  String get formatMM => (this != null) ? _dateFormatM.format(this!) : "";

  String get formatDD => (this != null) ? _dateFormatD.format(this!) : "";

  String get formatDMY => (this != null) ? _dateFormatDMY.format(this!) : "";

  String get formatYMDHMS => (this != null) ? _formatYMDHMS.format(this!) : "";

  String get formatDMYHHmm =>
      (this != null) ? _dateFormatDMYHHmm.format(this!) : "";

  String get formatFull => (this != null) ? _dateFormatFull.format(this!) : "";

  String get format24h => (this != null) ? _dateFormat24h.format(this!) : "";

  String get formatMMMYYYY =>
      (this != null) ? _formatMMMYYYY.format(this!) : "";

  String get formatEEE => (this != null) ? _formatEEE.format(this!) : "";

  String get formatMMYYYY => (this != null) ? _formatMMYYYY.format(this!) : "";

  String get chatTime {
    if (this == null) return '';
    final now = DateTime.now();
    if (now.formatDMY == this.formatDMY) {
      return formatHours.format(this!);
    }
    return DateFormat("hh:mm a dd/MM").format(this!);
  }
}

extension Dlly on dynamic {
  DateTime? get toDate {
    final value = this;
    if (value == null) return null;
    if (value is DateTime) return value;
    //if (value is Timestamp) return value.toDate();
    if (value is String) return value.strToDate;
    return null;
  }
}

const pdf = '.pdf';

extension Silly on String {
  String get unBreak => replaceAll('\n', '');

  bool isPdf({bool get = false}) {
    final url = toLowerCase();
    return get || !Platform.isIOS ? url.contains(pdf) : url.endsWith(pdf);
  }

  String get toPdfPath {
    var path = substring(lastIndexOf("://") + 1).replaceAll("/", "_");
    if (!path.isPdf()) path += pdf;
    return path;
  }

  //f: formatted
  num? get fToInt => int.tryParse(replaceAll(".", ""))?.safeNum;

  int get trimLength => this.replaceAll(' ', '').length;

  int get safeLength => this.length;

  String get spreadFormat => "${this} m\u00B2";

  DateTime get dateOrNow {
    final value = this;
    return !value.isNullOrEmpty ? _dateFormatDMY.parse(value) : DateTime.now();
  }

  //2020-03-15T09:21:26.000Z
  DateTime? get strToDateCf {
    return isNullOrEmpty ? null : _dateFormatDMYcf.parse(this);
  }

  DateTime? get strToDate {
    return isNullOrEmpty ? null : _dateFormatDMY.parse(this);
  }

  String get parenthesesFormat => "($this)";

  int? get toInt => int.tryParse(this);

  bool get isNullOrEmpty => this.trim().isEmpty;

  String get formatPhoneNumber {
    var phone = this;
    print("---phone = $phone------");
    if (phone.startsWith("+84")) return phone;
    phone = replaceAll("[^\\d.]", "");
    if (phone.startsWith('0')) {
      phone = replaceFirst('0', '84');
    }
    final builder = StringBuffer();
    builder.write('+');
    if (phone.startsWith('84')) {
      builder.write(phone);
    } else {
      builder
        ..write('84')
        ..write(phone);
    }
    return builder.toString();
  }

  String get correctUrl {
    final url = this;
    var start = url.indexOf("http://");
    if (start < 0) start = url.indexOf("https://");
    return start <= 0 ? url : url.substring(start);
  }

  String? get strDecimal {
    return strSafeNum?._decimalFormat();
  }

  num? get strSafeNum {
    if (isNullOrEmpty) return 0;
    return double.tryParse(this)?.safeNum;
  }

  String get normalSearchText {
    return this.trim().toLowerCase();
  }
}

String getTestImage(int width, [int height = 0]) {
  return 'https://picsum.photos/$width${height > 0 ? '/$height' : ''}?x=${Random().nextInt(100)}';
}

String formatTimeInSeconds(Duration duration, {bool showMinuteOnly = false}) {
  String twoDigits(int n) => n.toString().padLeft(2, "0");
  String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
  String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
  return showMinuteOnly
      ? '$twoDigitMinutes phút'
      : "$twoDigitMinutes:$twoDigitSeconds";
}

DateTime? getDateFormat(String format, {String? value}) {
  try {
    if (value == null) return null;
    return DateFormat(format).parse(value);
  } catch (e) {
    return DateTime.now();
  }
}

class CurrencyInputFormatter extends TextInputFormatter {
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    return Platform.isIOS
        ? _fmtIos(oldValue, newValue)
        : _fmtAndroid(oldValue, newValue);
  }

  TextEditingValue _fmtIos(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final newText = _fmtText(newValue);
    if (newValue.selection.baseOffset == 0) {
      print(true);
      return newValue.copyWith(text: newText);
    }
    return newValue.copyWith(
        text: newText,
        selection: TextSelection.collapsed(offset: newText.length));
  }

  TextEditingValue _fmtAndroid(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final newText = _fmtText(newValue);
    if (newValue.selection.baseOffset == 0) {
      print(true);
      return newValue.copyWith(text: newText);
    }
    final oldOffset = oldValue.selection.baseOffset;
    final x = newText.length - oldValue.text.length;
    final ofx = max(1, oldOffset + x);
    return newValue.copyWith(
        text: newText, selection: TextSelection.collapsed(offset: ofx));
  }

  String _fmtText(TextEditingValue newValue) {
    final text = newValue.text;
    double? value = double.tryParse(text);
    return value != null ? numFormatter.format(value) : text;
  }

  static double convertTextToMoney(String? value) {
    double money = 0;
    if (value != null && value.length > 0) {
      String strMoney = value.replaceAll(".", "");
      money = double.tryParse(strMoney) ?? 0;
    }
    return money;
  }
}

String formatNumber(double number) {
  var billion = 1000000000;
  var million = 1000000;
  var kilo = 1000;
  final isNegative = number < 0;

  if (isNegative) {
    number = number.abs();
  }

  String resultNumber;
  String symbol;
  if (number >= billion) {
    resultNumber = (number / billion).toStringAsFixed(1);
    symbol = ' tỷ';
  } else if (number >= million) {
    resultNumber = (number / million).toStringAsFixed(1);
    symbol = ' triệu';
  } else if (number >= kilo) {
    resultNumber = (number / kilo).toStringAsFixed(1);
    symbol = ' k';
  } else {
    resultNumber = number.toStringAsFixed(1);
    symbol = ' đ';
  }

  if (resultNumber.endsWith('.0')) {
    resultNumber = resultNumber.substring(0, resultNumber.length - 2);
  }

  if (isNegative) {
    resultNumber = '-$resultNumber';
  }

  return resultNumber.replaceAll('.', ',') + symbol;
}
