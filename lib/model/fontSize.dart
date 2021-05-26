class FontSize {
  FontSize({
    this.fontSize,
  });

  final double fontSize;
 
 
  FontSize copyWith({
   double fontSize,
  }) {
    return FontSize(
      fontSize: fontSize ?? this.fontSize,
      
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'fontSize': fontSize,
     
    };
  }
}
