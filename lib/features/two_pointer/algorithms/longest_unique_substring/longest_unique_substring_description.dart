import 'package:algorithm_with_flutter_ui/features/two_pointer/algorithms/two_pointer_description.dart';
import 'package:algorithm_with_flutter_ui/utils/markdown/algorithm_problem_markdown.dart';

class LongestUniqueSubstringDescription extends TwoPointerDescription {
  @override
  String get dartCode {
    return '''
import 'dart:math';

void solve (String s) {
  final a = List.filled(256, 0);
  int r = 0;
  int l = 0;
  int ans = 0;
  int inputLength = s.length;

  while(r < inputLength) {
    a[s.codeUnitAt(r)]++;
    while(a[s.codeUnitAt(r)] > 1) {
      a[a[s.codeUnitAt(l)]]--;
      l++;
    }

    ans = max(ans, r - l + 1);
    r++;
  }
}
''';
  }

  @override
  String get markdown {
    final problem = '''
Cho xâu **S** chỉ gồm chữ cái in thường, nhiệm vụ của bạn là tìm chiều dài của xâu con có các ký tự liên tiếp khác nhau dài nhất.
    ''';

    final inputFormat = 'Dòng duy nhất chứa xâu S.';

    final constraints = '1 <= len(S) <= 10^6';

    final outputFormat = 'In ra đáp án';

    final samples = <SampleAlgorithmProblemOutput>[
      (input: 'abcaabcd', output: '4'),
    ];

    return algorithmProblemMarkdown(problem: problem, inputFormat: inputFormat, constraints: constraints, outputFormat: outputFormat, samples: samples);
  }
  
  @override
  String get cppCode {
    return '''
#include<bits/stdc++.h>
using namespace std;
int a[256];
int main(){
  string s; cin >> s;
  int r = 0, l = 0, ans = 0;
  while(r < s.size()){
    a[s[r]]++;
    while(a[s[r]] > 1){           // nếu a[r] > 1 thì giảm a[l] đến khi a[r] = 1 nghĩa là a[r] k còn được lặp lại nữa thì xét tiếp
      a[s[l]]--; l++;         // kiểu bcdaad thì khi r = 4, a[4] = 2 > 1 dịch l đến l = 4 nốt thì khi đó a chỉ lặp 1 lần trong ở xâu mới được xét bắt đầu từ r = 4;
    }
    ans = max(ans, r - l + 1);
    r++;
  }
  cout << ans;
}
    ''';
  }
}