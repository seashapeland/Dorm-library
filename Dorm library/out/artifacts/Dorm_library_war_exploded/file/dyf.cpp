#include <stdio.h>
#include<iostream>
#include<vector>
#include<string>
#include<string.h> 

#define N 100005
using namespace std;
int a[N];
int b[N];
int c[N];
int main()
{
	int i,j,k,t;
	int n,m;
	while(cin>>n&&n)
	{
		m=n*(n-1)/2;
		for(i=0;i<m;i++)
			cin>>a[i];
		for(k=1;k<=a[0];k++)
		{
			j=1;b[0]=k;
			memset(c,0,sizeof(c));
			for(i=0;i<m;i++)
				c[a[i]]++;
			for(i=0;i<m;i++)
			{
				if(c[a[i]])
				{
					b[j]=a[i]-b[0];
					for(t=0;t<j;t++)
					{
						if(c[b[j]+b[t]])
							c[b[j]+b[t]]--; 
						else 
							break;
					}
					if(t==j)
						j++;
					else
						break;
				}
			}
			if(j>=n)
				break;
		}
		for(i=0;i<n-1;i++)
			cout<<b[i]<<" ";
		cout<<b[i]<<endl;
	}
	return 0;
}
