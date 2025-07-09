# 实现一个简单的冒泡排序

def bubble_sort(arr):
    n = len(arr)
    for i in range(n):
        for j in range(0, n - i - 1):
            if arr[j] > arr[j + 1]:
                arr[j], arr[j + 1] = arr[j + 1], arr[j]
    return arr

if __name__ == "__main__":
    nums = [5, 2, 9, 1, 5, 6]
    print("排序前:", nums)
    sorted_nums = bubble_sort(nums)
    print("排序后:", sorted_nums)
