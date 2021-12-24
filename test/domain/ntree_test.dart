import 'package:fex/domain/collections/ntree/ntree.dart';
import 'package:test/test.dart';

void main() {
  test('When create a tree \n'
          'Then will be success', () async
  {
    final tree = NTree<String>('/');
    expect(tree.value, equals('/'));
    expect(tree.children, isEmpty);
  });

  test('Given an empty ntree \n'
    'When add a node \n'
    'Then will be success', () async
  {
    final tree = NTree<String>('/');
    tree.add('bin');
    expect(tree.children.length, equals(1));
  });
}
