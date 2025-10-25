import 'package:algorithm_with_flutter_ui/features/two_pointer/algorithms/two_pointer_description.dart';
import 'package:algorithm_with_flutter_ui/utils/markdown/algorithm_problem_markdown.dart';

class SmallestWindowDescription extends TwoPointerDescription {
  @override
  String get markdown {
    final problem = '''
Cho xâu **S** chỉ gồm chữ cái in thường, nhiệm vụ của bạn là tìm chiều dài của xâu con liên tiếp nhỏ nhất có chứa đầy đủ các ký tự khác nhau của S.

Ví dụ: S = **abcaaaabcad** thì xâu con **bcad** có độ dài nhỏ nhất và chứa đầy đủ các ký tự khác nhau của S.
  ''';

    final inputFormat = 'Dòng duy nhất chứa xâu S.';

    final constraints = '1 <= len(S) <= 10^6';

    final outputFormat = 'In ra chiều dài xâu con ngắn nhất chứa tất cả các ký tự khác nhau có trong S.';

    final samples = <SampleAlgorithmProblemOutput>[
      (input: 'bcceedeeaedda', output: '9'),
    ];

    return algorithmProblemMarkdown(problem: problem, inputFormat: inputFormat, constraints: constraints, outputFormat: outputFormat, samples: samples);
  }

  @override
  String get dartCode {
    return '''
import 'dart:math';

void solve (String s) {
  // Mảng đếm tần suất ký tự
  final a = List.filled(256, 0);

  // Tập hợp các ký tự khác nhau trong chuỗi s
  final se = s.split('').toSet();

  // Số lượng ký tự khác nhau cần có trong cửa sổ
  final size = se.length;

  int r = 0;
  int l = 0;
  int ans = 0;
  int cnt = 0;
  int inputLength = s.length;

  while(r < inputLength) {
    a[s.codeUnitAt(r)]++;

    if(a[s.codeUnitAt(r)] == 1) cnt++;

    while(a[s.codeUnitAt(l)] > 1) {
      a[a[s.codeUnitAt(l)]]--;
      l++;
    }

    if(cnt == size) ans = max(ans, r - l + 1);
    r++;
  }
}
''';
  }
  
  @override
  String get cppCode {
    return '''
#include<bits/stdc++.h>
using namespace std;
int a[256];
int main(){
  string s; cin >> s;
  set <char> se(s.begin(), s.end());  // nhập xâu s vào se
  int r = 0, l = 0, cnt = 0, ans = INT_MAX;
  while(r < s.size()){
    a[s[r]]++;           // tính số lần xuất hiện của kí tự
    if(a[s[r]]==1) cnt++;  // kí tự xuất hiện lần đầu trong xâu có độ dài k,    aabaa thì trong xâu này cnt chỉ = 2 vì chỉ có 2 kí tự khác nhau
    while(a[s[l]] > 1){    // giảm thì phải xét từ kí tự đầu xâu xét đi, nếu xét giưax giữa làm sai lệch kq,    abd - k giảm đc, aad - giảm còn ad
      a[s[l]]--; l++;
    }
    if(cnt == se.size())ans = min(ans, r - l + 1);   // xâu con có độ dài k đủ tất cả các kí tự thì mới đc vô
    r++;                                          // biến cnt ở đây chỉ cần tăng đến se.size 1 lần là đc, chỗ vòng while nó chỉ xét cái nào >=2 thì mới giảm
  }
  cout << ans;
}
    ''';
  }

}