function [ MP ] = updating_metric( Y,Mu,center_fea,N)

% seet=[1,10,23,28];
% j=1;
for i=1:N
%     if ismember(i,seet)
        Yp=Y{i};
        mu=Mu(i);
% mu=1.15;
        probFea=center_fea{i,1};
        gallFea=center_fea{i,2};

        sum_val = sqrt(sum(probFea.^2));
%         sum_val(sum_val==0)=0.0000001;
        for n = 1:size(probFea, 1)
            probFea(n, :) = probFea(n, :)./sum_val;
        end

        sum_val = sqrt(sum(gallFea.^2));
    %     sum_val(sum_val==0)=0.0000001;
        for n = 1:size(gallFea, 1)
            gallFea(n, :) = gallFea(n, :)./sum_val;
        end
        pcadim=2048;
        gamma = 2;
        P = eye(pcadim);   %original metric
        % This part is partially from MLAPG in ICCV2015.
        tol = 1e-4;
        L = 1 / 2^8;

        prevAlpha = 0;
        prevM  = P;
        M      = P;
        prevP2 = P;

        % This part is partially from MLAPG in ICCV2015.

        nPos = length(find(Yp(:)==1));
        nNeg = sum(Yp(:) == -1);
        Wp = zeros(size(Yp,1), size(Yp,2));
        Wp(Yp == 1) = 1 / nPos;
        Wp(Yp == -1) = 1 / nNeg;
        WYp = Wp .* Yp;

        for r = 1:50
            newAlpha = (1 + sqrt(1 + 4 * prevAlpha^2)) / 2;
            V = M + (prevAlpha - 1) / newAlpha * (M - prevM);
            alpha = -(prevAlpha - 1) / newAlpha; % for prevP1
            beta = 1 + (prevAlpha - 1) / newAlpha; % for prevP2

            prevP1 = prevP2;
            prevP2 = P;
            prevM = M;
            % prevF = newF;
            prevAlpha = newAlpha;

            Dp = alpha * EuclidDist(probFea * prevP1, gallFea * prevP1) + beta * EuclidDist(probFea * prevP2, gallFea * prevP2) - mu;
            Dp(Yp == -1) = - Dp(Yp == -1);
            T = WYp ./ (1 + exp( -Dp ));
            X = probFea' * T * gallFea;
            gradF = probFea' * bsxfun(@times, sum(T, 2), probFea) - X - X' + bsxfun(@times, gallFea', sum(T, 1)) * gallFea;

            prevF_V =  log(1 + exp( Dp ));
            prevF_V(isinf(prevF_V))=Dp(isinf(prevF_V));

            prevF_V = Wp(:)' * prevF_V(:);

            while true
                [optFlag, M, P, latent, r, newF] = LineSearch(V, gradF, prevF_V, probFea, gallFea, Yp, Wp, L, mu);
                if ~optFlag
                    L = gamma * L;
                else
                    break;
                end
            end
        end

        MP{i}=P;
%         j=j+1;
%     else
%         continue
%     end
end
    

end

