#include <iostream>
#include <cuda_runtime.h>

using namespace std;

__global__ void AddIntsCuda(int* a, int* b) {
	a[0] = a[0] + b[0];
}

int main() {
	int a = 5, b = 9;
	int* d_a, * d_b;
	if (cudaMalloc(&d_a, sizeof(int)) == cudaSuccess) {
		cout << "successfull allocation of a" << endl;
	}
	if (cudaMalloc(&d_b, sizeof(int)) == cudaSuccess) {
		cout << "successfull allocation of b" << endl;
	}


	cudaMemcpy(d_a, &a, sizeof(int), cudaMemcpyHostToDevice);
	cudaMemcpy(d_b, &b, sizeof(int), cudaMemcpyHostToDevice);

	AddIntsCuda<<<1, 1 >>> (d_a, d_b);

	cudaMemcpy(&a, d_a, sizeof(int), cudaMemcpyDeviceToHost);

	cout << "addition result: " << a << endl;

	cudaFree(d_a);
	cudaFree(d_b);

	return 0;
}
