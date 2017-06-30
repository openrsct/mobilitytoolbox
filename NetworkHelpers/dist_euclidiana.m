% Function dist_euclidiana
% Description: Function to calculate euclidean distance between two vectors
%
% ----Input
% => vector a[n,1] ; vector b[n,1]
% ----Output
% r => Calculated euclidean distance
%
% Example: r = dist_euclidiana(a,b)
 
function r = dist_euclidiana(user,ref) 
s_ref = size(ref);
s_user = size(user);

for i = 1:s_user(1)
  if(s_user(2)>=2)
   c = [user(i,1) user(i,2)];
  else
   c = user;   
  end
  
    for j = 1:s_ref(1)
        if(s_ref(2)>=2)
        d  = [ref(j,1) ref(j,2)];
        r(i,j)= sqrt((c(1)-d(1))^2+(c(2)-d(2))^2);
        else
            d = ref;
            r = sqrt((c(1)-d(1))^2+(c(2)-d(2))^2);
        end
    end
end

end




