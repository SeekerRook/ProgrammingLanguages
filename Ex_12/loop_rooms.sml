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

	fun readLines acc = 
		case TextIO.inputLine inStream of
			NONE => rev acc
			| SOME line => readLines (explode (String.substring(line,0,h)) :: acc)

    val inputList = readLines []:char list list
	val _ =TextIO.closeIn inStream
	in
   	(n, h, inputList)
    end
