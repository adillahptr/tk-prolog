/*
Nama Kelompok: Vaah
Anggota Kelompok:
- Adillah Putri - 2006529114
- Ammar Muhammad Zufar Misbahussalam - 1906308223
- Heidi Renata Halim - 2006596320
- Vander Gerald Sukandi - 1906350603
*/

% definisi rule

tambah_makanan(M, L, P, K, V, JV, H, IG) :-
    \+ makanan(M),
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

harga_between(M, VA, VB) :-
    makanan(M),
    harga(M, Hm),
    Hm =< VA,
    Hm >= VB.

harga_more_than(M, V) :-
    makanan(M),
    harga(M, Hm),
    Hm >= V.

calori_less_than(M,C):-
    makanan(M),
    kalori(M, Cm),
    Cm =< C.

indeks_glukemik_less_than(M,Ig):-
    makanan(M),
    indeks_glukemik(M,Mig),
    Mig =< Ig.

calori_more_than(M,C):-
    makanan(M),
    kalori(M, Cm),
    Cm >= C.

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
