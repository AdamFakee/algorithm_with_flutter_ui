import 'package:algorithm_with_flutter_ui/features/common/state/language_code/language_code_state_type.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LanguageCodeState extends Notifier<LanguageCodeStateType> {
  @override
  LanguageCodeStateType build() {
    return LanguageCodeStateType(
      language: LanguageCode.dart
    );
  }

  void setLanguageCode(LanguageCode language) {
    if(state.language.name == language.name) return;

    state = state.copyWith(
      language: language
    );
  }
}