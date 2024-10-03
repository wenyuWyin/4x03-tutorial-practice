using Random;
using LinearAlgebra;
using Plots;

# Question 1
Random.seed!(10);

function solve_matrix(n, print_info=false)
    # Generate a random square matrix with size 4
    A_64 = 2 * rand(n, n) .- 1;
    b_64 = 2 * rand(n) .- 1;

    # Solve the linear system Ax = b
    # With Float64
    x_64 = A_64 \ b_64;

    # With BigFloat
    A_big_float = BigFloat.(A_64);
    b_big_float = BigFloat.(b_64);
    x_big_float = A_big_float \ b_big_float;

    # Compute the condition number of matrix A
    cond_number = cond(A_64);

    # Compute the approximation error as the norm of the difference between the solutions of the system obtained with Float64 and BigFloat
    err = norm(x_big_float - x_64);

    if print_info
        println("Matrix A\n$A_64\n");
        println("Condition number\n$cond_number\n");
        println("Approximation error\n$err\n");
    end
    
    return cond_number, err;
end

_, _ = solve_matrix(4, true);

# Question 2
# Reset the seed and repeat the steps 1-4 for 200 randomly generated matrices of szie 10. 
Random.seed!(10);
cond_numbers = [];
errs = [];
for _ in 1:200
    local cond_number, err = solve_matrix(10);
    push!(cond_numbers, cond_number);
    push!(errs, err);
end

replace!(cond_numbers, 0.0 => NaN);
replace!(errs, 0.0 => NaN);

# Plot with log-log scale
scatter(cond_numbers, errs, xscale=:log10, yscale=:log10, label=false);

# The approximation errors are positively related to the condition numbers. 
#   Condition number is a measure of how sensitive a matrix is to small changes in the input, 
#   so the errors introduced by small precision are amplified by large condition numbers, leading to a positive correlation.