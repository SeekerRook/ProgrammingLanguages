import java.io.*;


public class Round{

    private static int[] cars_of_city (String[] state, int c, int t ){ // convert array of town per carr to cars in town

        int[] res = new int[t];
        for (int i = 0; i < c ; i++ ){
            res[Integer.parseInt(state[i])]++;
        } 
        return res;
    };
    private static int[] sum_from_zero (int[] state,int t){ // compute max and sum for town 0

       int max = 0;
       int sum = 0;
       for (int i = 0 ; i < t; i++){
           int car = state[i];
           if (i != 0){
               sum += car*(t-i);
           }
            if (car >= max){
                max = car;                
            }   
       } 
       int[] res = {max,sum};
        return res; 
    };
    private static int rot_increment (int L, int i){ // help function to rotate pointer in a pac-man style rotation
        if (i < L-1){
            i ++;
        }
        else{
            i = i - L +1;
        }
        return i;
    };
    private static int next_not_zero (int[]L,int l,int i ){// find next non zero town using a pac-man style rotation
        i = rot_increment(l, i);
        while (L[i]==0){
            i = rot_increment(l, i);
        }

        return i;
    };
    private static void search (int c, int t, int [] lis, int sum, int max){ // find min town
        int min = sum;
        int mint = 0;
        int main = 1;
        int sec = next_not_zero (lis, t, 0);
        // here we use 2 pointers (variables that store indexes not actual pointers) 
        // the main goes through the list once and the sec keeps the max (next non zero value)
        while (main <= t-1){
            int diff;
            if (main == sec){ // if main == sec update sec

                sec = next_not_zero (lis,t,sec);                
            }
            if (main >= sec){ // find diff
                diff = main -sec;
            }
            else{
                diff = t - sec + main;
            }

            sum += c - (t* lis[main]); //calculate sum
            if ((sum + 1 )>= 2*diff ){//check validity (same as ml)
                if (min > sum) {
                    min = sum;
                    mint = main;
                }
            }
            main ++;// move main pointer
        }
        String res = String.valueOf(min) + " "+ String.valueOf(mint);
        System.out.println (res);
    };
    public static void main (String [] args){
        try{
        BufferedReader reader = new BufferedReader(new FileReader(args[0]));
        String line1 = reader.readLine();
        String line2 = reader.readLine();
        reader.close();
        String[] ct = line1.split (" ");
        int t = Integer.parseInt(ct[0]);
        int c = Integer.parseInt(ct[1]);
        String[] lis = line2.split(" ");
        int[] towns = cars_of_city(lis, c, t);
        int[] zero = sum_from_zero (towns,t);
        int max = zero[0];
        int sum = zero[1];
        search (c,t,towns,sum,max);
        }
        catch (IOException e){
            e.printStackTrace();
        }
    };
}


