
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
                            else () 
                        else 
                            if j <> n 
                            then 
                                innerloop i (j+1) arr sum1 h maxLen n 
                            else () ) 
                    else
                        if j <> n 
                        then innerloop i (j+1) arr sum1 h maxLen1 n 
                        else ()
                    

                
                end
            end
        end
                
        
    )     
fun outloop

(*fun inner_loop i arr n h sum maxlen =*)
    


(*fun longest filename*)