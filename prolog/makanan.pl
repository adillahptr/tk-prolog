% definisi makanan

:- dynamic makanan/1.
:- dynamic lemak/2.
:- dynamic protein/2.
:- dynamic karbohidrat/2.
:- dynamic vitamin/2.
:- dynamic jumlah_vitamin/2.
:- dynamic harga/2.
:- dynamic indeks_glukemik/2.

makanan(apel).
makanan(jeruk).

lemak(apel, 0.4).
lemak(jeruk, 0.5).

protein(apel,0.3).
protein(jeruk, 0.4).

karbohidrat(apel,10).
karbohidrat(apel,10).

vitamin(apel, ["A","C"]).
vitamin(jeruk, ["A","C"]).

jumlah_vitamin(apel,[10,20]).
jumlah_vitamin(jeruk,[10,20]).

harga(apel,100).
harga(jeruk,150).

indeks_glukemik(apel,25).
indeks_glukemik(jeruk,10).
