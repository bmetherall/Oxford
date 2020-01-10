#include "cmath"
#include "vector"
//#include "array"
//#include "iostream"
//#include "fstream" // File stream
#include "string"
#include "cassert" // Provides assert function

using namespace std;

class Student {
private:
	string name;
	int age;
	double height;

public:
	void set_name(string s){
		name = s;
	}

	void set_age(int a){
		age = a;
	}

	void set_height(double h){
		height = h;
	}

	string get_name(){
		return name;
	}

	int get_age(){
		return age;
	}

	double get_height(){
		return height;
	}

	void update_age(){
		age++;
	}

	Student(){
		name = "not_set";
		age = -1;
		height = 0.0;
	};

	Student(string s = "not_set", int a = -1, double h = 0.0){
		name = s;
		age = a;
		height = h;
	};

};

class ODE {
private:
	int N;
	double x;
	double t;
	double dt;

public:

	void set_t(double t_min, double t_max, int n_points) {
		N = n_points;

		assert(t_max > t_min && t_min >= 0.0);
		dt = (double)(t_max - t_min) / n_points;

		x = 1.0;
	}

	double get_t(){
		return t;
	}

	vector<double> get_t_vec(){
		vector<double> t_vec;
		t_vec.resize(N);

		for (int i = 0; i < N; i++){
			t_vec[i] = i * dt;
		}
		return t_vec;
	}

	double get_x(){
		return x;
	}

	double get_dt(){
		return dt;
	}

	void step(double x, const double t, const auto f){
		x += f(x, t) * dt;
		this->x = x;
	}

	vector<double> integrate(const double x0, const auto f) {
		vector<double> x_sol;
		x_sol.resize(N);
		x = x0;
		for (int i = 0; i < N; i++){
			step(x, t, f);
			x_sol[i] = x;
		}
		return x_sol;
	}

};

double my_fun(const double x, const double t){
	return -x;
}

int main(int argc, char *argv[]){

	/*
	Student tim;

	tim.set_name("Tim");
	tim.set_age(46);
	tim.set_height(1.8);

	cout << tim.get_name() << endl << tim.get_age() << endl;
	*/

	/*
	vector<Student> studs;

	studs.resize(3);

	studs[0].set_name("James");
	studs[0].set_age(23);
	studs[0].set_height(1.7);

	studs[1].set_name("Sophie");
	studs[1].set_age(30);
	studs[1].set_height(1.6);

	studs[2].set_name("Joe");
	studs[2].set_age(22);
	studs[2].set_height(1.72);

	// Increment ages
	for (auto& s:studs){
		s.update_age();
	}

	for (size_t i = 0; i < studs.size(); i++){
		cout << studs[i].get_age() << endl;
	}

	// Calc height

	double h = 0.0;

	for (auto& s:studs){
		h += s.get_height();
	}

	cout << h << endl;
	*/


	ODE sol;

	sol.set_t(0.0, 1.0, 10000);

	vector<double> solution = sol.integrate(1.0, my_fun);
	vector<double> tvec = sol.get_t_vec();

	// Compare accuracy
	double worst = 0.0;

	for (size_t i = 0; i < 10000; i++){
		if (abs(solution[i] - exp(-tvec[i])) > worst){
			worst = abs(solution[i] - exp(-tvec[i]));
		}
	}

	cout << worst << endl;

	return 0;
}
