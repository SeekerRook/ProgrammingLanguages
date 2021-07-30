import java.util.*;
class Node{


     Queue<Integer> Q;
     Stack<Integer> S;
     String getQS(){
         return(Q.toString() + S.toString());
     }
     String path;
     Node left;
     Node right;
     public Node(Queue<Integer> Qin ,Stack<Integer> Sin,String pathin)
     {
         Q = Qin;
         S = Sin;
         path = pathin;
         left = right = null;
     }
     public Node(Node node)
     {
         Q = new LinkedList<Integer>(node.Q);
         S = new  Stack<Integer>();
         S.addAll(node.S);
         path = node.path;
         if (node.left == null) left = null;
         else left = new Node (node.left);
         if (node.right == null) right = null;
         else right = new Node (node.right);
     }

     public void print(){
        System.out.println("######NODE#####");
        System.out.println("Q : " + this.Q);
        System.out.println("S : " + this.S);
        System.out.println("Path : " + this.path);
    }

}

public class QSsort{
    //Root of the Binary Tree
   static Set<String> Searched = new HashSet<String>();
   static Queue<Node> visited = new LinkedList<Node>();

    static void Q (Queue<Integer>Qin, Stack<Integer> Sin){
        if (Qin.size()!=0){
        int Ele = Qin.poll();
        Sin.push(Ele);
        }
    }
        
    static void S (Queue<Integer>Qin, Stack<Integer> Sin){
        if (Sin.size()!=0){
        int Ele = Sin.pop();
        Qin.add(Ele);
        }
    }
    
    static boolean issorted_h (Queue<Integer> Q){
        if (Q.isEmpty() || Q.size() == 1) return true;
        int First = Q.poll();
        int Second = Q.peek();
        if (First > Second) {
            return false;
        }
        else {
           return issorted(Q);
        }


    }

    static boolean issorted(Queue<Integer> Q){
        Queue<Integer> Copy = new LinkedList<Integer> (Q);
        return issorted_h(Copy);
    }
    
    static void BFS(Node current){
        
        if (current == null){System.out.println("ERROR Null Node");
        
        }
        else{
        if (issorted(current.Q) && current.S.empty()){
            if (current.path == "" ) System.out.println("empty");
            else  System.out.println(current.path);
        }
        else{
        current.left = new Node(current);
        Q(current.left.Q,current.left.S);
        current.left.path = current.path + "Q";
        current.right = new Node(current);
        S(current.right.Q,current.right.S);
        current.right.path = current.path + "S";
        if (!Searched.contains(current.left.getQS())){
            visited.add(current.left);
            Searched.add(current.left.getQS());
            // System.out.println(Searched);
        }
        if (!Searched.contains(current.right.getQS())){
            visited.add(current.right);
            Searched.add(current.right.getQS());
            // System.out.println(Searched);
        }
        visited.poll();
        BFS (visited.peek());
    }

    }
    }

    public static void main(String args[])
    {
       
        Queue<Integer> Q = new LinkedList<Integer>();

        Q.add(1);
        Q.add(3);
        Q.add(4);
        Q.add(2);
        
        Stack<Integer> S = new Stack<Integer>();
        // S.push(3);
        Node root = new Node(Q,S,"");


        visited.add(root);
        Searched.add(root.getQS());
        BFS(root);
        // System.out.println(root.getQS());    
        

    }
}