import java.util.*;


import java.io.*;
class Node{ //Node Class


     Deque<Integer> Q; // Queue
     Stack<Integer> S; // Stack
     String getQS(){   
        return(Q.toString() + S.toString());
     }
     String path;      //path to append in Searched Set
     public Node(Deque<Integer> Qin ,Stack<Integer> Sin,String pathin) //constructor
     {
         Q = Qin;
         S = Sin;
         path = pathin;
     }
     public Node(Node node)//copy constructor
     {
         Q = new LinkedList<Integer>(node.Q);
         S = new  Stack<Integer>();
         S.addAll(node.S);
         path = node.path;
     }

     public void print(){//function to print Node used during Debugging
        System.out.println("######NODE#####");
        System.out.println("Q : " + this.Q);
        System.out.println("S : " + this.S);
        System.out.println("Path : " + this.path);
    }

}

public class QSsort{
    static int min;//Min Element of Queue
    static int max;//Max Element of Queue

   static Set<String> Searched = new HashSet<String>();//Set to keep Searched Nodes for O(1) search
   static Queue<Node> visited = new LinkedList<Node>();// List of visited Nodes for BFS

    static void Q (Queue<Integer>Qin, Stack<Integer> Sin){// Execute Q in given Queue and Stack
        if (Qin.size()!=0){
        int Ele = Qin.poll();
        Sin.push(Ele);
        }
    }
        
    static void S (Queue<Integer>Qin, Stack<Integer> Sin){// Execute S in given Queue and Stack
        if (Sin.size()!=0){
        int Ele = Sin.pop();
        Qin.add(Ele);
        }
    }
    
    static boolean issorted_h (Queue<Integer> Q){ // helping function for issorted
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

    static boolean issorted(Queue<Integer> Q){ //true if Queue is sorted
        Queue<Integer> Copy = new LinkedList<Integer> (Q);
        return issorted_h(Copy);
    }


    static void addnew (Node N){ // add a Searched node in visited and Searched

        if ((!Searched.contains(N.getQS())) && N!= null){
            visited.add(N);
            Searched.add(N.getQS());
            // System.out.println(Searched);
        }
    }
    static void Qmove(Node N){ // Execute Q Move and Add to visited
        Node Next = new Node(N);
        Q(Next.Q,Next.S);
        Next.path = N.path + "Q";
        addnew(Next);
    }
    static void Smove(Node N){ // Execute S Move and Add to visited
        Node Next = new Node(N);
        S(Next.Q,Next.S);
        Next.path = N.path + "S";
        addnew(Next);
    }
    static void BFS(Node current){ // BFS Search
        while (current != null){


        if (issorted(current.Q) && current.S.empty()){// if Queue is sorted and Stack is empty we found the solution
            if (current.path == "" ) System.out.println("empty");
            else  System.out.println(current.path);
            break;
        }
        else{
        // here are conditions for which we can skip searching both Q and S move
        if (current.S.empty() ){// if S is empty we can only do Q 
            Qmove(current);
        }
        else if (current.Q.peek() == null){// if Q is emptt we can only do S
            Smove(current);
        }
        else {
            int Qft = current.Q.peekLast();
            int Qhd = current.Q.peek();
            int Shd = current.S.peek();
            String last = current.path.substring(current.path.length() - 1);
    
        // here we try to put equal elements together by forcing Q and S moves when necessary
         if (Shd == Qhd){
            Qmove(current);
        }        
        else if ((Shd == Qft )&& ( last == "S")){ 
            Smove(current);
        }
        // in every other case we search both possible moves
        else {//normal
        Qmove(current);
        Smove(current);
        }
    }
        visited.poll();

        // BFS (visited.peek());
        current = visited.peek();// Examine next element of visited
        
        }
    
    }
}

    public static void main(String args[])
    {
       try{//parse file
        Deque<Integer> Q = new LinkedList<Integer>();
 
        Stack<Integer> S = new Stack<Integer>();
        try{
            BufferedReader reader = new BufferedReader(new FileReader(args[0]));
            String line1 = reader.readLine();
            String line2 = reader.readLine();
            reader.close();
            int count = Integer.parseInt(line1);
            String[] Questr = line2.split(" ");
            for(int i = 0; i < count; i++){
                Q.add(Integer.parseInt(Questr[i]));        
            }
        
        // create root node
        Node root = new Node(Q,S,"");
        min = Collections.min(Q);
        max = Collections.max(Q);
        // add root in visited and Searched
        visited.add(root);
        Searched.add(root.getQS());
        // Do BFS to find best solution
        BFS(root);
   
        }

        catch (IOException e){// handle Wrong Arguments
            e.printStackTrace();
        }
    }catch(StackOverflowError e){// Used to Debug Stack Overflow Exception
        System.out.println(visited.peek().S.size());
    }

    }
}