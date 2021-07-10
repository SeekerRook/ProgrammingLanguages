import java.util.*;
class Node{
    public void print(){
        System.out.println("######NODE#####");
        System.out.println("Q : " + this.Q);
        System.out.println("S : " + this.S);
        System.out.println("Path : " + this.path);
    }
    private List<Integer> Q;
    private List<Integer> S;
    private String path;
    private Node left;
    private Node right;

}

public class QSsort{

    public static void main(String [] args){
        String Input = args[0];
        System.out.println("Still not ready");
        System.out.println("Input : "+ Input);
    }
}