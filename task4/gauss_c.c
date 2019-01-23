#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/types.h>
#include <unistd.h>
#include <sys/wait.h>
#include <sys/stat.h>

#include <fcntl.h>

void print_matr(double ** aMat, int n){
	printf("matrix:\n");
	for (int i=0;i<n;i++){
		for (int j=0;j<n;j++){
			printf("%.4f  ",aMat[i][j]);
		}
		printf("\n");
	}
}

double ** gauss_c(double ** aMat,int n){

	double **eMat = (double **)malloc(n*sizeof(double *));
	double cur_mult;
	int main_str;
	for (int i=0;i<n;i++){
		eMat[i]=(double *)malloc(n*sizeof(double ));
	}

	for (int i=0;i<n;i++){
		for (int j=0;j<n;j++){
			eMat[i][j]=0;
			if (i==j){
				eMat[i][j]=1;
			}
		}
	}

	for (int step=0;step<n-1;step++){
        for (int k=step+1;k<n;k++){
            if (aMat[step][step]!=0){
                cur_mult=aMat[k][step]/aMat[step][step];
                for (int l=0;l<n;l++){
                    aMat[k][l]=aMat[k][l]-aMat[step][l]*cur_mult;
                    eMat[k][l]=eMat[k][l]-eMat[step][l]*cur_mult;
                }
            }else{
                main_str=step;
                for (int s=step;s<n;s++){
                  if (aMat[s][step]!=0){
                      main_str=s;
                  }
                }
                double buff1;
                double buff2;
                for (int s=0;s<n;s++){
                    buff1=aMat[step][s];
                    buff2=eMat[step][s];
                    aMat[step][s]=aMat[main_str][s];
                    eMat[step][s]=eMat[main_str][s];
                    aMat[main_str][s]=buff1;
                    eMat[main_str][s]=buff2;
                }
                cur_mult=aMat[k][step]/aMat[step][step];
                for (int l=0;l<n;l++){
                    aMat[k][l]=aMat[k][l]-aMat[step][l]*cur_mult;
                    eMat[k][l]=eMat[k][l]-eMat[step][l]*cur_mult;
                }
            }
        }
    }
    
    //print_matr(aMat,n);
    int inv_step;
    //print_matr(eMat,n);

    for (int step=0;step<n-1;step++){
        inv_step=n-step-1;
        for (int k=inv_step-1;k>=0;k--){
           if (aMat[inv_step][inv_step]!=0){
               cur_mult=aMat[k][inv_step]/aMat[inv_step][inv_step];
               for (int l=0;l<n;l++){
                    aMat[k][l]=aMat[k][l]-aMat[inv_step][l]*cur_mult;
                    eMat[k][l]=eMat[k][l]-eMat[inv_step][l]*cur_mult;
               }
           	}else{
                main_str=inv_step;
                for (int s=inv_step;s>=0;s--){
                  if (aMat[s][inv_step]!=0){
                      main_str=s;
                  }
                }
                int buff1,buff2;
                for (int s=0;s<n;s++){
                    buff1=aMat[inv_step][s];
                    buff2=eMat[inv_step][s];
                    aMat[inv_step][s]=aMat[main_str][s];
                    eMat[inv_step][s]=eMat[main_str][s];
                    aMat[main_str][s]=buff1;
                    eMat[main_str][s]=buff2;
                } 
                cur_mult=aMat[k][inv_step]/aMat[inv_step][inv_step];
                for (int l=0;l<n;l++){
                    aMat[k][l]=aMat[k][l]-aMat[inv_step][l]*cur_mult;
                    eMat[k][l]=eMat[k][l]-eMat[inv_step][l]*cur_mult;
                }
               
           }
        }
    }
     
    for (int k=0;k<n;k++){
        for (int l=0;l<n;l++){
            eMat[k][l]=eMat[k][l]/aMat[k][k];
        }       
    }

    //print_matr(eMat,n);

    return eMat;
}


int main(){

	int n;
	n=2;
	double **aMat = (double **)malloc(n*sizeof(double *));

	for (int i=0;i<n;i++){
		aMat[i]=(double *)malloc(n*sizeof(double ));
	}

	for (int i=0;i<n;i++){
		for (int j=0;j<n;j++){
			aMat[i][j]=rand()%100;
		}
	}

	print_matr(aMat,n);
	double ** cMat=gauss_c(aMat,n);
	print_matr(cMat,n);

	for (int i=0;i<n;i++){
		free(aMat[i]);
		free(cMat[i]);
	}
	free(aMat);
	free(cMat);
	return 0;
}