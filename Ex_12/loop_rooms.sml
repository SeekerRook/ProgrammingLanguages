
fun findroomsr i matr front = 
	let val A = List.nth (matr,i)
	in
		if A = ~1
		then (front,true)
		else 
			if List.exists (fn x => x = A) front
			then (front,false)
			else 
				(
				
					let val (f,result) = findroomsr A matr (i::front) 
					in
						if result = true
						then(
							([], result)
						)
						else (f,result)
					end
				)
	end

fun findrooms matr m n = 
	let 
		fun forloop 0 matr m n = 0
		| forloop i matr m n = 
			let val (f , r) = findroomsr (i) matr []
			in
			if r = false
			then (forloop (i-1) matr m n)+1
			else (forloop (i-1) matr m n)
			end
		
	in
		forloop (m*n-1) matr m n 
	end

fun creatematrix 0 m n arr matrix = matrix
	| creatematrix x m n arr matrix = 
		let 

			val check = List.nth(arr, x-1) 
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
   	(m, n, inputList)
    end



fun loop_rooms filename = 
	let 
		val (m , n, arr) = parse filename
		val matrix = creatematrix (m*n) m n arr []
		val res = findrooms matrix m n 
	in
		creatematrix (m*n) m n arr []
		(* print (Int.toString res ^ "\n") *)
	end
