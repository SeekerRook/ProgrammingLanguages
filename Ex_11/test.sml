fun comp (l, m) = 0

fun qsort comp =
    let fun sort [] = []
          | sort (lhd :: ltl) =
                sort (List.filter (fn x => (comp (x, lhd)) ltl))
              @ [lhd]
              @ sort (List.filter (fn x => not (comp(x, lhd)) ltl))
    in sort
    end
