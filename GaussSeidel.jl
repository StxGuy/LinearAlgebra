using PyPlot

function GaussSeidel!(V,BC)
    
    Ny,Nx = size(V)
    
    V_left = BC[1]
    V_right = BC[2]
    V_top = BC[3]
    V_bottom = BC[4]

    error = 0
    for j in 1:Nx
        for i in 1:Ny
            if (j == 1)
                left = V_left
            else
                left = V[i,j-1]
            end
            if (j == Nx)
                right = V_right
            else
                right = V[i,j+1]
            end
            if (i == 1)
                top = V_top
            else
                top = V[i-1,j]
            end
            if (i == Ny)
                bottom = V_bottom
            else
                bottom = V[i+1,j]
            end
            
            old = V[i,j]
            V[i,j] = 0.25*(left + right + top + bottom)
            error += (V[i,j] - old)^2
        end
    end
    
    return sqrt(error/(Nx*Ny))
end

function Laplace(BC)
    V = rand(100,100)
    
    it = 0
    Δ = 1
    while(Δ > 1E-5 && it < 1E5)
        Δ = GaussSeidel!(V,[1 -1 0 0])
    end
    
    return V
end
        
imshow(Laplace([1 -1 0 0]))    
show()
