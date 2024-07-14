enum ZipEncoding {
  utf8("UTF-8"),
  big5("Big5"),
  gbk("GBK"),
  shiftJis("Shift-JIS");

  const ZipEncoding(this.value);
  final String value;
}