#include <bits/stdc++.h>
#include <cstdio>
using namespace std;


    bool front [1000000];


    
bool findroomsr(int i, int matrix[1000000]){
    if(matrix[i] == -1){
        //cout << "room "<< i << " met exit\n";
        return true;
    }
    else if (front[matrix[i]]){
        //cout << "room "<< i << " met bad node\n";
        return false;
    }
    else {
        front[i] = true;
        //cout << "room "<< i << " going to next node\n";
        bool result = findroomsr(matrix[i],matrix);
        if(result)front[i] = false;
        return result;
    }
 
}
int findrooms(int matrix[1000000],int m, int n){
    int E = m*n;
    int res = 0;
    for (int i = 0 ; i < E; i++){
        
        if(!findroomsr(i,matrix)) {
            //cout << "\n\niterating res for i = "<< i<< "\n\n";
            res++; 
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
                    if (i-1>= m || i-1<0){
                        matrix[x]= -1;
                    }
                    else{
                        matrix[x] = j+n*i-n;
                    }
                    break;
                case 'D':
                    if (i+1>= m|| i+1 <0){
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

            if(temp == '\n' || temp == EOF ){
                i++;
                j= 0;
                //cout << "\n";
            }
            else{
                //cout <</*"a["<<i<<"]["<<j<<"] = "<<*/ static_cast<char>(temp) /*<< '\n'*/;
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
    int matrix[1000000];
    read(argv[1],m,n,arr);
    create_matrix(m,n,arr, matrix);
 //   for (int i = 0 ; i< m*n; i++){
        for (int j = 0; j < m*n; j++){
            //cout << j <<" : " << matrix[j]<< '\n';
        }

//    }
    cout <<findrooms(matrix,m,n)<<'\n';
}
