
% Formato: personaje(Nombre, Nivel, PuntosVida)
personaje('Elara', 5, 100).
personaje('Kael', 3, 80).
personaje('Rin', 7, 120).
personaje('William', 6, 95).

% Equipamiento: tiene(Personaje, arma(Tipo, Daño, Elemento))
tiene('Elara', arma(espada, 25, fuego)).
tiene('Kael', arma(arco, 18, viento)).
tiene('Rin', arma(baculo, 30, trueno)).
tiene('William', arma(katana, 28, hielo)).

% Inventarios asignados a cada personaje
inventario('Elara', [pocion, pocion, mapa, antorcha]).
inventario('Kael', [flechas, daga, cuerda]).
inventario('Rin', [pergamino, pocion, gema]).
inventario('William', [pocion, elixir, piedra_afilado]).


% ==========================================
% HECHOS: MISIONES Y REQUISITOS
% ==========================================

% Formato: mision(ID, Dificultad, NivelMinimo, RecompensaXP)
mision(m1, facil, 1, 50).
mision(m2, media, 4, 150).
mision(m3, dificil, 6, 300).
mision(m4, legendaria, 8, 600).

% Objeto indispensable para cada misión
requiere(m1, antorcha).
requiere(m2, cuerda).
requiere(m3, pocion).
requiere(m4, gema).
% ==========================================
% REGLAS: ARITMÉTICA BÁSICA
% ==========================================

% Cálculo de XP necesaria por nivel
xp_para_subir(NivelActual, XP) :-
    XP is NivelActual * 30.

% Cálculo de puntos de vida restantes
vida_restante(VidaMax, Danio, Final) :-
    Final is VidaMax - Danio.

% ==========================================
% REGLAS: RECURSIÓN
% ==========================================

% Factorial clásico recursivo
factorial(0, 1).
factorial(N, R) :-
    N > 0,
    N1 is N - 1,
    factorial(N1, R1),
    R is N * R1.

% XP acumulada por completar N misiones
xp_acumulada(0, 0).
xp_acumulada(N, Total) :-
    N > 0,
    N1 is N - 1,
    xp_acumulada(N1, Prev),
    Total is Prev + (30 * N).

% Daño escalado acumulado tras N golpes
dano_acumulado(0, 0).
dano_acumulado(N, Total) :-
    N > 0,
    N1 is N - 1,
    dano_acumulado(N1, Prev),
    Total is Prev + (N * 10).


% Personajes distintos que comparten el mismo nivel
mismo_nivel(P1, P2) :-
    personaje(P1, N, _),
    personaje(P2, N, _),
    P1 \== P2.

% Verifica si la vida del personaje es exactamente 100
es_balanceado(P) :-
    personaje(P, _, Vida),
    Vida =:= 100.

% Valida si un personaje supera a otro en nivel
mas_fuerte(P1, P2) :-
    personaje(P1, N1, _),
    personaje(P2, N2, _),
    N1 > N2.

% Verifica si dos personajes distintos poseen el mismo objeto
mismo_objeto(P1, P2, Obj) :-
    inventario(P1, Inv1),
    inventario(P2, Inv2),
    P1 \== P2,
    member(Obj, Inv1),
    member(Obj, Inv2).


% Hechos de conjugación para el verbo ser
ser(presente, tercera, singular, "es").
ser(pasado, tercera, singular, "fue").

% Motor condicional para conjugar verbos
conjugar_accion(Verbo, Tiempo, Persona, Numero, C) :-
    ( Verbo = "ser" ->
        ser(Tiempo, Persona, Numero, C)
    ; C = Verbo ).


% REGLAS: GESTIÓN DE MISIONES


% Valida si el personaje cumple con el nivel mínimo requerido
puede_aceptar(Personaje, ID_Mision) :-
    personaje(Personaje, Nivel, _),
    mision(ID_Mision, _, Dificultad, _),
    Nivel >= Dificultad.

% Comprueba si el personaje porta un objeto específico
tiene_requerido(Personaje, Objeto) :-
    inventario(Personaje, Lista),
    member(Objeto, Lista).
% 1. Fusionar inventarios de dos personajes con append/3
fusionar_equipo(P1, P2, EquipoFusionado) :-
    inventario(P1, L1),
    inventario(P2, L2),
    append(L1, L2, EquipoFusionado).

% 2. Reporte narrativo combinando todo lo anterior
generar_reporte(Personaje, MisionID, Mensaje) :-
    puede_aceptar(Personaje, MisionID),
    mision(MisionID, Nombre, _, XP),
    conjugar_accion("ser", presente, tercera, singular, F),
    atomic_list_concat(
        [Personaje, F, "capaz de completar", Nombre, "por", XP, "XP"],
        ' ', Mensaje).