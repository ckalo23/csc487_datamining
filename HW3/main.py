import numpy as np  # we'll use NumPy array rather than lists


# min_max takes in the array 'a' which is filled with user-inputted floats
#   in the for-loop.  It also takes user inputted floats 'n_min' & 'n_max'
#   for the new range after the normalization
# min_max returns the array 'a' after the min-max norm. formula is performed.
def min_max(a, n_min, n_max):
    a = (a - a.min()) / (a.max() - a.min()) * (n_max - n_min) + n_min
    return a


n = int(input("Size of array: "))  # user inputs int for array-size
mi = float(input("New min: "))  # user inputs new minimum after norm
ma = float(input("New max: "))  # user inputs new maximum after norm

arr = np.array([], float)  # 'arr' is an empty NumPy array w/ float data type

# To use normalization on 'age', I incl. the data from HW:
#   You may swap the two 'print' call parameter 'arr' with 'age'
#   and comment out the for loop to take in values from user input.
age = np.array([3, 15, 16, 16, 19, 20, 20, 21, 22, 22, 25, 25, 25, 25,
                30, 33, 33, 35, 35, 35, 35, 36, 40, 45, 46, 52, 70], float)

# for loop for appending user-inputted floats to the array 'arr' using
# NumPy (range of 'n' also using previous user input for size of array)
for i in range(n):
    # 'arr' becomes the concatenation of old 'arr' with most recent input
    arr = np.append(arr, (float(input("Element: "))))

# print the original array 'arr' and the results of 'arr' after normalizing
print(arr)
print(min_max(arr, mi, ma))
