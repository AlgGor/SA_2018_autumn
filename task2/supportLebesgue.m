function sL= supportLebesgue(f, opts,myEps)
    
    function [c,ceq] = mycon(x)
        ceq = [];
        c = f(x)-myEps;
    end
    function [val,point] = rho(l)
        x0 = [0,0];
        A = [];
        b = [];
        Aeq = [];
        beq = [];
        lb = [];
        ub = [];
        %opts = optimoptions('fmincon','Display','None');
        [point, val] = fmincon(@(x) - dot(l, x), x0, A, b, Aeq, beq, lb, ub, @mycon, opts);
        val = -val;
    end

    sL= @rho;
    
end