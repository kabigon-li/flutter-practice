class FontSize {
  FontSize({
    this.id,
    this.fontSize,
  });
  final int id;

  final double fontSize;

  FontSize copyWith({
    int id,
    double fontSize,
  }) {
    return FontSize(
      id: id ?? this.id,
      fontSize: fontSize ?? this.fontSize,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'fontSize': fontSize,
    };
  }
}
