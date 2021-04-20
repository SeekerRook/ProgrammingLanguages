
fun checkfrac sumi li hi =  if(~1.0* Real.fromInt sumi / (Real.fromInt hi *Real.fromInt li)>=1.0) then true else false;

(* fun innerloop i j arr sum h maxLen = *)
fun innerloop i j arr sum h maxLen n =
    (

        let val sum1 = sum + List.nth(arr,j)
            in 
            let val l = j - i + 1
                in
                let val maxLen1 = l
                    in
                    if checkfrac sum1 l h  
                    then 
                        (if l > maxLen 
                        then 
                            if j <> n 
                            then innerloop i (j+1) arr sum1 h maxLen1 n 
                            else maxLen1 
                        else 
                            if j <> n 
                            then 
                                innerloop i (j+1) arr sum1 h maxLen n 
                            else maxLen ) 
                    else
                        if j <> n 
                        then innerloop i (j+1) arr sum1 h maxLen n 
                        else maxLen
                    

                
                end
            end
        end
                
        
    )     
(* fun loop i arr n h =
    ( 
    let val sum = List.nth(arr, i)
        in 
        if checkfrac sum1 1 h  
        then 
            (if l > maxLen 
            then 
                if j <> n 
                then innerloop i (j+1) arr sum1 h maxLen1 n 
                else maxLen1 
            else 
                if j <> n 
                then 
                    innerloop i (j+1) arr sum1 h maxLen n 
                else maxLen ) 
        else
            if j <> n 
            then innerloop i (j+1) arr sum1 h maxLen n 
            else maxLen
                    
    ) *)
(*fun inner_loop i arr n h sum maxlen =*)
    
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