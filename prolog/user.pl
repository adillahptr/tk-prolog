% definisi makanan

:- use_module(library(persistency)).

:- persistent user(username:atom, password:atom).

:- initialization(init).

init:-
  absolute_file_name('prolog/database/user.db', File, [access(write)]),
  db_attach(File, []).

