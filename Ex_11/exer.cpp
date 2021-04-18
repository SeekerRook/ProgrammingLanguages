#include <bits/stdc++.h>

using namespace std;

int Num = 1000000000;

bool compare(const pair<int,int>& a, const pair<int, int>& b){
    if(a.first==b.first)
        return a.second<b.second;
    return a.first<b.first;
}

int findInd(vector<pair<int,int>>& preSum,int k, int val){

    int l=0;
    int h=k-1;
    int mid;

    //store the requires index value
    int ans=-1;
    
    while(l<=h){
        mid=(l+h)/2;
        if(preSum[mid].first<=val){
            ans=mid;
            l=mid+1;

        }
        else
            h=mid-1;
    }
    return ans;
}
//N-->hospitals,k-->days
int LongestSub(int arr[],int k,int N){
    int i;
    
    for(i=0;i<k; i++)
        arr[i]-=N;
        
    
    int maxLen=0;

    vector <pair<int,int>> preSum;

    int sum=0;//to store the current value of the sum

    int midInd[k];

    //insert values in preSum vector
    for(i=0;i<k;i++){
        sum=sum+arr[i];
        preSum.push_back({sum,i});
    }
    sort(preSum.begin(),preSum.end(),compare);

    //update mindInd array
    midInd[0]=preSum[0].second;

    for(i=1;i<k;i++){
        midInd[i]=min(midInd[i-1],preSum[i].second);
    }
    sum=0;
    for(i=0;i<k;i++){
        sum=sum + arr[i];
        
        if (sum>=0)
            maxLen=i+1;
        else{
            int ind = findInd(preSum,k,sum);
            if(ind!=-1 && midInd[ind]<1)
                maxLen=max(maxLen,i-midInd[ind]);
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
	ptr = (int*) malloc(Num*sizeof(int));
    read(argv[1],n,h,ptr); 
    cout << LongestSub(ptr, n, h)<< '\n';
    return 0;
}
