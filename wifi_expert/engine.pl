% =============================================================================
% engine.pl  —  Inference Engine, Q&A, and Report Output
% =============================================================================

:- dynamic fact/2.

% --- Inference ---------------------------------------------------------------

% Tries each candidate diagnosis in order; stops at the first match
find_diagnosis(Diagnosis) :-
    Candidates = [
        airplane_mode_enabled,
        wifi_disabled,
        adapter_or_driver_issue,
        password_or_profile_issue,
        dns_or_ip_stack_issue,
        router_or_isp_problem
    ],
    find_first(Candidates, Diagnosis).

find_first([H|_], H) :- diagnosis(H), !.
find_first([_|T], D) :- find_first(T, D).

% --- Q&A ---------------------------------------------------------------------

% Checks the cache before prompting; stores the answer for reuse
ask(Symptom, Expected) :-
    (   fact(Symptom, Cached)
    ->  Cached = Expected
    ;   question(Symptom, Text),
        format('  ~w~n  > ', [Text]),
        read_answer(Answer),
        assertz(fact(Symptom, Answer)),
        Answer = Expected
    ).

% Validates input — only accepts yes or no
read_answer(Answer) :-
    read(Input),
    (   (Input = yes ; Input = no)
    ->  Answer = Input
    ;   writeln('  [Please type  yes.  or  no.  and press Enter]'),
        write('  > '),
        read_answer(Answer)
    ).

% --- Report Output -----------------------------------------------------------

print_report(Diagnosis) :-
    confidence(Diagnosis,  Score),
    explanation(Diagnosis, Explanation),
    advice(Diagnosis,      Steps),
    nl,
    writeln('============================================================='),
    writeln('  DIAGNOSIS RESULT'),
    writeln('============================================================='),
    format('  Diagnosis  : ~w~n', [Diagnosis]),
    format('  Confidence : ~w%~n', [Score]),
    nl,
    writeln('  --- Why? ---'),
    format('  ~w~n', [Explanation]),
    nl,
    writeln('  --- Recommended Actions ---'),
    print_steps(Steps, 1),
    nl,
    writeln('  --- Facts Collected ---'),
    print_facts,
    writeln('============================================================='),
    nl.

print_steps([], _).
print_steps([H|T], N) :-
    format('  ~w. ~w~n', [N, H]),
    N1 is N + 1,
    print_steps(T, N1).

print_facts :-
    forall(
        fact(Symptom, Answer),
        format('  ~w = ~w~n', [Symptom, Answer])
    ).
