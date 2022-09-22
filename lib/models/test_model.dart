class TestModel{
  String text="";
  String time="";

//<editor-fold desc="Data Methods">

  TestModel({
    required this.text,
    required this.time,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TestModel &&
          runtimeType == other.runtimeType &&
          text == other.text &&
          time == other.time);

  @override
  int get hashCode => text.hashCode ^ time.hashCode;

  @override
  String toString() {
    return 'TestModel{' + ' text: $text,' + ' time: $time,' + '}';
  }

  TestModel copyWith({
    String? text,
    String? time,
  }) {
    return TestModel(
      text: text ?? this.text,
      time: time ?? this.time,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'text': this.text,
      'time': this.time,
    };
  }

  factory TestModel.fromMap(Map<String, dynamic> map) {
    return TestModel(
      text: map['text'] as String,
      time: map['time'] as String,
    );
  }

//</editor-fold>
}