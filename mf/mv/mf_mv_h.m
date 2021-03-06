% MF_MV_H  Dispatch for MF_MV with F.SYMM = 'H'.

function Y = mf_mv_h(F,X)

  % initialize
  n = F.lvp(end);
  Y = X;

  % upward sweep
  for i = 1:n
    sk = F.factors(i).sk;
    rd = F.factors(i).rd;
    Y(rd,:) = F.factors(i).L'*Y(rd(F.factors(i).p),:);
    Y(rd,:) = Y(rd,:) + F.factors(i).E'*Y(sk,:);
    Y(rd,:) = F.factors(i).U*Y(rd,:);
  end

  % downward sweep
  for i = n:-1:1
    sk = F.factors(i).sk;
    rd = F.factors(i).rd;
    Y(sk,:) = Y(sk,:) + F.factors(i).E*Y(rd,:);
    Y(rd(F.factors(i).p),:) = F.factors(i).L*Y(rd,:);
  end
end