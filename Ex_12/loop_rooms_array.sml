
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
end

fun creatematrix 0 m n arr matrix = matrix
	| creatematrix x m n arr matrix = 
		let 

			val check = Array.sub(arr, x-1) 
		in
 
			 case check of
				#"R" => (
					if ((x) mod n) = 0
					then
					creatematrix (x-1) m n arr (~1::matrix) 
					else
					creatematrix (x-1) m n arr (x::matrix) 
				) 
				| #"L" => (
					if ((x-1) mod n) = 0
					then
					creatematrix (x-1) m n arr (~1::matrix)
					else
					creatematrix (x-1) m n arr (x-2::matrix) 
				)
				| #"U" => (
					if (x-n-1) < 0
					then
					creatematrix (x-1) m n arr (~1::matrix)
					else
					creatematrix (x-1) m n arr (x-n-1::matrix)
				) 
				| #"D" => (
					if (m*n - x+1) <= n
					then
					creatematrix (x-1) m n arr (~1::matrix)
					else
					creatematrix (x-1) m n arr (x+n-1::matrix)
				)
				| _ =>  matrix
				
			
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



fun loop_rooms filename = 
	let 
		val (m , n, arr) = parse filename
		val matrix = creatematrix (m*n) m n arr []
		val res = findrooms matrix m n 
	in
		(* creatematrix (m*n) m n arr [] *)
		print (Int.toString res ^ "\n")
	end
