% --- PERSONAJES (nombre, nivel, vida) ---
personaje('Elara', 5, 100).
personaje('Kael', 3, 80).
personaje('Rin', 7, 120).
personaje('William', 6, 110).

% --- EQUIPAMIENTO (personaje, arma(nombre, daño, elemento)) ---
tiene('William', arma(daga_ignea, 45, fuego)).

% --- MISIONES (id, nombre, dificultad, XP) ---
mision(m1, 'Bosque de Sombras', 2, 50).
mision(m2, 'Cueva del Dragón', 5, 120).
mision(m3, 'Torre Arcana', 7, 200).

% --- INVENTARIOS (personaje, lista de objetos) ---
inventario('Elara', [espada, escudo, pocion]).
inventario('Kael', [arco, flechas]).
inventario('Rin', [varita, grimorio, pocion, amuleto]).
inventario('William', [daga_ignea, daga, pocion]).

% --- OBJETOS REQUERIDOS POR MISIÓN ---
requiere(m2, escudo).
requiere(m2, pocion).
requiere(m3, grimorio).
requiere(m3, pocion).