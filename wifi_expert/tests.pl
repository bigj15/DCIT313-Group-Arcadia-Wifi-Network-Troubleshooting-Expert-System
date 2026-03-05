% =============================================================================
% tests.pl  —  Automated Test Suite
% Pre-loads facts to bypass user input and validates all 7 test cases.
% Run with:  ?- run_tests.
% =============================================================================

run_tests :-
    nl,
    writeln('============================================================='),
    writeln('  RUNNING TEST SUITE'),
    writeln('============================================================='),
    nl,
    test(tc1, [airplane_mode-yes],
         airplane_mode_enabled),

    test(tc2, [airplane_mode-no, wifi_enabled-no],
         wifi_disabled),

    test(tc3, [airplane_mode-no, wifi_enabled-yes, sees_networks-no],
         adapter_or_driver_issue),

    test(tc4, [airplane_mode-no, wifi_enabled-yes, sees_networks-yes,
               can_connect-no, other_devices_connect-yes],
         password_or_profile_issue),

    test(tc5, [airplane_mode-no, wifi_enabled-yes, sees_networks-yes,
               can_connect-yes, connected_to_wifi-yes,
               internet_access-no, other_devices_internet-yes],
         dns_or_ip_stack_issue),

    test(tc6, [airplane_mode-no, wifi_enabled-yes, sees_networks-yes,
               can_connect-no, connected_to_wifi-no, other_devices_connect-no],
         router_or_isp_problem),

    test(tc7, [airplane_mode-no, wifi_enabled-yes, sees_networks-yes,
               can_connect-yes, connected_to_wifi-yes,
               internet_access-no, other_devices_internet-no,
               other_devices_connect-yes],
         router_or_isp_problem),

    nl,
    writeln('============================================================='),
    writeln('  TEST SUITE COMPLETE'),
    writeln('============================================================='),
    nl.

load_facts([]).
load_facts([K-V|T]) :-
    assertz(fact(K, V)),
    load_facts(T).

test(Name, Facts, Expected) :-
    retractall(fact(_, _)),
    load_facts(Facts),
    (   find_diagnosis(Got)
    ->  (   Got == Expected
        ->  format('  [PASS] ~w  =>  ~w~n', [Name, Got])
        ;   format('  [FAIL] ~w  =>  got ~w, expected ~w~n', [Name, Got, Expected])
        )
    ;   format('  [FAIL] ~w  =>  no diagnosis (expected ~w)~n', [Name, Expected])
    ).
