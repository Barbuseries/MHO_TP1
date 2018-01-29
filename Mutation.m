function Mutation
  global MUTATION;

  %% Binary
  MUTATION.bitFlip = @bitFlip;

  %% Arithmetic
  MUTATION.uniform = @uniform;
end

function result = bitFlip(children, l, Pm)
  global UTILS;
  
  %% NOTE: (See corresponding notes in Crossover)
  %% We may want mutation to be different for each variable, in that
  %% case, replace 1 by dim(2) and remove the multiplication by
  %% ones(dim).
  
  dim = size(children);
  %% TODO: Explain!
  mask_as_array = rand(dim(1), l, 1) <= Pm; %% Every allele that needs to mutate is 1 at the correponding index
  mask = UTILS.arrayToDec(mask_as_array) .* ones(dim);

  result = bitxor(children, mask); %% Do a flip!
end

function result = uniform(children, constraints, Pm)
  global UTILS;
  
  dim = size(children);
  dim2 = size(constraints);

  N = dim(1);
  var_count = dim2(1);
  
  %% TODO: Explain!
  %% TODO(@perf): This can probably be improved (I hope).
  mutations = rand(N, var_count, 1) <= Pm;  %% Every allele that needs to mutate is 1 at the correponding index
  result = children .* (mutations == 0) + mutations .* UTILS.randomIn(constraints, N);
end
