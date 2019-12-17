#include <iostream>
#include <array>
#include "cmath"
#include "fstream"
#include "sstream"
#include "string"
#include "cassert"

using namespace std;

int main(int argc, char *argv[]){

	/*
	array<int, 10> a;

	for (int i = 0; i < 10; i++) {
		cout << a[i] << '\n';
	}
	*/

	/*
	int N = 10000;

	double s = 0.0;

	for (int i = 1; i <= N; i++) {
		s += 1.0 / (i * i);
	}

	cout << sqrt(6 * s) << '\n';
	*/

	/*
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
	*/

	/*
	const int N = pow(10, 4);
	double dx = 1.0 / N;

	array<double, N> x;
	array<double, N> y;

	x[0] = 0.0;
	y[0] = 1.0;

	for (int i = 1; i < N; i++) {
		x[i] = i * dx;
	}

	for (int i = 1; i < N; i++) {
		y[i] = y[i-1] / (1.0 + dx);
	}

	ofstream out("Euler.dat");
	out.setf(ios::scientific|ios::showpos);

	for (int i = 0; i < N; i++) {
		out << x[i] << ' ' << y[i] << '\n';
	}

	out.close();
	*/


	const int N = pow(10, 4);

	array<double, N> x;
	array<double, N> y;

	string line;
	ifstream input("Euler.dat");
	assert(input.is_open());

	for (int i = 0; i < N-2; i++) {
		istringstream s(line);
		s >> x[i] >> y[i];
		cout << y[i] << endl;
	}

	input.close();

	double worst = 0.0;

	for (int i = 0; i < N; i++) {
		if (abs(y[i] - exp(-x[i])) > worst) {
			worst = abs(y[i] - exp(-x[i]));
		}
	}

	cout << worst << endl;


	return 0;
}
