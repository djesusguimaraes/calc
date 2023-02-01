String markThousand(String number) {
  if (number.replaceAll('.', '').length <= 3) return number;

  String dot = '.';
  String? decimals;

  if (number.contains(dot)) {
    var parts = number.split(dot);
    decimals = parts.elementAt(1);
    number = parts.elementAt(0);
  }

  String thousandMarks = _reverseString(number).splitMapJoin(
    RegExp(r'[0-9]{3}'),
    onNonMatch: (n) => n.isNotEmpty ? n : '',
    onMatch: (m) {
      var match = '${m[0]}';
      if (match.isNotEmpty && m.end != number.length) match += ',';
      return match;
    },
  );

  return '${_reverseString(thousandMarks)}${decimals != null ? '$dot$decimals' : ''}';
}

String _reverseString(String value) => value.split('').reversed.join();
