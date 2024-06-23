all: main.x

main.x: main.f90
	gfortran main.f90 -o main.x
	./main.x
