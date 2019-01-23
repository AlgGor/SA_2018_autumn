function [value,isterminal,direction] = igorsEvents(t,y)
    value = y(1);     % detect height = 0
    isterminal = 1;   % stop the integration
    direction = -1;   % negative direction
end