function [ fibonacciNum ] = fibonacciFunction( n )

if n == 0 || n == 1
    fibonacciNum = n;
else
    fibonacciNum = fibonacciFunction(n-1) + fibonacciFunction(n-2);
end

end

