#include <iostream>
#include <array>
#include "cmath"

using namespace std;

int main(int argc, char *argv[]){

	// array<int, 10> a;
	//
	// for (int i = 0; i < 10; i++) {
	// 	cout << a[i] << '\n';
	// }

	// int N = 10000;
	//
	// double s = 0.0;
	//
	// for (int i = 1; i <= N; i++) {
	// 	s += 1.0 / (i * i);
	// }
	//
	// cout << sqrt(6 * s) << '\n';

	array<double, 4> a = {1.0, 1.0 / sqrt(2.0), 1.0 / 4, 1.0};
	array<double, 4> anew;
	int N = 3;

	for (int i = 0; i < N; i++) {
		anew[0] = (a[0] + a[1]) / 2.0;
		anew[1] = sqrt(a[0] * a[1]);
		anew[2] = a[2] - a[3] * (a[0] - anew[0]) * (a[0] - anew[0]);
		anew[3] = 2.0 * a[3];

		for (int j = 0; j < 4; j++) {
			a[j] = anew[j];
		}
	}

	cout << (a[0] + a[1]) * (a[0] + a[1]) / (4.0 * a[2]) << endl;

	cout << rand();

	return 0;
}
