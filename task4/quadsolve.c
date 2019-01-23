#include "mex.h"
#include "math.h"
#include "matrix.h"
#include "stdio.h"
#define myPI 3.14159265358979323846


void sqrt1(double a, double b, double* a1, double*  b1){
	double rho, phi;
	rho = sqrt(a*a + b*b);
	if ((b==0)&&(a==0)){ *a1 = 0; *b1 =0;
	}
	else{
		a = a/rho;
		b = b/rho;
		if (a==0){
			if (b>0){phi = myPI/2;}
			else{ phi = -myPI/2;}
			}
		else{
			phi = b/a;
			if (a<0){
				if (b>=0){
					phi = myPI + atan(phi); }
				else {
					phi = - myPI + atan(phi);}
			}else {phi = atan(phi);}
		}
	
		rho = sqrt(rho);
		phi = phi/2;
		*a1 = rho*cos(phi);
		*b1 = rho*sin(phi);
	}
}

void errorCheck(int nlhs, int nrhs, const mxArray *prhs[]);


void mexFunction( int nlhs, mxArray *plhs[], int nrhs, const mxArray *prhs[]){
	
	errorCheck(nlhs, nrhs, prhs);
	
	mwSize m = mxGetM(prhs[0]), n = mxGetN(prhs[0]);
	plhs[0] = mxCreateDoubleMatrix(m, n, mxCOMPLEX); //x1
	plhs[1] = mxCreateDoubleMatrix(m, n, mxCOMPLEX); //x2
	mxComplexDouble *x1 =  mxGetComplexDoubles(plhs[0]);
	mxComplexDouble *x2 =  mxGetComplexDoubles(plhs[1]);
	
	double reD, imD, errr;
	
	if (!mxIsComplex(prhs[0]) && !mxIsComplex(prhs[1]) && !mxIsComplex(prhs[2])){
		//all matrices are actually really double)
		mxDouble *A = mxGetDoubles(prhs[0]), *B = mxGetDoubles(prhs[1]), *C = mxGetDoubles(prhs[2]);
		mxArray *D = mxCreateDoubleMatrix(m, n, mxREAL); //D
		mxDouble *D1 = mxGetDoubles(D);
		
		double a, b, c;
		
		for (mwSize i=0;  i<m*n; i++){
			a = A[i]; b = B[i]; c = C[i]; 
			if (fabs(a) < DBL_EPSILON){
				if (fabs(b) < DBL_EPSILON){
					if (fabs(c) > DBL_EPSILON){
						errr = b/a;
						x1[i].real = errr;
						x1[i].imag = errr;
						x2[i].real = errr;
						x2[i].imag = errr;
						D1[i] = 0;
					}
					else{
						x1[i].real = 0;
						x1[i].imag = 0;
						x2[i].real = 0;
						x2[i].imag = 0;
						D1[i] = 0;
					}
				}
				else{
					x1[i].real  = -c/b;
					x1[i].imag = 0;
					x2[i].real  = -c/b;
					x2[i].imag = 0;
					D1[i] = b*b;
				}
			}
			else{
				D1[i] = b*b - 4*a*c;
				sqrt1(D1[i], 0, &reD, &imD);
				x1[i].real = ( -b + reD )/2/a;
				x1[i].imag =  imD /2/a;
				x2[i].real = ( -b - reD )/2/a;
				x2[i].imag = - imD /2/a;
			}
		}
		
		if (nlhs == 3){
		plhs[2] = mxCreateDoubleMatrix(m, n, mxREAL);
		plhs[2] =  mxDuplicateArray(D);
		}
		mxDestroyArray(D);
	}
	else{
		//at least one matrix is complex...
		mxArray *D = mxCreateDoubleMatrix(m, n, mxCOMPLEX); //D
		mxComplexDouble *D1 = mxGetComplexDoubles(D);
		
		mxArray *X = mxDuplicateArray(prhs[0]);
		mxArray *Y = mxDuplicateArray(prhs[1]);
		mxArray *Z = mxDuplicateArray(prhs[2]);
		
		if (!mxIsComplex(prhs[0])){
			mxMakeArrayComplex(X);
		};
		if (!mxIsComplex(prhs[1])){
			mxMakeArrayComplex(Y);
		};
		if (!mxIsComplex(prhs[2])){
			mxMakeArrayComplex(Z);
		};
	
		mxComplexDouble *A = mxGetComplexDoubles(X), *B = mxGetComplexDoubles(Y), *C = mxGetComplexDoubles(Z);
		
		double a1, b1, c1, a2, b2, c2;
		for (mwSize i=0;  i<m*n; i++){
			
			a1 = A[i].real; a2 = A[i].imag;
			b1 = B[i].real; b2 = B[i].imag;
			c1 = C[i].real; c2 = C[i].imag;
			
			if ((fabs(a1) < DBL_EPSILON)&&(fabs(a2) < DBL_EPSILON)){
				if ((fabs(b1) < DBL_EPSILON)&&(fabs(b2) < DBL_EPSILON)){
					if ((fabs(c1) > DBL_EPSILON)||(fabs(c2) > DBL_EPSILON)){
						errr = b1/a1;
						x1[i].real = errr;
						x1[i].imag = errr;
						x2[i].real = errr;
						x2[i].imag = errr;
						D1[i].real = 0;
						D1[i].imag = 0;
					}
					else{
						x1[i].real = 0;
						x1[i].imag = 0;
						x2[i].real = 0;
						x2[i].imag = 0;
						D1[i].real = 0;
						D1[i].imag = 0;
					}
				}
				else{
					x1[i].real  = -(b1*c1 + b2*c2)/(b1*b1 + b2*b2);
					x1[i].imag = -(b1*c2 - b2*c1)/(b1*b1 + b2*b2);
					x2[i].real  = -(b1*c1 + b2*c2)/(b1*b1 + b2*b2);
					x2[i].imag = -(b1*c2 - b2*c1)/(b1*b1 + b2*b2);
					D1[i].real = b1*b1 -b2*b2;
					D1[i].imag = 2*b1*b2;
			}
			}else{
				D1[i].real = b1*b1 - b2*b2  - 4*(a1*c1 - a2*c2);
				D1[i].imag = 2*b1*b2 - 4*(a1*c2 + a2*c1);
				sqrt1(D1[i].real, D1[i].imag, &reD, &imD);
				x1[i].real = ( (-b1 + reD)*a1 + (-b2 + imD)*a2 )/2/ (a1*a1 + a2*a2);
				x1[i].imag = ( (b1 - reD)*a2 + (-b2 + imD)*a1 )/2/ (a1*a1 + a2*a2);
				x2[i].real = ( (-b1 - reD)*a1 + (-b2 - imD)*a2 )/2/ (a1*a1 + a2*a2);
				x2[i].imag = ( (b1 + reD)*a2 + (-b2 - imD)*a1 )/2/ (a1*a1 + a2*a2);
			}
		}
		
		if (nlhs == 3){
		plhs[2] = mxCreateDoubleMatrix(m, n, mxCOMPLEX);
		plhs[2] =  mxDuplicateArray(D);
		}
		
		mxDestroyArray(X); mxDestroyArray(Y); mxDestroyArray(Z);
		mxDestroyArray(D);
	}
	
	
	
}

void errorCheck(int nlhs, int nrhs, const mxArray *prhs[]){
	if (nrhs != 3)  {
		mexErrMsgIdAndTxt("MATLAB:quadsolve:rhs", "There should be 3 input elements"); 
	}
	if (nlhs < 2 || nlhs > 3) {
		mexErrMsgIdAndTxt("MATLAB:quadsolve:lhs", "There should be 2 or 3 output elements");
	}
	if ((!mxIsComplex(prhs[0])&&!mxIsDouble(prhs[0])) || (!mxIsComplex(prhs[1])&&!mxIsDouble(prhs[1])) || (!mxIsComplex(prhs[2])&&!mxIsDouble(prhs[2]))){
		mexErrMsgIdAndTxt("MATLAB:quadsolve:lhs", "Matrices should be complex or double");
	}
	if (mxGetM(prhs[0]) != mxGetM(prhs[1]) || mxGetM(prhs[0]) != mxGetM(prhs[2]) || mxGetM(prhs[1]) != mxGetM(prhs[1]) || mxGetN(prhs[0]) != mxGetN(prhs[1]) || mxGetN(prhs[0]) != mxGetN(prhs[2]) || mxGetN(prhs[1]) != mxGetN(prhs[2]) ) {
		mexErrMsgIdAndTxt("MATLAB:quadsolve:rhs", "Dimensions of matrices are not equal");
	}
	
	
}

