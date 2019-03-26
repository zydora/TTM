% Write an efficient (=no "for-loops" are used) function to compute the inner product of two arbitrary-degree tensors A,B.
function X = InPro(A,B)
dim1 = size(A);
dim2 = size(B);
if length(dim1)~=length(dim2)
    fprintf('Input tensors have different dimension'); 
    return
else for i = 1:length(dim1)
        if dim1(i)~=dim2(i)
            fprintf('They are different in at least one dimension')
            return
        end
    end
end
tA = A(:);
tB = B(:);
X = tA'*tB;
end