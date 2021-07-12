import sys
def cars_of_city (state,t):
    res = [0]*t
    for car in state:
        res[car]+=1
    return res

def sum_from_zero (state,t):
    max = 0
    sum = 0
    i = 0
    for car in state :
        if i != 0 :
            sum += car * (t-i)
        print ("i",i)
        print ("sum",sum)
        if car >= max:
            max = car
        i +=1
    return (max,sum)

def rot_increment (l,i):
    if i < l-1 :
        i+=1
    else: 
        i = i - l + 1
    return i

def next_non_zero (lis,i):
    l= len(lis)
    i = rot_increment (l,i)
    while lis[i]==0 :
        i = rot_increment(l,i)
    return i

def search (c,t,lis,sum,max):
    min = sum
    mint = 0
    main = 1
    sec = 2
    l = len(lis)
    while main <= l-1 :

        if (main == sec):
            sec = next_non_zero(lis,sec)
        if main >= sec :
           diff = (main - sec)
        else:
           diff = (t - sec + main)

        sum += c-(t * lis[main])
        if (sum + 1 >= 2*diff ):

            if min > sum : 
                min = sum
                mint = main

        print ("     STATUS  #")  
        print ("main -> ", main)
        print ("sec -> ", sec)
        print ("sum -> ", sum)
        print ("maxn -> ", diff)
        print ("min -> ", min)
        print ("mint -> ", mint)
        print ("#            #")
        main +=1 

    return (min,mint) 



#print( search (4,5,[1,0,3,0,0],9,3))
# print (rot_increment (int(sys.argv[1]),int(sys.argv[2])))
print( sum_from_zero([1,0,3,0,0],5))