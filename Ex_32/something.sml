fun max a b = if a > b then a else b;
fun first (a,b) = a;
fun second (a,b) = b;
fun generate_fs c 0 fs = fs (*generate possible final states*)
|   generate_fs c t fs =
    let 
        
        fun fill_cur 0 t l = l
        |   fill_cur c t l = fill_cur (c-1) t (l@[t])

        val cur = fill_cur c (t-1) []
    in      
        generate_fs c (t-1) (fs@[cur]) 
    end


fun maxes_n_sums [] is t max_n_sum = max_n_sum
|   maxes_n_sums (fslh::fslt) is t max_n_sum =
        let 
            fun find_max_n_sum [] [] tmax tsum = (tmax,tsum)
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
            maxes_n_sums fslt is t (max_n_sum @ [res])
        end (*possibly needs to calculate the check instead of creTING LIST OF MAXES*)

fun main c t is=
    let val fs = generate_fs c t []
    in maxes_n_sums fs is t []
    end 