import java.util.*;
class Node{


     int[] Q;
     int[] S;
     String path;
     Node left;
     Node right;
     public Node(int Qin [],int Sin[],String pathin)
     {
         Q = Qin;
         S = Sin;
         path = pathin;
         left = right = null;
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
    Node root;
 
    int minimumDepth()
    {
        return minimumDepth(root);
    }
 
    /* Function to calculate the minimum depth of the tree */
    int minimumDepth(Node root){
        // Corner case. Should never be hit unless the code is
        // called on root = NULL
        if (root == null)
            return 0;
 
        // Base case : Leaf Node. This accounts for height = 1.
        if (root.left == null && root.right == null)
            return 1;
 
        // If left subtree is NULL, recur for right subtree
        if (root.left == null)
            return minimumDepth(root.right) + 1;
 
        // If right subtree is NULL, recur for left subtree
        if (root.right == null)
            return minimumDepth(root.left) + 1;
 
        return Math.min(minimumDepth(root.left),
                        minimumDepth(root.right)) + 1;
    }
 
    /* Driver program to test above functions */
    public static void main(String args[])
    {
        QSsort tree = new QSsort();
        int[]Q = {1,2,3,4};
        int[]S = new int[10];

        tree.root = new Node(Q,S,"");


 
        System.out.println("The minimum depth of "+
          "binary tree is : " + tree.minimumDepth());
    }
}