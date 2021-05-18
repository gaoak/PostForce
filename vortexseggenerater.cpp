#include<iostream>
#include<vector>
using namespace std;
vector<vector<double> > pts;
double gamma;
double radius;

int initptshump() {
    gamma = 1.;
    radius = 0.05;
    pts.clear();
    double w = 0.1;
    double h = 0.2;
    double x0 = 0.;
    pts.push_back({  -7., 2.5  ,1.,1});
    pts.push_back({x0-w , 2.5  ,1.,0});
    pts.push_back({x0-w , 2.5+h,1.,0});
    pts.push_back({x0+w , 2.5+h,1.,0});
    pts.push_back({x0+w , 2.5  ,1.,0});
    pts.push_back({   7., 2.5  ,1.,1});
}

int main(int argc, char* argv[]) {
    initptshump();
    for(size_t i=0; i+1<pts.size(); ++i) {
        for(size_t j=0; j<4; ++j) {
            printf("%5.2f,", pts[i][j]);
        }
        printf("; ");
        for(size_t j=0; j<4; ++j) {
            printf("%5.2f,", pts[i+1][j]);
        }
        printf("; ");
        printf("%5.2f, %5.2f\n", radius, gamma);
    }
}