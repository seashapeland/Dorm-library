#include<iostream>
#include<stdio.h>
#include<string.h>
#include<string>
#include<cmath>
#include<vector>
#include<algorithm>
using namespace std;
int main()
{
	int l[30];
	vector<int> list;
	int k;
	cin>>k;
	for(int i=0;i<k;i++){
		cin>>l[i];
	}
	list.push_back(l[0]);
	for(int i=1;i<k;i++){
		if(l[i]<=*list.rbegin()){
			list.push_back(l[i]);
		}
		else{
			*upper_bound(list.begin(),list.end(),l[i],greater<int>())=l[i];
		}
	}
	cout<<list.size()<<endl;
	for(auto it : list) {
		cout << it;
	} 
	return 0;
}
