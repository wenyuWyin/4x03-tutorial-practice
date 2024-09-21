# Tutorial 2

# Group members: Xiang (Shawn) Zhang, Yucheng Yao, Wenyu (Winnie) Yin

# Write a function 'f' that takes as input a square matrix 'X' of unknown size. 
# The function evaluates the element-wise sine of the matrix and return its eigenvalues.

using LinearAlgebra;

X = [2.1 3.3 3.4 3.3; 3.3 0.2 3.8 0.9; 3.4 3.8 3.7 3.5; 3.3 0.9 3.5 0.2];

function eigenvalue(x)
    x = sin.(x);
    eigenvalues = eigvals(x);
    return eigenvalues;
end

# Apply this function to the matrix X
println("The eigenvalues of X is " * string(eigenvalue(X)));

# Compute the difference between the highest eigenvalue returned by this function
# when X is defined as a Float32 and a Float 64.

x_32 = Float32.(X);
x_64 = Float64.(X);

diff = maximum(eigenvalue(x_32)) - maximum(eigenvalue(x_64));

println("The difference is " * string(diff));

# How big is this difference compared to the machine epsilon?

println("The difference between this value and machine eps (32-bit) is " * string((diff - eps(Float32))));
println("The difference between this value and machine eps (64-bit) is " * string((diff - eps(Float64))));

println("The difference between this value and machine eps (32-bit) is " * string((diff/eps(maximum(eigenvalue(x_32))))));
println("The difference between this value and machine eps (64-bit) is " * string((diff/eps(maximum(eigenvalue(x_64))))));