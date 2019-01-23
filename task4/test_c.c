#include "mex.h"
#include "math.h"
#include "matrix.h"
#include "stdio.h"
#include "complex.h"


void print_matr(mxArray aMat);
void check_input(int nlhs, int nrhs, const mxArray *prhs[]);

void mexFunction(int nlhs, mxArray *plhs[], int nrhs, const mxArray *prhs[])
{
     check_input()
}

void check_input(int nlhs, int nrhs, const mxArray *prhs[]){
    if (nrhs != 1)  {
          mexErrMsgIdAndTxt("MATLAB:inv_c:rhs", "There should be single input"); 
     }
     if (nlhs != 1)  {
          mexErrMsgIdAndTxt("MATLAB:inv_c:lhs", "There should be single output"); 
     }
     if (mxGetM(prhs[0]) != mxGetN(prhs[0])){
          mexErrMsgIdAndTxt("MATLAB:inv_c:rhs", "Input should be a square matrix"); 
     }
     if (!mxIsComplex(prhs[0])&&!mxIsDouble(prhs[0])){
          mexErrMsgIdAndTxt("MATLAB:inv_c:rhs", "Input should be real or Complex matrix"); 
     }
}

void print_matr(mxArray aMat){
     printf("Matrix:\n");
     int n=mxGetN(aMat);
     for (int i=0;i<n;i++){
          for (int j=0;j<n;j++){
               printf("%.4f  ",aMat[i*n+j]);
          }
          printf("\n");
     }
}