function values = GetRndValues(VARIABLES,n)

L=length(VARIABLES);
values=num2cell(zeros(L, 1));

for i=1:L
    if iscell(VARIABLES{i})==0
        values{i} = (datasample(VARIABLES{i},n))';
    else
        if ismatrix(VARIABLES{i}{2}) && ~isvector(VARIABLES{i}{2})
            values{i} = (mvnrnd(VARIABLES{i}{1}, VARIABLES{i}{2}, n))';
        else
            if VARIABLES{i}{2} == 1
                values{i}=2*VARIABLES{i}{1}(2)*(rand(1,n)-(1/2))+VARIABLES{i}{1}(1);
            else
                if VARIABLES{i}{2} == 2
                    values{i}=normrnd(VARIABLES{i}{1}(1),VARIABLES{i}{1}(2),[1,n]);
                else
                    if VARIABLES{i}{2} == 3
                        DEL=VARIABLES{i}{1}(2)*sqrt(12)/2;
                        values{i}=2*DEL*(rand(1,n)-(1/2))+VARIABLES{i}{1}(1);
                    end
                end
            end
        end
    end
end

values = cell2mat(values);

end

