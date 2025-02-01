math.randomseed(os.time())

function creer_grille(lignes, colonnes)
    local grille = {}
    for i = 1, lignes do
        grille[i] = {}
        for j = 1, colonnes do
            grille[i][j] = math.random(0, 1)
        end
    end
    return grille
end

function afficher_grille(grille)
    for i = 1, #grille do
        for j = 1, #grille[i] do
            io.write(grille[i][j] == 1 and "O " or ". ")
        end
        io.write("\n")
    end
    io.write("\n")
end

function voisins_vivants(grille, x, y)
    local compte = 0
    local directions = { {-1, -1}, {-1, 0}, {-1, 1}, {0, -1}, {0, 1}, {1, -1}, {1, 0}, {1, 1} }
    for _, d in ipairs(directions) do
        local nx, ny = x + d[1], y + d[2]
        if grille[nx] and grille[nx][ny] and grille[nx][ny] == 1 then
            compte = compte + 1
        end
    end
    return compte
end

function mettre_a_jour(grille)
    local nouvelles_valeurs = {}
    for i = 1, #grille do
        nouvelles_valeurs[i] = {}
        for j = 1, #grille[i] do
            local vivants = voisins_vivants(grille, i, j)
            if grille[i][j] == 1 then
                nouvelles_valeurs[i][j] = (vivants == 2 or vivants == 3) and 1 or 0
            else
                nouvelles_valeurs[i][j] = (vivants == 3) and 1 or 0
            end
        end
    end
    return nouvelles_valeurs
end

function jeu_de_la_vie(lignes, colonnes, iterations, delai)
    local grille = creer_grille(lignes, colonnes)
    for _ = 1, iterations do
        os.execute("clear")
        afficher_grille(grille)
        grille = mettre_a_jour(grille)
        os.execute("sleep " .. delai)
    end
end

jeu_de_la_vie(20, 40, 100, 0.2)
