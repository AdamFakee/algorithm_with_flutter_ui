Iterable<int> gen(List<int> a, int cnt) sync* {
  if(cnt == 2) return;

  for (var e in a) {
    yield e;
    yield* gen(a, cnt+1);
  }
}

void main() {
  final a = [1, 2, 3];
  final res = gen(a, 0);
  print(res.length);
}