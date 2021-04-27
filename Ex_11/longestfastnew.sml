
fun second (a , b)= b;
fun first (a , b)= a;

fun min2 (a,b)=
    if a < b then a else b
fun min a b = 
    if a < b then a else b
fun max (a, b) = 
    if a > b then a else b
fun compare a1 a2 b1 b2 = (*to be deleted*)
    if a1 = b1 
    then a2<b2
    else a1< b1
fun tupleCompare ((x1,y1), (x2,y2)) =
  let
    val firstComp = Int.compare (x1,x2)
    val secondComp = Int.compare (y1,y2)
  in
    if (firstComp = EQUAL)
    then secondComp
    else firstComp
  end;

fun fIwhile false h l preSum ans v = ans
    | fIwhile true h l preSum ans v =
    let 
        val check = (l <= h)(**)
        val mid = ( l + h )div 2 (*originally /*)
    in 
        if first(Array.sub(preSum,mid)) <= v
        then  fIwhile ((mid+1)<=l) h (mid+1) preSum mid v
        else  fIwhile (l<=(mid-1)) (mid-1) l preSum ans v
    end

fun findInd_old preSum n v = 
    let 
        val l = 0
        val h = n-1
        val ans = ~1
    in 
        fIwhile (l<=h) h l preSum ans v 
    end

fun findInd presum v n = 
let
  val l = ref 0
  val h = ref (n-1)
  val mid = ref 0
  val ans = ref ~1
in
  (
      while !l <= !h do
      (
          mid := (!l + !h)div 2;

          if first (Array.sub(presum, !mid )) <= v then
          (
              ans := !mid;
              l := !mid +1 
          )
          else
          (
              h := !mid -1
          )
      );
      !ans
  )
end

fun for1 x arr 0 = arr 
    | for1 x arr i =
        let val old = Array.sub (arr , (i-1))
        in 
            let val a = Array.update (arr , (i-1), ~1*(old)-x)
            in
                for1 x arr (i-1)
            end

        
        end

fun for2 sum arr preSum ~1 n = preSum 
    | for2 sum arr preSum i n =
    if (i = n )then for2 sum arr preSum ~1 n else(
        let val s = sum + Array.sub(arr,i)
        in 

            let val a = (s,i)
           in
           
            
            for2 s arr (a::preSum) (i+1) n
            end
        end
    )
fun for3 minInd preSum ~1 n= minInd 
    | for3 minInd preSum i n = 
        if (i = n)then for3 minInd preSum ~1 n else(
        let val x = Array.update (minInd , i, (min2 (Array.sub(minInd, (i-1)), second(Array.sub(preSum,(i))))))
        in
        
        for3 minInd preSum (i+1) n
        end
        )



fun loop4 arr minInd preSum n= 
let 
val cur_sum = ref 0
val I_IDX = ref 0
val max_len = ref 0
val ind = ref 0 
in 
(while !I_IDX < n do(
    cur_sum := !cur_sum + Array.sub(arr, !I_IDX);

    (if (!cur_sum >= 0) 
    then (
        max_len := (!I_IDX + 1 )
    )
    else(
        ind := findInd preSum (!cur_sum) n;
        (if !ind <> ~1 andalso Array.sub(minInd, !ind)< !I_IDX then(
            max_len := max (!max_len, (!I_IDX - Array.sub(minInd, !ind)))
        )else())
    );
    I_IDX := !I_IDX + 1
));

 print(Int.toString (!max_len))
 
)
end 


fun insert x [] = [x]
    | insert x (y::ys) =
        if tupleCompare (x,y) = LESS
        then x::y::ys
        else y::(insert x ys)
fun insertionsort [] = []
| insertionsort (x::xs) = insert x (insertionsort xs)

fun LongestSub arr n x = 
let val a = for1 x arr n
in let val preSum = rev(for2 0 a [] 0 n)
    in 
        let val preSumsorted = Array.fromList ((insertionsort preSum))
        in  let val minInd = Array.array(n,0)
            in
                let val w = Array.update(minInd, 0,second(Array.sub(preSumsorted,0)))
                in
                    let val minInd2 = for3 minInd preSumsorted 1 n
                    
                    in loop4 a minInd2 preSumsorted n
                    end
                end
            end
        end
    end
end




fun parse file =
    let
	(* A function to read an integer from specified input. *)
        fun readInt input = 
	    Option.valOf (TextIO.scanStream (Int.scan StringCvt.DEC) input)

	(* Open input file. *)
    	val inStream = TextIO.openIn file

        (* Read an integer (number of countries) and consume newline. *)
	val n = readInt inStream
	val h = readInt inStream
	val _ = TextIO.inputLine inStream

        (* A function to read N integers from the open file. *)
	fun readInts 0 acc = rev acc (* Replace with 'rev acc' for proper order. *)
	  | readInts i acc = readInts (i - 1) (readInt inStream :: acc)
    in
   	(n, h, readInts n [])
    end

(*fun longest filename*)
fun longest filename = 
    let val (n,h,ptr )= parse filename
    in 
        let val arr = Array.fromList( ptr )
        in
            let val result = LongestSub arr n h
            in print (Int.toString result ^ "\n")
            (* in() *)
            end
        end
    end

