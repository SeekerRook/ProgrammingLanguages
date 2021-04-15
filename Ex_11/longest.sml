fun checkfrac (sum : real)  (l : real)  (h : real)  = if(~1.0* sum/(h*l)>=1.0) then true else false
    | checkfrac (sum : int)  (l: int )   (h : int) = 
        let val Sr = Real.fromInt sum in
            let val Hr = Real.fromInt h in
                let val Lr = Real.fromInt l in
                    if(~1.0* Sr/(Hr*Lr)>=1.0) then true else false
                end
            end
        end 
   

(*fun inner_loop i arr n h sum maxlen =*)
    


(*fun longest filename*)