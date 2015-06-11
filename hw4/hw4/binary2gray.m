function k = binary2gray(n)
% convert binary number to gray code 

a = bitshift(n,-1);
k = bitxor(n,a);