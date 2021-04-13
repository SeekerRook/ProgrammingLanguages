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
            cout <<"a["<<i<<"]["<<j<<"] = "<< static_cast<char>(temp) << '\n';
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
    bool matrix[1000][1000];
    read(argv[1],m,n,arr);
    create_matrix(m,n,arr, matrix);
    for (int i = 0 ; i< m*n; i++){
        for (int j = 0; j < m*n+1; j++){
            cout << "   " << matrix[i][j];
        }
        cout << '\n';
    }
}