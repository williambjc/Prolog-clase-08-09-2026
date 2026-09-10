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

% --- REGLAS ARITMÉTICAS ---
xp_para_subir(NivelActual, XP) :-
    XP is NivelActual * 30.

vida_restante(VidaMax, Danio, Final) :-
    Final is VidaMax - Danio.

% --- RECURSIÓN: FACTORIAL ---
factorial(0, 1).
factorial(N, R) :-
    N > 0,
    N1 is N - 1,
    factorial(N1, R1),
    R is N * R1.

% --- RECURSIÓN: XP ACUMULADA TRAS MISIONES ---
xp_acumulada(0, 0).
% Caso recursivo: XP(N) = XP(N-1) + (30 * N)
xp_acumulada(N, Total) :-
    N > 0,
    N1 is N - 1,
    xp_acumulada(N1, Prev),
    Total is Prev + (30 * N).


%  RECURSION: DAÑO ACUMULADO GOLPES -
dano_acumulado(0, 0).

dano_acumulado(N, Total) :-
    N > 0,
    N1 is N - 1,
    dano_acumulado(N1, Prev),
    Total is Prev + (N * 10).
    % --- COMPARACIÓN Y VALIDACIÓN ---
% ¿Dos personajes distintos con el mismo nivel exacto?
mismo_nivel(P1, P2) :-
    personaje(P1, N, _),
    personaje(P2, N, _),
    P1 \== P2.

% ¿Un personaje con vida exactamente balanceada (100)?
es_balanceado(P) :-
    personaje(P, _, Vida),
    Vida =:= 100.
    
    % --- EJERCICIO 2: COMPARAR PERSONAJES ---


mas_fuerte(P1, P2) :-
    personaje(P1, N1, _),
    personaje(P2, N2, _),
    N1 > N2.

mismo_objeto(P1, P2, Obj) :-
    inventario(P1, Inv1),
    inventario(P2, Inv2),
    P1 \== P2,
    member(Obj, Inv1),
    member(Obj, Inv2).