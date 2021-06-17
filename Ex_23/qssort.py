
###Contains code from: https://www.geeksforgeeks.org/find-minimum-depth-of-a-binary-tree/
###                    https://codereview.stackexchange.com/questions/191984/perform-bfs-on-a-binary-tree
## Queue & Stack functions
import sys
from collections import deque
def pop(l):
    r =  l.pop(0)
    return r

def push (s,n):
    s.insert(0,n)

def append(q,n):
    q.append(n)

def peek (l):
    if len(l)!=0:
        return l[0]
    else: return 0

def show(q,s):
    print("Q: <",end = '' )
    print(q,end = '' )
    print("<")
    print("S: -",end = '')
    print(s)
    print("")

def Q (q,s):
    if(len(q) == 0):return [q,s]
    n = pop(q)
    push(s,n)
    return [q,s]

def S(q,s):
    if(len(s) == 0):return [q,s]
    n = pop(s)
    append(q,n)
    return [q,s]

def issorted(l):
    r = True
    if(len(l)) == 0 : r = False #not sure
    else:
        for i in range (len(l)-1):
            if l[i] > l[i+1]:
                r = False
    return r


# Tree Functions
class Node:
    def __init__(self , queue, stack, path):
        self.queue = queue
        self.stack = stack
        self.path = path
        self.left = None
        self.right = None

    def prt(self):
        print("#####Node####")
        print("Q:")
        print(self.queue)
        print("S:")
        print(self.stack)
        print("Left")
        print(self.left)
        print("Right")
        print(self.right)
        print("Path")
        print(self.path)
        print("############")

def BFS(t):
    """In BFS the Node Values at each level of the Tree are traversed before going to next level"""
    visited = deque()
    if t:
        visited.append(t)
    Searched = set()
    current = t
    res = ""
    while current :
        if (issorted(current.queue) and len(current.stack) == 0):
            
            if(len(current.path) == 0):
                print("empty")
            else: 
                print(current.path)
         
            break
        ql = current.queue[:]
        sl = current.stack[:] 
        qr = current.queue[:]
        sr = current.stack[:]

        Q(ql,sl)
              
        S(qr,sr)

        current.left = Node(ql,sl,current.path + "Q")  
        current.right = Node(qr,sr,current.path+"S")
        if current.left:
            #current.left.prt()
            res += "Q"
            if (not str(current.left.queue) + '-' + str(current.left.stack) in Searched):
                visited.append(current.left)
                Searched.add(str(current.left.queue) + '-' + str(current.left.stack))
        if current.right:
            res += "S"
            #current.right.prt()
            if (not str(current.right.queue) + str(current.right.stack) in Searched):
                visited.append(current.right)
                Searched.add(str(current.right.queue) + str(current.right.stack))

        visited.popleft()
        res = res[:len(res)-2]
        current = visited[0]



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
    l = lines_list[0]
    data = []
    temp = 0
    for i in lines_list[1]:
        if i.isdigit() == False:
            data.append(temp)
            temp = 0
        else: temp = 10*temp + int(i)
    if (temp != 0):
        data.append(temp)
    return [l,data]

[l,data] = read(sys.argv[1])
q = data
s = []
root = Node(q,s,"")
BFS(root)

        
