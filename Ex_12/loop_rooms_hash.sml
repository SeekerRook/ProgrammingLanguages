(* 
fun findroomsr i matr front = 
    let val A = Array.sub (matr,i)
    in
    (* print (Int.toString i ^ "\n"); *)
    if A = ~2
    then (front,false)
    else
        if A = ~1
        then (front,true)
        else 
            if Array.sub(front,i) = true
            then (
                Array.update(matr,i,~2);(**)
                (front,false)
            )
            
            else 
                (
                
                    let 
                        val g = Array.update(front,i,true)
                        val (f,result) = findroomsr A matr front 
                    in
                        if result = true
                        then(
                            Array.update(front,i,false);
                            Array.update(matr,i,~1);(**)
                            (f, result)
                        )
                        else(
                            Array.update(matr,i,~2);(**)
                            (f,result)
                        ) 
                    end
                )
    end

fun findrooms matr m n = 
let val matrix = Array.fromList(matr)
in
    let 
        fun forloop ~1 matrix m n = 0
        | forloop i matrix m n = 
            let val (f , r) = findroomsr (i) matrix (Array.array(1000000,false))
            in
            if r = false
            then (forloop (i-1) matrix m n)+1
            else (forloop (i-1) matrix m n)
            end
        
    in
        forloop (m*n-1) matrix m n 
    end
end *)

(* fun creatematrix 0 m n arr  = matrix *)

(* ****EDO MPORI NA PAEI KATI POLI KAKA**** *)
fun make_key x m n arr  = 
        let 

            val check = Array.sub(arr, x) 
        in
 
             case check of
                #"R" => (
                    if ((x+1) mod n) = 0
                    then ~1
                    else x+1
                ) 
                | #"L" => (
                    if ((x) mod n) = 0
                    then ~1
                    else (x-1)
                )
                | #"U" => (
                    if (x-n) < 0
                    then ~1
                    else (x-n)
                ) 
                | #"D" => (
                    if (m*n - x) <= n
                    then ~1
                    else (x+n)
                )
                | _ =>  ~42
                
            
        end
fun create_HT arr m n = 
let
  val I_IDX = ref 0
  val ht : (string, int list) HashTable.hash_table = HashTable.mkTable (HashString.hashString, op=) (n+1, Fail "not found")

in
  while !I_IDX < n*m do(
      let val str_key = Int.toString((make_key (!I_IDX) m n arr ))
      in
      (if HashTable.find ht (str_key) = NONE then
      (
          HashTable.insert ht (str_key, [!I_IDX])
      )
      else(
          HashTable.insert ht (str_key, !I_IDX:: (HashTable.lookup ht (str_key)))
      ));
     
        (* HashTable.insert ht (str_key); *)
       I_IDX := !I_IDX +1
    end
  );
  ht
end

fun parse file =
    let
    (* A function to read an integer from specified input. *)
        fun readInt input = 
        Option.valOf (TextIO.scanStream (Int.scan StringCvt.DEC) input)

    (* Open input file. *)
    	val inStream = TextIO.openIn file

        (* Read an integer (number of countries) and consume newline. *)
    val m = readInt inStream
    val n = readInt inStream
    val _ = TextIO.inputLine inStream

    fun readLines acc = 
        case TextIO.inputLine inStream of
            NONE => rev acc
            | SOME line => readLines (rev (explode (String.substring(line,0,n)) )@ acc)

    val inputList = readLines []:char list 
    val _ =TextIO.closeIn inStream
    in
   	(m, n, Array.fromList (inputList))
    end


val global_sum = ref 0


fun findrooms ht key = 
let
  val search_res = HashTable.find ht (Int.toString(key))
in
    global_sum := !global_sum + 1;
  if search_res <> NONE then
  (
    (* print("IPARXEI KAPIOS POU KITAEI SE MENA\n"); *)
    (* global_sum := !global_sum + 1; *)
    let
      val myval = map (findrooms ht) (HashTable.lookup ht (Int.toString(key)))
    in
      ()
    end
    
  )
  else ()
end
    

fun loop_rooms filename = 
    let 
        val (m , n, arr) = parse filename
        val ht = create_HT arr m n
        (* val res = findrooms matrix m n  *)
        val I_IDX = ref 0 
        val exits = HashTable.lookup ht (Int.toString(~1));
    in
    (   global_sum := 0;
        (* while !I_IDX < m*n do
        (
            (if (HashTable.lookup ht (Int.toString(!I_IDX))) = ~1 then
            (   
                (* print("KATAFERA NA VRO -1 STO IDX: "^Int.toString(!I_IDX)^"\n"); *)
                findrooms ht (!I_IDX)
            )
            else());
            I_IDX := !I_IDX + 1
        ); *)
        
        List.map (findrooms ht) exits;
        print(Int.toString( m*n - (!global_sum))^"\n") 
        (* HashTable.lookup ht "0" *)
    )
        (* creatematrix (m*n) m n arr [] *)
        (* print (Int.toString res ^ "\n") *)
    end