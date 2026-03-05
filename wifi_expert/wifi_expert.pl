% =============================================================================
% wifi_expert.pl  —  Entry Point
%
% Usage:
%   ?- start.        % interactive diagnosis
%   ?- run_tests.    % automated test suite
% =============================================================================

:- consult(knowledge_base).
:- consult(rules).
:- consult(engine).
:- consult(tests).

start :-
    retractall(fact(_, _)),
    nl,
    writeln('============================================================='),
    writeln('          Wi-Fi Connectivity Expert System                   '),
    writeln('============================================================='),
    writeln('  Answer each question with:  yes.  or  no.  (include dot)  '),
    writeln('============================================================='),
    nl,
    (   find_diagnosis(Diagnosis)
    ->  print_report(Diagnosis)
    ;   nl,
        writeln('No diagnosis could be determined from your answers.'),
        writeln('Please consult a network technician.')
    ).
