(* fun double_pairs [] = [] |
    double_pairs (h::t) = [[h,2*h]] @ double_pairs t; *)

(* fun c ls =
let fun d [] n m = Int.max(n,m)
    |d (42 :: t) n m = d t (n + 1) (Int.max((n+1),m))
    |d (h :: t) n m =  d t 0 (Int.max(n,m))
in  d ls 0 0
end *)
(* fun common_prefix x y =
    let fun aux (h1 :: t1) (h2 :: t2) prefix =
        if h1 = h2 then aux t1 t2 (prefix @ [h1]) else (prefix, (h1::t1), (h2::t2))
    | aux s1 s2 prefix = (prefix, s1, s2)
in  aux x y []
end *)
datatype 'a tree = empty | node of 'a * 'a tree * 'a tree;