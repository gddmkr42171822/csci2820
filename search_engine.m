


            




function app2 = search_engine(A, query, tolerance)

    file_name = 'search_engine';
    disp(['Starting ' file_name]);
    
    n = size(A,2); %retrieve number of columns in the term-by-document matrix
    cosine_vector = [];
    relevant_cols = [];
    relevant_cosine = [];
    
    disp('The query vector is ');
    disp(query);
    
    for i=1:n
        cosine_vector(end + 1) = (transpose(A(:,i))*query)/(norm(A(:,i))*norm(query)); %formula for the cosine similarity measure
        if cosine_vector(i) > tolerance %tagging the columns with a consine angle greater than the tolerance
            relevant_cosine(end+1) = cosine_vector(i);
            relevant_cols(:, end+1) = A(:,i);
        end  
    end
    
    disp('The relevant columns of A to the query are ');
    disp(relevant_cols);
    disp('and their respective cosine angles are');
    disp(relevant_cosine);
    
    [m,n] = size(A);
    if m<n, fprintf('ERROR: A should be an m-by-n matrix with m >= n.\n'); end
    Q = zeros(m,n);
    R = zeros(n,n);
    for k=1:n
        Q(:,k) = A(:,k);
        for j=1:k-1
            R(j,k) = Q(:,j)'*A(:,k);
            Q(:,k) = Q(:,k) - R(j,k)*Q(:,j);
        end
        R(k,k) = norm(Q(:,k));
        Q(:,k) = Q(:,k)/R(k,k);
    end
     
    Q
    R
    r = rank(A);
    %Q = Q(:,1:r)
    %R = R(1:r,:)
    partitioned_r = zeros(4,5);
    %partitioned_r(4,:) = R(4,:) %rank-3
    %partitioned_r(3,:) = R(3,:) %rank-2
    %partitioned_r(2,:) = R(2,:) %rank-1
    %partitioned_r = (-1)*partitioned_r
    %E = Q*partitioned_r
    
    %function row_reduce = reduce(Q, R, row, column)
    %Rank 3 Reduction
    m = size(R,2);
    n = size(R,1);
    E = zeros(n, m);
    for i = 5:n
      for j = 5:m
        E(i,j) = R(i,j);
      end
    end
    E = Q*E;
 
    New = A - E
    
    %{
   [m,n] = size(New);
    if m<n, fprintf('ERROR: A should be an m-by-n matrix with m >= n.\n'); end
    Q = zeros(m,n);
    R = zeros(n,n);
    for k=1:n
        Q(:,k) = New(:,k);
        for j=1:k-1
            R(j,k) = Q(:,j)'*New(:,k);
            Q(:,k) = Q(:,k) - R(j,k)*Q(:,j);
        end
        R(k,k) = norm(Q(:,k));
        Q(:,k) = Q(:,k)/R(k,k);
    end
    %}
    
    cosine_vector1 = [];
    relevant_cosine1 = [];
    relevant_cols1 = [];
    m = size(R,2);
    disp('New cosine with QR decomposition');
    for i=1:n
        cosine_vector1(end + 1) = (transpose(New(:,i))*query)/(norm(New(:,i))*norm(query)); %formula for the cosine similarity measure
        if cosine_vector1(i) > tolerance %tagging the columns with a consine angle greater than the tolerance
            relevant_cosine1(end+1) = cosine_vector1(i);
            relevant_cols1(:, end+1) = A(:,i);
        end  
    end
    
    disp('The relevant columns of A to the query are ');
    disp(relevant_cols1);
    disp('and their respective cosine angles are');
    disp(relevant_cosine1);
    
    cosine_vector1
    
    
    
    
end