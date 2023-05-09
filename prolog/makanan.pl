% definisi makanan

:- use_module(library(persistency)).

:- persistent makanan(nama_makanan:any).
:- persistent lemak(nama_makanan:atom, jumlah_lemak:float).
:- persistent protein(nama_makanan:atom, jumlah_protein:float).
:- persistent karbohidrat(nama_makanan:atom, jumlah_karbohidrat:float).
:- persistent vitamin(nama_makanan:atom, list_nama_vitamin:list).
:- persistent jumlah_vitamin(nama_makanan:atom, list_jumlah_vitamin:list).
:- persistent harga(nama_makanan:atom, harga:integer).
:- persistent indeks_glukemik(nama_makanan:atom, jumlah_indeks_glukemik:float).

:- initialization(init).

init:-
  absolute_file_name('prolog/database/makanan.db', File, [access(write)]),
  db_attach(File, []).

