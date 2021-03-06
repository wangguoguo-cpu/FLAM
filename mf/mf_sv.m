% MF_SV  Solve using multifrontal factorization.
%
%    Typical complexity: same as MF_MV.
%
%    Y = MF_SV(F,X) produces the matrix Y by applying the inverse of the
%    factored matrix F to the matrix X.
%
%    Y = MF_SV(F,X,TRANS) computes Y = F\X if TRANS = 'N' (default), Y = F.'\X
%    if TRANS = 'T', and Y = F'\X if TRANS = 'C'.
%
%    See also MF2, MF3, MF_CHOLMV, MF_CHOLSV, MF_MV, MFX.

function Y = mf_sv(F,X,trans)

  % set default parameters
  if nargin < 3 || isempty(trans), trans = 'n'; end

  % check inputs
  trans = chktrans(trans);

  % handle transpose by conjugation
  if trans == 't', Y = conj(mf_sv(F,conj(X),'c')); return; end

  % dispatch to eliminate overhead
  if F.symm == 'n' || F.symm == 's'
    if trans == 'n', Y = mf_sv_nn(F,X);
    else,            Y = mf_sv_nc(F,X);
    end
  elseif F.symm == 'h', Y = mf_sv_h(F,X);
  elseif F.symm == 'p', Y = mf_sv_p(F,X);
  end
end