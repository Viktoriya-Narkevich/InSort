procedure insert(var a: mas);
var
	t, i, j, left, right: integer;
	x: array[1..2 * n] of integer;
begin
	left := n;
	right := n; 
	x[n] := a[1];
	for i := 2 to n do 
	begin
		t := a[i];
		if t >= a[1] 
			then 
				begin
					Inc(right);
					j := right;
					while t < x[j - 1] do 
					begin
						x[j] := x[j - 1];
						Dec(j);
					end;
					x[j] := t;
				end
			else 
				begin
					Dec(left);
					j := left;
					while t > x[j + 1] do 
					begin
						x[j] := x[j + 1];
						Inc(j);
					end;
					x[j] := t;
				end;
	end;
	for j := 1 to n do
		a[j] = x[j + left - 1];
end;