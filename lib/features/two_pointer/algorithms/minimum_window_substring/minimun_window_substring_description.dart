import 'package:algorithm_with_flutter_ui/features/two_pointer/algorithms/two_pointer_description.dart';
import 'package:algorithm_with_flutter_ui/utils/markdown/algorithm_problem_markdown.dart';

class MinimunWindowSubstringDescription extends TwoPointerDescription {
  @override
  String get cppCode {
    return '''
#include<bits/stdc++.h>
using namespace std;
int dem[256];   // dem so lan xuat hien cua cac phan tu thuoc s
int cnt[256]; // dem so lan xuat hien cua cac phan tu thuoc t
int main(){
	string s, t; cin >> s >> t;
	int r = 0, l = 0, pos = -1, ans = 1e9;
	for(char i : t) cnt[i]++;
	while(r < s.size()){
		dem[s[r]]++;
		bool ok = 1;
		for(int i = 'a'; i <= 'z'; i++){
			if(dem[i] < cnt[i]){            // trong chuỗi từ l -> r k chứa đc heets 1 trong các phần tử của xâu t
				ok = 0; 
				break;
			}
		}
		while(dem[s[l]] > cnt[s[l]]){       // lặp thì xóa, xét đến đâu xóa đến đó
			dem[s[l]]--; l++;
		}
		if(ok){
			if(r-l+1 < ans){
				ans = r - l + 1;
				pos = l;          // lưu vị trí của l để in ra
			}
		}
		r++;
	}
	if(ans==1e9) cout << "-1";
	else cout << s.substr(pos, ans);     // in
}
''';
  }

  @override
  String get dartCode {
    return '''
String solve(String s, String t) {
  // mảng đếm ký tự xuất hiện trong "s"
  final a = List.filled(256, 0);

  // mảng đếm ký tự xuất hiện trong "t"
  final b = List.filled(256, 0);

  // 2 con trỏ
  int l = 0;
  int r = 0;
  
  // vị trí xuất hiện của ký tự đầu tiên trong xâu kết quả tìm được
  int pos = -1;
  
  // độ dài ngắn nhất tìm được
  int ans = 9999999;

  // độ dài xâu s
  int length = s.length;

  // đếm số lần xuất hiện của các ký tự có trong s
  for(int i = 0; i < t.length; i++) {
    b[t.codeUnitAt(i)]++;
  }

  while(r < length) {
    // chuỗi con tìm được đã đủ điều kiện để xét hay chưa
    bool ok = true;
    a[s.codeUnitAt(r)]++;

    for(var code = 'a'.codeUnitAt(0); code <= 'z'.codeUnitAt(0); code++) {
      if(a[code] < b[code]) {
        ok = false;
        break;
      }
    }

    while(a[s.codeUnitAt(l)] > b[s.codeUnitAt(l)]) {
      a[s.codeUnitAt(l)]--;
      l++;
    }

    if(ok) {
      final newAns = r - l + 1;
      if(newAns < ans) {
        ans = newAns;
        pos = l;
      }
    }

    r++;
  }

  if(pos == -1) return '';

  return s.substring(pos, pos + ans);
}
''';
  }

 
  @override
  String get markdown {
    final problem = '''
Cho 2 xâu **S** và **T**  chỉ gồm chữ cái in thường, nhiệm vụ của bạn là tìm xâu con ngắn nhất trong **S** chứa đầy đủ mọi ký tự của xâu **T**.
    ''';

    final inputFormat = '''
- Dòng duy nhất chứa xâu S.
- Mặc định xâu T = abcd
''';

    final constraints = '''
- 1 <= len(S) <= 10^6
- Xâu S chỉ chứa các ký tự in thường
''';

    final outputFormat = 'In ra đáp án';

    final samples = <SampleAlgorithmProblemOutput>[
      (input: 'aebcda', output: 'abcd'),
      (input: 'aabceabedfc', output: 'ceabed')
    ];

    return algorithmProblemMarkdown(problem: problem, inputFormat: inputFormat, constraints: constraints, outputFormat: outputFormat, samples: samples);
  }
}