fun max a b = if a > b then a else b;

fun first_of_l (h::t) = h ;


(*generate possible final states*)
fun generate_fs c 0 fs = fs 
|   generate_fs c t fs =
    let 
        
        fun fill_cur 0 t l = l
        |   fill_cur c t l = fill_cur (c-1) t (l@[t])

        val cur = fill_cur c (t-1) []
    in      
        generate_fs c (t-1) (fs@[cur]) 
    end
(*tupple operations*)
fun first (a,b,c) = a;
fun second (a,b,c) = b;
fun third (a,b,c) = c;
fun min_tuple a b = 
    if (second a) < (second b) then a else b;

fun eq_tuple a b = if ((first a) = (first b)) andalso ((second a) = (second b)) andalso ((third a) = (third b)) then 1 else 0

(*find minimum fs*)
fun maxes_n_sums [] is t min  = min
|   maxes_n_sums (fslh::fslt) is t min  = 
        let 
            val town = first_of_l fslh

            (*find max and sum for this fs*)
            fun find_max_n_sum [] [] tmax tsum = (tmax,tsum,town)
            | find_max_n_sum (fsh::fst) (ish::ist) tmax tsum =
                let 
                fun find_diff fs is = 
                    if fs >= is then (fs - is) else (t - is + fs) 
                val diff = find_diff fsh ish 
                in 
                find_max_n_sum fst ist (max diff tmax) (tsum + diff)
                end
            val res = find_max_n_sum fslh is 0 0

        in
            (*check move validity for this fs (this doesn't allow consequent moves of the same car) *)
            if (2 * first res) <= (1+(second res) ) (*sum - max + 1 <= max*)
            
            then                
            maxes_n_sums fslt is t (min_tuple min  res)
            else
             maxes_n_sums fslt is t (min)
        end 

(*parse file*)
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
   	(n, h, readInts h [])
    end

fun round file =
    let 
        val (t,c,is) = parse file
        val fs = generate_fs c t []
        val tuple = maxes_n_sums fs is t (0,(c*t),0)
        val sum = second tuple 
        val town = third tuple
    in 
        print (Int.toString(sum) ^ " " ^ Int.toString(town) ^ "\n")
    end 
