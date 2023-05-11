% definisi makanan

:- use_module(library(persistency)).

:- persistent makanan(nama_makanan:atom).
:- persistent lemak(nama_makanan:atom, jumlah_lemak:number).
:- persistent protein(nama_makanan:atom, jumlah_protein:number).
:- persistent karbohidrat(nama_makanan:atom, jumlah_karbohidrat:number).
:- persistent vitamin(nama_makanan:atom, list_nama_vitamin:list).
:- persistent jumlah_vitamin(nama_makanan:atom, list_jumlah_vitamin:list).
:- persistent harga(nama_makanan:atom, harga:number).
:- persistent indeks_glukemik(nama_makanan:atom, jumlah_indeks_glukemik:number).

:- initialization(init).

init:-
  absolute_file_name('prolog/database/makanan.db', File, [access(write)]),
  db_attach(File, []).

