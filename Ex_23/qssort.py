
###Contains code from: https://www.geeksforgeeks.org/find-minimum-depth-of-a-binary-tree/
###                    https://codereview.stackexchange.com/questions/191984/perform-bfs-on-a-binary-tree
## Queue & Stack functions
import sys
def pop(l):
    l.reverse()
    r =  l.pop()
    l.reverse()
    return r

def push (s,n):
    s.reverse()
    s.append(n)
    s.reverse()

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
    visited = []
    if t:
        visited.append(t)

    current = t
    res = ""
    while current :
        if (issorted(current.queue) and len(current.stack) == 0):
            
            print(current.path)
            
            break
        ql = current.queue[:]
        sl = current.stack[:] 
        qr = current.queue[:]
        sr = current.stack[:]
        # print("########")
        # print("before")
        # print(ql)
        # print(sl)
        Q(ql,sl)
        # print("after q")
        # print(ql)
        # print(sl)                 
        S(qr,sr)
        # print("after s")
        # print(qr)
        # print(sr)
        current.left = Node(ql,sl,current.path + "Q")  
        current.right = Node(qr,sr,current.path+"S")
        if current.left:
            #current.left.prt()
            res += "Q"
            visited.append(current.left)
        if current.right:
            res += "R"
            #current.right.prt()
            visited.append(current.right)
        visited.pop(0)
        #if not visited:
        #    break
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
    for i in lines_list[1]:
        if i.isdigit() == True:
            data.append(int(i))
    return [l,data]

[l,data] = read(sys.argv[1])

q = data
s = []
root = Node(q,s,"")
BFS(root)

        
