#include <bits/stdc++.h>
#include <cstdio>
using namespace std;

int findrooms(int matrix[1000],int m,int n){
    int E = m*n;
    int res = 0;
    bool front [1000];
    bool good[1000];
    bool bad[1000];
 //   int l;
 //   int searched_iterator;
    for (int i = 0; i < E; i++){
        if(matrix[i]==-1){
            good[i] = true;
            for (int j = 0 ; j < E; j++){
                if(front[j]) good[j] = true;
            }  
        }
        else {
            if (good[matrix[i]] == true){
                good[i] = true;
                for (int j = 0 ; j < E; j++){
                    if(front[j]) good[j] = true;
                }
            }   
            else if (bad[matrix[i]] == true || front[matrix[i]] == true){
                bad[i] = true;
                res++;
                for (int j = 0 ; j < E; j++){
                    if(front[j]) {
                        bad[j] = true;
                        res++;
                    }
                }
            }
            else front[i] = true;          
        }
    }

    return res;

}

void create_matrix(int m, int n, char arr[1000][1000], int matrix[1000]){
 //   int E = m*n;//exit node

    // bool matrix [E][E+1];//+1 for exit

    for (int i = 0; i < m; i ++){
        for(int j = 0; j < n; j++){
            int x = j + n*i;
            switch (arr[i][j]){
                case 'R': 
                    if (j+1>= n || j+1 < 0){//may not use second 
                        matrix[x]= -1;
                    }
                    else{
                        matrix[x] = j+1+n*i;
                    }
                    break;
                    
                case 'L':
                    if (j-1>= n|| j-1 <0){
                        matrix[x]= -1;
                    }
                    else{
                        matrix[x] = j-1+n*i;
                    }
                    break;
                case 'U':
                    if (i-1>= n || i-1<0){
                        matrix[x]= -1;
                    }
                    else{
                        matrix[x] = j+n*i-n;
                    }
                    break;
                case 'D':
                    if (i+1>= n|| i+1 <0){
                        matrix[x]= -1;
                    }
                    else{
                        matrix[x] = j+n*i+n;
                    }
                    break;            
            }

        }
    }
//return matrix;

}
void read(char* filename,int &m, int &n,char arr[1000][1000]){

    ifstream file;//initializtion
    FILE* fd;
    char *file_name = filename;
    file.open(file_name);
    fd = fopen(file_name,"r");
    if (file.is_open()){

        file >> m >> n ;
        int temp;
        int i = 0;
        int j = 0;
        do{
            temp = getc(fd);
        }while(temp != '\n');

        do{
            temp = getc(fd);

            if(temp == '\n'){
                i++;
                j= 0;
            }
            else{
                arr[i][j] = temp;
                j++;
            }
            
        }while(temp!= EOF);
    }
    else {cout << "Unable to open "<<file_name<<'\n';}

}

int main(int argc, char **argv){
    int m ;
    int n ;
    char arr [1000][1000];
    int matrix[1000];
    read(argv[1],m,n,arr);
    create_matrix(m,n,arr, matrix);

    cout <<findrooms(matrix,m,n)<<'\n';
}
