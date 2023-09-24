# Two Point Boundary Value Problem: Life-Cycle Consumption

p = 0.05
r = 0.06
a0 = 1
aT = 0
tresh = 0.0001
h = 0.0001
n = 100

function life_cycle_consumption(p, r, a, c)
    a_prime = r * a - c
    c_prime = (r - p) * c
    return a_prime, c_prime
end


function shoot_life_cycle_consumption(p, r, a0, aT, n, h, tresh)
    at = ones(Int(n/h))
    ct = ones(Int(n/h))
    c_l = 0
    c_r = a0
    c0 = (c_l + c_r) / 2
    j = 0
    while abs(at[end] - aT) >= tresh
        j  = j + 1
        at[1] = a0
        ct[1] = c0
        for i in 1:length(at) - 1
            a_prime, c_prime = life_cycle_consumption(p, r, at[i], ct[i])
            ct[i+1] = ct[i] + h * c_prime
            at[i+1] = at[i] + h * a_prime
        end
        
        if at[end] - aT > tresh
            c_l = c0
        elseif at[end] - aT < -tresh
            c_r = c0
        end
        c0 = (c_l + c_r) / 2

        println("$j: at[end]= $(at[end]), c0 = $c0")
    end

    return "FINAL: aT = $(at[end]), c0 = $c0, cT = $(ct[end])"
end


println(shoot_life_cycle_consumption(p, r, a0, aT, n, h, tresh))