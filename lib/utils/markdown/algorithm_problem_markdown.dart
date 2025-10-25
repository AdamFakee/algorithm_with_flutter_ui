typedef SampleAlgorithmProblemOutput = ({String input, String output});

/// hiển thị mô tả đề bài cho thuật toán bằng markdown
///
/// `problem` : đề bài
///
/// `inputFormat` : chuỗi đầu vào
///
/// `constraints` : phạm vi xét của `inputFormat`
///
/// `outputFormat` : kết quả
///
/// `samples` : danh sách ví dụ
String algorithmProblemMarkdown({
  required String problem,
  required String inputFormat,
  required String constraints,
  required String outputFormat,
  required List<SampleAlgorithmProblemOutput> samples
}) {

  final sampleSections = samples.asMap().entries.map((e) {
    final index = e.key + 1;
    final sample = e.value;
    return '''
### Sample Input $index
```
${sample.input}
```

### Sample Output $index
```
${sample.output}
```
''';
  });

  // Dùng join('\n\n') để nối các sample lại với nhau, tạo thành một chuỗi duy nhất
  // và thêm khoảng trắng giữa các sample.
  final joinedSampleSections = sampleSections.join('\n\n');

  return '''

$problem

---

## Input Format
$inputFormat

## Constraints
$constraints

## Output Format
$outputFormat

---

$joinedSampleSections

---
  ''';
}