#include <bits/stdc++.h>
#include <cstdio>
using namespace std;

void create_matrix(int m, int n, char arr[1000][1000], bool matrix[1000][1000]){
    int E = m*n;//exit node

    // bool matrix [E][E+1];//+1 for exit

    for (int i = 0; i < m; i ++){
        for(int j = 0; j < n; j++){
            int x = j + n*i;
            switch (arr[i][j]){
                case 'R': 
                    if (j+1>= n || j+1 < 0){//may not use second 
                        matrix[x][E]= true;
                    }
                    else{
                        matrix[x][j+1+n*i] = true;
                    }
                    break;
                    
                case 'L':
                    if (j-1>= n|| j-1 <0){
                        matrix[x][E]= true;
                    }
                    else{
                        matrix[x][j-1+n*i] = true;
                    }
                    break;
                case 'U':
                    if (i-1>= n || i-1<0){
                        matrix[x][E]= true;
                    }
                    else{
                        matrix[x][j+n*(i-1)] = true;
                    }
                    break;
                case 'D':
                    if (i+1>= n|| i+1 <0){
                        matrix[x][E]= true;
                    }
                    else{
                        matrix[x][j+n*(i+1)] = true;
                    }
                    break;            
            }

        }
    }
//return matrix;

}

int main(){
    int m = 4;
    int n = 4;
    char arr [1000][1000];
    bool matrix[1000][1000];
    arr[0][0] = 'L';
    arr[0][1] = 'R';
    arr[0][2] = 'U';
    arr[0][3] = 'D';
    arr[1][0] = 'R';
    arr[1][1] = 'D';
    arr[1][2] = 'D';
    arr[1][3] = 'D';
    arr[2][0] = 'D';
    arr[2][1] = 'L';
    arr[2][2] = 'R';
    arr[2][3] = 'R';
    arr[3][0] = 'R';
    arr[3][1] = 'R';
    arr[3][2] = 'U';
    arr[3][3] = 'L';
    create_matrix(m,n,arr, matrix);
    for (int i = 0 ; i< m*n; i++){
        for (int j = 0; j < m*n+1; j++){
            cout << "   " << matrix[i][j];
        }
        cout << '\n';
    }
}