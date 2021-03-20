#include <fstream>
#include <iostream>
using namespace std;
bool check(int n, int Hospitals){
    if (n/Hosp)
}
int longest (int *array, int Days, int Hospital){
    res = 0;

    return res;
}
int main(int argc, char** argv){
    int days[1000];
    ifstream file;//initializtion
    char *file_name = argv[1];
    file.open(file_name);
    if (file.is_open()){
        int Days, Hospitals; 
        file >> Days >> Hospitals ;
        //cout<< "flag";
        int temp;
        int i = 0;
        while(file >> temp){
            days[i] = temp;

        }
        for (int j = 0; j < Days ; j++){
            cout << days[j] << '\n';
        }
    }
    else {cout << "Unable to open "<<file_name<<'\n';}

    return 0;
}