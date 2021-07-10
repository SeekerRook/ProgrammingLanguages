# def f(x,y):
#     print(y+2*x)

# f(17,8)
# f('na','ba')


# def count_substr(test_str,K):
#     res = [test_str[i: j] for i in range(len(test_str)) for j in range(i + 1, len(test_str) + 1) if len(test_str[i:j]) == K]
#     return len(list(set(res)))
# print(count_substr("banana",2))
# a = b = 1
# c = [b]
# print(c)
# # def f(x):
# #     print(x)
# #     a = 3
# #     x = 2
# #     print(x)
# # def q1():
# #     f(a)
# #     print(a)

# # q1()
# def g(x):
#     print(" global b\nb = 3")
#     global b
#     b = 3
#     print("print(x[0])")
#     print(x[0])
#     print(" x[0] = 2")
#     x[0] = 2
#     print("print(c[0])")
#     print(c[0])
# def q2():
#     print(c)
#     g(c)

#     print(" print(c[0])")
#     print(c[0])
# q2()
def most_frequent(List):
    max = 0
    mc = 0
    for i in List:
        lc = List.count(i)
        if  lc > max:
            max = i
            mc = lc
  
    return (max, mc)

def sliding_helper(lis,k,res):
    if lis == [] : 
        print(most_frequent(res))
        return 1

    res.append(sum(lis[:4]))

    sliding_helper(lis[1:],k,res)

def sliding(lis,k):
   sliding_helper(lis,k,[])

sliding([1, 4, 2, 3, 2, 1, 3, 4, 2], 4)