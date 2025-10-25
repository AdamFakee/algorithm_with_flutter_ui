/// tên ngôn ngữ lập trình
/// 
/// https://github.com/git-touch/highlight.dart/tree/master/highlight/lib/languages
enum LanguageCode { dart, cpp }

class LanguageCodeStateType {
  final LanguageCode language;

  LanguageCodeStateType({
    this.language = LanguageCode.dart,
  });

  LanguageCodeStateType copyWith({LanguageCode? language,}) {
    return LanguageCodeStateType(
      language: language ?? this.language,
    );
  }
}
