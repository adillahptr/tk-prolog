/*
Nama Kelompok: Vaah
Anggota Kelompok:
- Adillah Putri - 2006529114
- Ammar Muhammad Zufar Misbahussalam - 1906308223
- Heidi Renata Halim - 2006596320
- Vander Gerald Sukandi - 1906350603
*/

% definisi rule
vitamin("A").
vitamin("C").
vitamin("D").
vitamin("E").
vitamin("K").
vitamin("B1").
vitamin("B2").
vitamin("B3").
vitamin("B5").
vitamin("B6").
vitamin("B7").
vitamin("B9").
vitamin("B12").

is_list_of_vitamin([X]) :- vitamin(X).
is_list_of_vitamin([H|T]) :- 
    vitamin(H), 
    is_list_of_vitamin(T).

tambah_makanan(M, L, P, K, V, JV, H, IG) :-
    \+ makanan(M),
    validate_input_makanan(M, L, P, K, V, JV, H, IG),
    assert_makanan(M),
    assert_lemak(M,L),
    assert_protein(M,P),
    assert_karbohidrat(M,K),
    assert_vitamin(M,V),
    assert_jumlah_vitamin(M,JV),
    assert_harga(M,H),
    assert_indeks_glukemik(M,IG).

delete_makanan(M) :-
    makanan(M),
    retract_makanan(M),
    retract_lemak(M,_),
    retract_protein(M,_),
    retract_karbohidrat(M,_),
    retract_vitamin(M,_),
    retract_jumlah_vitamin(M,_),
    retract_harga(M,_),
    retract_indeks_glukemik(M,_).


update_makanan(M, L, P, K, V, JV, H, IG) :-
    makanan(M),
    delete_makanan(M),
    tambah_makanan(M, L, P, K, V, JV, H, IG).

validate_input_makanan(M, L, P, K, V, JV, H, IG) :-
    atomic(M),
    number(L),
    number(P),
    number(K),
    number(H),
    (V==[] ; is_list_of_vitamin(V)),
    (JV==[] ; is_list_of_number(JV)),
    has_same_length(V, JV),
    number(IG),
    L>=0, P>=0, K>=0, H>=0, IG>=0.

filter_makanan(M, X, Harga_Min, Harga_Max, Kalori_Min, Kalori_Max, Lemak_Min, Lemak_Max, Protein_Min, 
                Protein_Max, Karbohidrat_Min, Karbohidrat_Max, IG_Min, IG_Max, List_Vitamin) :-
    makanan_search(X, M),
    harga_more_than(M, Harga_Min),
    (Harga_Max==none ; (Harga_Max\==none, harga_less_than(M, Harga_Max))),
    calori_more_than(M, Kalori_Min),
    (Kalori_Max==none ; (Kalori_Max\==none, calori_less_than(M, Kalori_Max))),
    lemak_more_than(M, Lemak_Min),
    (Lemak_Max==none ; (Lemak_Max\==none, lemak_less_than(M, Lemak_Max))),
    protein_more_than(M, Protein_Min),
    (Protein_Max==none ; (Protein_Max\==none, protein_less_than(M, Protein_Max))),
    karbohidrat_more_than(M, Karbohidrat_Min),
    (Karbohidrat_Max==none ; (Karbohidrat_Max\==none, karbohidrat_less_than(M, Karbohidrat_Max))),
    indeks_glukemik_more_than(M, IG_Min),
    (IG_Max==none ; (IG_Max\==none, indeks_glukemik_less_than(M, IG_Max))),
    has_vitamin(M, List_Vitamin).

makanan_search(X, M) :-
    makanan(M),
    sub_atom(M, 0, _, _, X).

is_list_of_number([X]) :- number(X).
is_list_of_number([H|T]) :- 
    number(H), 
    is_list_of_number(T).

is_list_of_string([X]) :- string(X).
is_list_of_string([H|T]) :- 
    string(H), 
    is_list_of_string(T).

has_same_length(L1, L2) :- 
    length(L1, Len1), 
    length(L2, Len2), 
    Len1=:=Len2.

data_makanan(M, L, P, K, V, JV, H, IG, C) :-
    makanan(M),
    protein(M,P),
    karbohidrat(M,K),
    lemak(M,L),
    vitamin(M, V),
    jumlah_vitamin(M, JV),
    harga(M, H),
    indeks_glukemik(M, IG),
    kalori(M, C).

kalori(M, Ans):-
    protein(M,P),
    karbohidrat(M,K),
    lemak(M,L),
    protein_kalori(P,Kp),
    lemak_kalori(L,Kl),
    karbohidrat_kalori(K,Kk),
    Ans is Kp+Kl+Kk.

harga_less_than(M,V):-
   makanan(M),
   harga(M,Hm),
   Hm =< V.

harga_between(M, V1, V2) :-
    makanan(M),
    harga(M, Hm),
    Hm >= V1,
    Hm =< V2.

harga_more_than(M, V) :-
    makanan(M),
    harga(M, Hm),
    Hm >= V.

indeks_glukemik_less_than(M,Ig):-
    makanan(M),
    indeks_glukemik(M,Mig),
    Mig =< Ig.

indeks_glukemik_more_than(M,Ig):-
    makanan(M),
    indeks_glukemik(M,Mig),
    Mig >= Ig.

calori_less_than(M,C):-
    makanan(M),
    kalori(M, Cm),
    Cm =< C.

calori_more_than(M,C):-
    makanan(M),
    kalori(M, Cm),
    Cm >= C.

lemak_less_than(M, L) :-
    makanan(M),
    lemak(M, Lm),
    Lm =< L.

lemak_more_than(M, L) :-
    makanan(M),
    lemak(M, Lm),
    Lm >= L.

protein_less_than(M, P) :-
    makanan(M),
    protein(M, Pm),
    Pm =< P.

protein_more_than(M, P) :-
    makanan(M),
    protein(M, Pm),
    Pm >= P.

karbohidrat_less_than(M, K) :-
    makanan(M),
    karbohidrat(M, Km),
    Km =< K.

karbohidrat_more_than(M, K) :-
    makanan(M),
    karbohidrat(M, Km),
    Km >= K.

protein_kalori(P,Ans):-
    Ans is P*3.

lemak_kalori(L,Ans):-
    Ans is L*4.

karbohidrat_kalori(K,Ans):-
    Ans is K*3.

% rule untuk mencari jumlah vitamin V di makanan M

get_vitamin(M, V, Ans) :-
    vitamin(M,Lv),
    jumlah_vitamin(M,Lvt),
    get_vitamin_list(V,Lv,Lvt,Ans).

get_vitamin_list(_, [], [], 0) :- !.
get_vitamin_list(V, [V | _], [H | _], H) :- !.
get_vitamin_list(V, [_ | Tv], [_ | Tvt], Ans) :-
    get_vitamin_list(V, Tv, Tvt, Ans).

% rule untuk mencari makanan M yang memiliki suatu vitamin V dengan jumlah JV

has_vitamin(_, []) :- !.
has_vitamin(M, [Hv|Tv]) :-
    makanan(M),
    vitamin(M, LV),
    member(Hv, LV),
    has_vitamin(M, Tv).


% rule untuk mencari jumlah kalori protein dari list makanan

tprot_kalori([],[],0) :- !.
tprot_kalori([Hm|Tm],[Hj|Tj],Ans) :-
    tprot_kalori(Tm,Tj,R),
    makanan(Hm),
    protein(Hm,D),
    protein_kalori(D,Dp),
    T is Dp*Hj,
    Ans is T+ R.

% rule untuk mencari total harga dari list makanan

total_harga([], [], 0).
total_harga([M|TM], [J|TJ], Ans) :-
    total_harga(TM, TJ, R),
    makanan(M),
    harga(M, Hm),
    T is Hm * J,
    Ans is T + R.

% rule untuk mencari jumlah kalori karbohidrat dari list makanan

tkar_kalori([],[],0) :- !.
tkar_kalori([Hm|Tm],[Hj|Tj],Ans) :-
    tkar_kalori(Tm,Tj,R),
    makanan(Hm),
    karbohidrat(Hm,D),
    karbohidrat_kalori(D,Dp),
    T is Dp*Hj,
    Ans is T+ R.

% rule untuk mencari jumlah kalori lemak dari list makanan

tlemak_kalori([],[],0) :- !.
tlemak_kalori([Hm|Tm],[Hj|Tj],Ans) :-
    tlemak_kalori(Tm,Tj,R),
    makanan(Hm),
    lemak(Hm,D),
    lemak_kalori(D,Dp),
    T is Dp*Hj,
    Ans is T+ R.

tinggi_lemak(Lm,Lj) :-
    tlemak_kalori(Lm,Lj,Jf),
    tkar_kalori(Lm,Lj,Jkar),
    tprot_kalori(Lm,Lj,Jp),
    S is Jf+Jkar+Jp,
    Rat is Jf/S,
    Rat >= 0.35.

tinggi_karbo(Lm,Lj) :-
    tlemak_kalori(Lm,Lj,Jf),
    tkar_kalori(Lm,Lj,Jkar),
    tprot_kalori(Lm,Lj,Jp),
    S is Jf+Jkar+Jp,
    Rat is Jkar/S,
    Rat >= 0.50.

tinggi_protein(Lm,Lj) :-
    tlemak_kalori(Lm,Lj,Jf),
    tkar_kalori(Lm,Lj,Jkar),
    tprot_kalori(Lm,Lj,Jp),
    S is Jf+Jkar+Jp,
    Rat is Jp/S,
    Rat >= 0.20.
    
%memilih set of beberapa kombinasi dari makanan
menu_plan(Ind, Amt, Budget, Kalori_Min, Kalori_Max, Lemak_Min, Lemak_Max, Protein_Min, AnsList, Tot_price, Tot_kalori, Tot_lemak, Tot_protein):-
    get_food(Ind, Amt, [], 0 , 0, 0, 0, Tot_price, Tot_kalori, Tot_lemak, Tot_protein, AnsList),
    Tot_price =< Budget,
    Tot_kalori >= Kalori_Min,
    (Kalori_Max==none ; (Kalori_Max\==none, Tot_kalori =< Kalori_Max)),
    Tot_lemak >= Lemak_Min,
    (Lemak_Max==none ; (Lemak_Max\==none, Tot_lemak =< Lemak_Max)),
    Tot_protein >= Protein_Min.


get_food(Ind, Amt, AccList, Acc_price, Acc_lemak, Acc_protein, Acc_kalori, Tot_price, Tot_Kalori, Tot_lemak, Tot_protein, AnsList):-
    Amt > 0,
    makanan(M),
    harga(M, P),
    protein(M,Po),
    lemak(M,L),
    kalori(M,K),
    (Ind==none ; (Ind\==none, indeks_glukemik_less_than(M, Ind))),

    append( AccList, [M], AccListN),
    Acc_priceN is Acc_price+P,
    Acc_lemakN is Acc_lemak+L,
    Acc_proteinN is Acc_protein+Po,
    Acc_kaloriN is Acc_kalori + K,
    AmtN is Amt-1,
    get_food(Ind, AmtN, AccListN, Acc_priceN, Acc_lemakN, Acc_proteinN, Acc_kaloriN, Tot_price, Tot_Kalori, Tot_lemak, Tot_protein, AnsList).

get_food(_, 0, AccList, Acc_price, Acc_lemak, Acc_protein, Acc_kalori, Acc_price, Acc_kalori, Acc_lemak, Acc_protein, AccList).

tambah_user(Username, Password) :-
    \+ user(Username, _),
    assert_user(Username, Password).

verify_user(Username, Password) :-
    crypto_password_hash(Password, X),
    user(Username, X).   
