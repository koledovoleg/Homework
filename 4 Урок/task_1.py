"""
1. Проанализировать скорость и сложность одного любого алгоритма,
разработанных в рамках домашнего задания первых трех уроков.
Примечание: попробуйте написать несколько реализаций алгоритма и сравнить их.

Подсказка:
1) возьмите 2-3 задачи, реализованные ранее, сделайте замеры на разных входных данных
2) сделайте для каждой из задач оптимизацию (придумайте что можно оптимизировать)
и также выполните замеры на уже оптимизированных алгоритмах
3) опишите результаты - где, что эффективнее и почему.

ВНИМАНИЕ: ЗАДАНИЯ, В КОТОРЫХ БУДУТ ГОЛЫЕ ЦИФРЫ ЗАМЕРОВ (БЕЗ АНАЛИТИКИ)
БУДУТ ПРИНИМАТЬСЯ С ОЦЕНКОЙ УДОВЛЕТВОРИТЕЛЬНО
"""
import cProfile
import timeit
from random import random


# Проанализировать скорость и сложность одного любого алгоритма, разработанных в рамках домашнего задания первых трех
# уроков.

def myArr():
    N = 14
    arr = []
    for i in range(N):
        arr.append(int(random() * 100))

    indexMin = arr.index(min(arr))
    indexMax = arr.index(max(arr))
    minMy = min(arr)
    maxMy = max(arr)

    arr[indexMin] = maxMy
    arr[indexMax] = minMy
    return arr

def myArr2():
    N = 14
    arr = []
    for i in range(N):
        arr.append(int(random() * 100))
    arr.sort()

    minMy = arr[0]
    maxMy = arr[-1]

    arr[0] = maxMy
    arr[-1] = minMy
    return arr

print(timeit.timeit(myArr))
print(timeit.timeit(myArr2))
# Скорость на 2 наносекунды стала лучше