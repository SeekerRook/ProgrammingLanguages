// C++ implementation of the approach
#include <bits/stdc++.h>
using namespace std;

int N = 1000000000;

bool checkfrac(int sum, int l, int h){
    int frac = sum/(h * l);
    if (-1*frac >= 1 ){
        return true;
    }else return false;
}
int lenOfLongSubarr(int * arr, int n, int h){
    int maxLen = 0;
    for(int i = 0; i < n; i++){
        int sum = arr[i];
        if (checkfrac(sum,1,h)){
                if (1 > maxLen){
                    maxLen = 1;
                }
        }
        for (int j = i+1; j < n; j++){
            sum += arr[j];
            int l = j - i + 1;
            if (checkfrac(sum,l,h)){
                if (l > maxLen){
                    maxLen = l;
                }
                
            }
        }
    } 
    return maxLen;

}

void read(char* filename,int &Days, int &Hospitals,int *days){

    ifstream file;//initializtion
    char *file_name = filename;
    file.open(file_name);
    if (file.is_open()){

        file >> Days >> Hospitals ;
        int temp;
        int i = 0;
        while(file >> temp){
            days[i] = temp;
            i++;
        }
    }
    else {cout << "Unable to open "<<file_name<<'\n';}

}

int main(int argc, char **argv)
{
    int n , h;
    int *ptr;
	ptr = (int*) malloc(N*sizeof(int));
    read(argv[1],n,h,ptr); 
    cout << lenOfLongSubarr(ptr, n, h)<< '\n';
    return 0;
}
