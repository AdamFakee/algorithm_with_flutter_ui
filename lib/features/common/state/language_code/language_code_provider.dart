import 'package:algorithm_with_flutter_ui/features/common/state/language_code/language_code_state.dart';
import 'package:algorithm_with_flutter_ui/features/common/state/language_code/language_code_state_type.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final languageCodeProvider =
    NotifierProvider<LanguageCodeState, LanguageCodeStateType>(() {
  return LanguageCodeState();
});