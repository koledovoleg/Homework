"""
Закодируйте любую строку из трех слов по алгоритму Хаффмана.

Пример:
строка для кодирования
s = "beep boop beer!"

Результат:
00 11 11 101 010 00 011 011 101 010 00 11 11 1000 1001
"""
from collections import Counter, deque


class MyNode:
    def __init__(self, left=None, right=None):
        self.left = left
        self.right = right


def huffman_tree(input_string):
    counter = Counter(input_string)

    deq = deque(sorted(counter.items(), key=lambda x: x[1]))

    while len(deq) > 1:

        weight = deq[0][1] + deq[1][1]
        node = MyNode(left=deq.popleft()[0], right=deq.popleft()[0])

        for index, item in enumerate(deq):
            if weight > item[1]:
                continue
            else:
                deq.insert(index, (node, weight))
                break
        else:
            deq.append((node, weight))

    return deq[0][0]


def encode_tree(tree, encode_table, path=''):
    if not isinstance(tree, MyNode):
        encode_table[tree] = path
    else:
        encode_tree(tree=tree.left,  encode_table=encode_table, path=f'{path}0')
        encode_tree(tree=tree.right, encode_table=encode_table, path=f'{path}1')


some_string = 'beep boop beer!'
encode_dict = dict()
encode_tree(huffman_tree(some_string), encode_dict)

encoded_list = []

for element in some_string:
    encoded_list.append(encode_dict[element])

encoded_string = ''.join(encoded_list)

print(f'Оригинальная строка:   {some_string}')
print(f'Закодированная строка: {encoded_string}')