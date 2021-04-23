
fun min a b = 
    if a < b then a else b
fun max a b = 
    if a > b then a else b
fun compare a1 a2 b1 b2 =
    if a1 = b1 
    then a2<b2
    else a1< b1

fun fIwhile false h l preSum ans v = ans
    | fIwhile true h l preSum ans v =
    let 
        val check = (l <= h)
        val mid = ( l + h )div 2 (*originally /*)
    in 
        if Array.sub((Array.sub(preSum,mid)),0) <= v
        then  fIwhile check h (mid+1) preSum mid
        else  fIwhile check (mid-1) l preSum ans
    end

fun findInd preSum n v = 
    let 
        val l = 0
        val h = n-1
        val ans = ~1
    in 
        fIwhile (l<=h) h l preSum ans v (**)
    end

fun for1 x arr 0 = arr (**)
    | for1 x arr i =
        let val old = Array.sub (arr , i-1)
        in 
            let val a = Array.update (arr , i-1, old-x)
            in
                for1 x arr i-1
            end

        
        end

fun for2 sum arr preSum 0 = preSum (*no macj=hing types*)
    | for2 sum arr preSum i =
        let val s = sum + Array.sub(arr,i)
        in 
           let val a = Array.array (2,0)
           in
            Array.update(a, 0, s);
            Array.update(a, 1, i);
            
            for2 s arr (a::preSum) i-1
            end
        end

fun for3 minInd preSum 1 = minInd (*here preSum is array*)(*ADD Let in end*)
    | for3 minInd preSum i = 
        Array.update (minInd , (i-1), (min Array.sub(minInd, (i-2)) Array.sub(Array.sub(preSum,i-1),1)));
        for3 minInd preSum i-1

fun for4 sum arr n preSum minInd maxlen 0 = maxlen
    |  for4 sum arr n preSum minInd maxlen i =
        let 
            val s = sum + Array.sub(arr, i)
        in
            let val ind = findInd preSum n s
            in let
            val mi = Array.sub(minInd , ind)
            in 
                if s >= 0
                then for4 s arr preSum (i) i-1 
                else 
                    if ((ind <> ~1) andalso (mi < i))
                    then
                    for4 s arr preSum (max (maxlen, mi)) i-1
                    else
                    for4 s arr preSum maxlen i-1
            end
            end
        end
(*stolen quicksort*)
fun qsort compare =
    let fun sort [] = []
          | sort (lhd :: ltl) =
                sort (List.filter (fn x => (compare (x, lhd)) ltl))
              @ [lhd]
              @ sort (List.filter (fn x => not (compare(x, lhd)) ltl))
    in sort
    end




fun LongestSub arr n x = 0;



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
	fun readInts 0 acc = acc (* Replace with 'rev acc' for proper order. *)
	  | readInts i acc = readInts (i - 1) (readInt inStream :: acc)
    in
   	(n, h, readInts n [])
    end

(*fun longest filename*)