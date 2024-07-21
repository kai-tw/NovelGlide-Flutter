class ChineseNumberParser {
  static final Map<String, int> numberMap = {
    "零": 0,
    "一": 1,
    "二": 2,
    "三": 3,
    "四": 4,
    "五": 5,
    "六": 6,
    "七": 7,
    "八": 8,
    "九": 9,
  };

  static final Map<String, int> unitMap = {
    "十": 10,
    "百": 100,
    "千": 1000,
    "萬": 10000,
    "億": 100000000,
  };

  /// Parse a Chinese number.
  static int parse(String str) {
    bool isNumber = int.tryParse(str) != null;
    if (isNumber) {
      return int.parse(str);
    }

    int result = int.tryParse(str) ?? 0;
    int partResult = unitMap.containsKey(str[0]) ? 1 : 0;
    for (int i = 0; i < str.length; i++) {
      if (unitMap.containsKey(str[i])) {
        partResult *= unitMap[str[i]]!;
      } else if (numberMap.containsKey(str[i])) {
        result += partResult;
        partResult = numberMap[str[i]]!;
      }
    }
    return result + partResult;
  }
}
