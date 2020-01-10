#include "cmath"
#include "array"
#include "vector"
#include "iostream"
//#include "fstream" // File stream
#include "string"
//#include "cassert" // Provides assert function
#include "Eigen/Dense"
#include "ctime"

using namespace std;
using namespace Eigen;

double lnorm(const vector<double>& v, int p = 2){
	double s = 0.0;

	for (unsigned i = 0; i < v.size(); i++){
		s += pow(abs(v[i]), p);
	}

	return pow(s, 1.0 / p);
}

vector<vector<double>> matmul(const vector<vector<double>>& A, const vector<vector<double>>& B){
	int m = A.size();
	int n = A[0].size();
	int p = B[0].size();

	vector<vector<double>> C;
	C.resize(m);
	for (int i = 0; i < m; i++){
		C[i].resize(p);
	}

	for (int i = 0; i < m; i++){
		for (int j = 0; j < p; j++){
			C[i][j] = 0.0;
			for (int k = 0; k < n; k++){
				C[i][j] += A[i][k] * B[k][j];
			}
		}
	}

	return C;
}

/*
double lnorm(const my_array v, int p = 2){
	double s = 0.0;

	for (unsigned i = 0; i < N; i++) {
		s += pow(abs(v[i]), p);
	}

	return pow(s, 1.0 / p);
}

void cowsay(string text) {
	printf("< %15s > \n \
 ------ \n \
        \\   ^__^ \n \
         \\  (oo)\\_______ \n \
            (__)\\       )\\/\\ \n \
                ||----w | \\ \n \
                ||     ||", &text[0]);

}

double dot(double a[3], double b[3]) {
	double s = 0.0;

	for (int i = 0; i < 3; i++) {
		s += a[i] * b[i];
	}

	return s;
}

int dot(int a[3], int b[3]) {
	int s = 0;

	for (int i = 0; i < 3; i++) {
		s += a[i] * b[i];
	}

	return s;
}
*/

vector<vector<double>> makemat(int m, int n){
	vector<vector<double>> A;
	A.resize(m);

	for (int i = 0; i < m; i++){
		A[i].resize(n);

		for (size_t j = 0; j < n; j++){
			A[i][j] = 2.0 * ((double)rand() / RAND_MAX - 0.5);
		}
	}

	return A;

}

int main(int argc, char *argv[]) {
	time_t t0;

	vector<vector<double>> A;
	vector<vector<double>> B;

	A = makemat(1000, 1000);
	B = makemat(1000, 1000);

	t0 = time(NULL);
	vector<vector<double>> C = matmul(A, B);
	cout << "Us: " << time(NULL) - t0 << endl;

	MatrixXd A2 = MatrixXd::Random(1000, 1000);
	MatrixXd B2 = MatrixXd::Random(1000, 1000);

	t0 = time(NULL);
	MatrixXd C2 = A2 * B2;
	cout << "Them: " << time(NULL) - t0 << endl;

	/*
	for (int i = 0; i < 4; i++){
		for (int j = 0; j < 4; j++){
			cout << C[i][j] << '\t';
		}
		cout << endl;
	}
	*/

	return 0;
}
