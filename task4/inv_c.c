#include "mex.h"
#include "math.h"
#include "matrix.h"
#include "stdio.h"
#include "complex.h"

void errorCheck(int nlhs, int nrhs, const mxArray *prhs[]);

void divC(double aRe, double aIm, double bRe, double bIm, double *divRe, double *divIm ){
	double bM = bRe*bRe + bIm*bIm;
	*divRe = (aRe*bRe + aIm*bIm)/bM;
	*divIm = (aIm*bRe - aRe*bIm)/bM;
}

void multC(double aRe, double aIm, double bRe, double bIm, double *multRe, double *multIm  ){
	*multRe = aRe*bRe - aIm*bIm;
	*multIm = aRe*bIm + aIm*bRe;
}

void mexFunction( int nlhs, mxArray *plhs[], int nrhs, const mxArray *prhs[]){
	
	errorCheck(nlhs, nrhs, prhs);
	mwSize m = mxGetM(prhs[0]), n = mxGetN(prhs[0]);
	mwSize j, l, k;
	if (!mxIsComplex(prhs[0])){
		//Fortunately just real matrix
		plhs[0] = mxCreateDoubleMatrix(m, n, mxREAL);
		mxArray *inpCopy = mxCreateDoubleMatrix(m, n, mxREAL);
		inpCopy  = mxDuplicateArray(prhs[0]);
		mxDouble *A = mxGetDoubles(inpCopy), *A1 =  mxGetDoubles(plhs[0]);
		double tmp, a;
		//initializing A1
		for (l=0; l<m*m ; l++){
			A1[l]=0;
		}
		for (l=0; l<m ; l++){ A1[l*m+l]=1;}
		//inversion
		for ( j=0; j< m ; j++){
			a = A[j*m+j];
			if (a==0){
				l = j+1;
				while ((A[l*m+j]==0)&&(l<m)){l=l+1;}
				if (l==m){
					mexErrMsgIdAndTxt("MATLAB:quadsolve:inverse", "The determinant of matrix is zero"); 
				}
				//swap rows #l and #j
				for (k=0; k<m; k++) {
					tmp = A[l*m+k];
					A[l*m+k] = A[j*m+k];
					A[j*m+k] = tmp;
					tmp = A1[l*m+k];
					A1[l*m+k] = A1[j*m+k];
					A1[j*m+k] = tmp;
				}	
				a = A[j*m+j]; 
			}// now we can divide
			for (l=0; l<j; l++ ){
				A1[j*m+l]=A1[j*m+l]/a;
			}
				A1[j*m +j]= A1[j*m +j]/a; A[j*m +j] = 1;
			for (l=j+1; l<m; l++ ){
				A1[j*m+l]=A1[j*m+l]/a; A[j*m+l]=A[j*m+l]/a;
			}
			//clear all other rows
			for (k= 0; k<j; k++){
				a = A[k*m+j];
				if (a!=0){
					for (l=0; l<j; l++){
						//A[k*m+l] = A[k*m+l] - A[j*m+l]*a;
						A1[k*m+l] = A1[k*m+l] - A1[j*m+l]*a;
					}
					for (l=j; l<m; l++){
						A[k*m+l] = A[k*m+l] - A[j*m+l]*a;
						A1[k*m+l] = A1[k*m+l] - A1[j*m+l]*a;
					}
				}
			}
			for (k= j+1; k<m; k++){
				a = A[k*m+j];
				if (a!=0){
					for (l=0; l<j; l++){
						//A[k*m+l] = A[k*m+l] - A[j*m+l]*a;
						A1[k*m+l] = A1[k*m+l] - A1[j*m+l]*a;
					}
					for (l=j; l<m; l++){
						A[k*m+l] = A[k*m+l] - A[j*m+l]*a;
						A1[k*m+l] = A1[k*m+l] - A1[j*m+l]*a;
					}
				}
			}
		}
		mxDestroyArray(inpCopy);
		
	}
	else{
		//Unfortunately complex matrix
		plhs[0] = mxCreateDoubleMatrix(m, n, mxCOMPLEX);
		mxArray *inpCopy = mxCreateDoubleMatrix(m, n, mxCOMPLEX);
		inpCopy  = mxDuplicateArray(prhs[0]);
		mxComplexDouble *A = mxGetComplexDoubles(inpCopy), *A1 =  mxGetComplexDoubles(plhs[0]);
		double tmpRe, tmpIm, aRe, aIm, a1Im, a1Re;
		//initializing A1
		for (l=0; l<m*m ; l++){
			A1[l].real=0;
			A1[l].imag=0;
		}
		for (l=0; l<m ; l++){ A1[l*m+l].real=1;}
		
		//inversion
		for ( j=0; j< m ; j++){
			aRe = A[j*m+j].real;
			aIm = A[j*m+j].imag;
			if ((aRe==0)&&(aIm==0)){
				l = j+1;
				while ((A[l*m+j].real==0)&&(A[l*m+j].imag==0)&&(l<m)){l++;}
				if (l==m){
					mexErrMsgIdAndTxt("MATLAB:quadsolve:inverse", "The determinant of matrix is zero"); 
				}
				//swap rows #l and #j
				for (k=0; k<m; k++) {
					tmpRe = A[l*m+k].real;
					A[l*m+k].real = A[j*m+k].real;
					A[j*m+k].real = tmpRe;
					tmpIm = A[l*m+k].imag;
					A[l*m+k].imag = A[j*m+k].imag;
					A[j*m+k].imag = tmpIm;
		
					tmpRe = A1[l*m+k].real;
					A1[l*m+k].real = A1[j*m+k].real;
					A1[j*m+k].real = tmpRe;
					tmpIm = A1[l*m+k].imag;
					A1[l*m+k].imag = A1[j*m+k].imag;
					A1[j*m+k].imag = tmpIm;
				}	
				aRe = A[j*m+j].real; 
				aIm = A[j*m+j].imag;
			//printf("\n\n");
			}
			//aM = aRe*aRe + aIm*aIm;
			//printf("%f i%f\n", aRe, aIm);
			/*for (l=0; l<m*m ; l++){
					printf("%f %fi ",A[l].real, A[l].imag);
			}
			printf("\n");*/
			// now we can divide
			for (l=0; l<j; l++ ){
				divC(A1[j*m+l].real, A1[j*m+l].imag, aRe, aIm, &(A1[j*m+l].real), &(A1[j*m+l].imag));
			}
				divC(A1[j*m+j].real, A1[j*m+j].imag, aRe, aIm, &(A1[j*m+j].real), &(A1[j*m+j].imag));
				A[j*m +j].real = 1;
				A[j*m +j].imag = 0;
			for (l=j+1; l<m; l++ ){
				divC(A1[j*m+l].real, A1[j*m+l].imag, aRe, aIm, &(A1[j*m+l].real), &(A1[j*m+l].imag));
				divC(A[j*m+l].real, A[j*m+l].imag, aRe, aIm, &(A[j*m+l].real), &(A[j*m+l].imag));
			}
			/*for (l=0; l<m*m ; l++){
				printf("%f %fi ",A[l].real, A[l].imag);
			}
			printf("\n");*/
			//clear all other rows
			for (k= 0; k<j; k++){
				aRe = A[k*m+j].real;
				aIm = A[k*m+j].imag;
				if ((aRe!=0)||(aIm!=0)){
					for (l=0; l<j; l++){
						//multC(A[j*m+l].real, A[j*m+l].imag, aRe, aIm, &a1Re, &a1Im);
						//A[k*m+l].real = A[k*m+l].real - a1Re;
						//A[k*m+l].imag = A[k*m+l].imag - a1Im;
						multC(A1[j*m+l].real, A1[j*m+l].imag, aRe, aIm, &a1Re, &a1Im);
						A1[k*m+l].real = A1[k*m+l].real - a1Re;
						A1[k*m+l].imag = A1[k*m+l].imag - a1Im;
					}
					for (l=j; l<m; l++){
						multC(A[j*m+l].real, A[j*m+l].imag, aRe, aIm, &a1Re, &a1Im);
						A[k*m+l].real = A[k*m+l].real - a1Re;
						A[k*m+l].imag = A[k*m+l].imag - a1Im;
						multC(A1[j*m+l].real, A1[j*m+l].imag, aRe, aIm, &a1Re, &a1Im);
						A1[k*m+l].real = A1[k*m+l].real - a1Re;
						A1[k*m+l].imag = A1[k*m+l].imag - a1Im;
					}
				}
			}
			for (k= j+1; k<m; k++){
				aRe = A[k*m+j].real;
				aIm = A[k*m+j].imag;
				if ((aRe!=0)||(aIm!=0)){
					for (l=0; l<j; l++){
						//multC(A[j*m+l].real, A[j*m+l].imag, aRe, aIm, &a1Re, &a1Im);
						//A[k*m+l].real = A[k*m+l].real - a1Re;
						//A[k*m+l].imag = A[k*m+l].imag - a1Im;
						multC(A1[j*m+l].real, A1[j*m+l].imag, aRe, aIm, &a1Re, &a1Im);
						A1[k*m+l].real = A1[k*m+l].real - a1Re;
						A1[k*m+l].imag = A1[k*m+l].imag - a1Im;
					}
					for (l=j; l<m; l++){
						multC(A[j*m+l].real, A[j*m+l].imag, aRe, aIm, &a1Re, &a1Im);
						A[k*m+l].real = A[k*m+l].real - a1Re;
						A[k*m+l].imag = A[k*m+l].imag - a1Im;
						multC(A1[j*m+l].real, A1[j*m+l].imag, aRe, aIm, &a1Re, &a1Im);
						A1[k*m+l].real = A1[k*m+l].real - a1Re;
						A1[k*m+l].imag = A1[k*m+l].imag - a1Im;
					}
				}
			}
			/*for (l=0; l<m*m ; l++){
			printf("%f %fi ",A[l].real, A[l].imag);
			}
			printf("\n!\n");*/
			
		}
		mxDestroyArray(inpCopy);
	}
	
}

void errorCheck(int nlhs, int nrhs, const mxArray *prhs[]){
	if (nrhs != 1)  {
		mexErrMsgIdAndTxt("MATLAB:quadsolve:rhs", "There should be single input"); 
	}
	if (nlhs != 1)  {
		mexErrMsgIdAndTxt("MATLAB:quadsolve:lhs", "There should be single output"); 
	}
	if (mxGetM(prhs[0]) != mxGetN(prhs[0])){
		mexErrMsgIdAndTxt("MATLAB:quadsolve:rhs", "Input should be a square matrix"); 
	}
	if (!mxIsComplex(prhs[0])&&!mxIsDouble(prhs[0])){
		mexErrMsgIdAndTxt("MATLAB:quadsolve:rhs", "Input should be real or Complex matrix"); 
	}
}
