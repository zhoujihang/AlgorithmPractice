#! usr/bin/python
# coding=utf-8


def heapSort(arr: list):
    # 堆排序思路
    # 一 构建最小二叉堆（结果为降序） 或者 最大二叉堆（结果为升序）
    # 二 交换排序区间首位元素
    index_max = len(arr) - 1
    for i in range(index_max, -1, -1):
        # 构建最小（最大）堆
        buildHeap(arr, i + 1, isMinHeap=False)
        # 交换元素
        temp = arr[0]
        arr[0] = arr[i]
        arr[i] = temp
        print("堆调整 ----- ：" + list2str(arr))


def buildHeap(arr: list, length: int, isMinHeap: bool):
    # 构建二叉堆思路
    # 一 遍历 [i...0] 根节点索引 i 左子节点索引 i*2+1  右子节点索引 i*2+2
    # 二 循环中，将当前根及左右子节点中最小（最大）的节点交换到根节点位置
    # isMinHeap (True 构建小顶堆; False 构建大顶堆)
    if length <= 1:
        return
    root_index_max = length - 1
    if root_index_max % 2 == 0:
        root_index_max = int((root_index_max - 2) / 2)
    else:
        root_index_max = int((root_index_max - 1) / 2)
    for i in range(root_index_max, -1, -1):
        root_index = i
        left_index = i * 2 + 1
        right_index = i * 2 + 2
        root = arr[root_index]
        node = arr[left_index]
        is_left_node = True
        if right_index < length:
            right = arr[right_index]
            if (isMinHeap and right < node) or ((not isMinHeap) and right > node):
                node = right
                is_left_node = False
        if (isMinHeap and node < root) or ((not isMinHeap) and node > root):
            temp = node
            if is_left_node:
                arr[left_index] = root
            else:
                arr[right_index] = root
            arr[root_index] = temp


def list2str(arr: list) -> str:
    return ', '.join(str(i) for i in arr)


def main():
    arr = [1, 3, 4, 5, 11, 2, 9, 0, -4, 22, 3]
    print("堆排序 before: " + list2str(arr))
    heapSort(arr)
    print("堆排序  after: " + list2str(arr))


if __name__ == "__main__":
    main()
