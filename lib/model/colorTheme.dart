class ColorTheme {
  ColorTheme({
    this.id,
    this.themeNumber,
  });

  final int id;

  final int themeNumber;

  ColorTheme copyWith({
    int id,
    int themeNumber,
  }) {
    return ColorTheme(
      id: id ?? this.id,
      themeNumber: themeNumber ?? this.themeNumber,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'themeNumber': themeNumber,
    };
  }
}
