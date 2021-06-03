

import sys
sys.setrecursionlimit(10**8)
def findroomsr(i,matrix):
    #print(i)
    if matrix[i] == -2:
        return False
    elif matrix[i] == -1:
        return True
    elif front[matrix[i]]:
        matrix[i]=-2
        return False
    else :
        front[i] = True
        res = findroomsr(matrix[i],matrix)
        if(res):
            front[i]=False
            matrix[i]=-1
        else:
            matrix[i]=-2
        return res

def findrooms(matrix,m,n):
    E = m*n
    res = 0
    for i in range(E):
        #print("###")
        #print(i)
        if(not findroomsr(i,matrix)):
            res +=1
        #print(res)
    return res

def creatematrix(m,n,arr,matrix):
    for i in range(m):
        for j in range(n):
            x = j+n*i
            if arr[i][j] == 'R':
                if j+1>=n or j+1<0:
                    matrix[x]=-1
                else:matrix[x]=j+1+n*i
            elif  arr[i][j] == 'L':
                if j-1>=n or j-1<0:
                    matrix[x]=-1
                else:matrix[x]=j-1+n*i
            elif  arr[i][j] == 'U':
                if i-1>=m or i-1<0:
                    matrix[x]=-1
                else:matrix[x]=j+n*i-n
            elif  arr[i][j] == 'D':
                if i+1>=m or i+1<0:
                    matrix[x]=-1
                else:matrix[x]=j+n*i+n

def split(word):
    res = [char for char in word]
    if res[len(res)-1] == '\n':
        return res[:len(res)-1]
    else:return res
def read(filename):
    file_handle = open(filename, 'r')
    # Read in all the lines of your file into  a list of lines
    lines_list = file_handle.readlines()
    # Extract dimensions from first line. Cast values to integers from strings.
    cols, rows = (int(val) for val in lines_list[0].split())
    # Do a double-nested list comprehension to get the rest of the data into your matrix
    my_data = [split(line) for line in lines_list[1:]]
    return [cols,rows,my_data]
[m,n,arr]= read(sys.argv[1])
# print(m)
# print(n)
#print(arr)
matrix = [0]*(m*n)
front = [False]*(m*n)
creatematrix(m,n,arr,matrix)
#print(matrix)
print(findrooms(matrix,m,n))