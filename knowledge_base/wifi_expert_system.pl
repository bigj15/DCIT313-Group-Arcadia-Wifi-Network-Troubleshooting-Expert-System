% WiFi Connectivity Troubleshooting Expert System
% This module contains the diagnostic rules and facts for troubleshooting WiFi issues
% Version: 1.0

:- dynamic known/2.

% Questions mapping
question(airplane_mode, 'Is Airplane Mode ON?').
question(wifi_enabled, 'Is Wi-Fi enabled on the laptop?').
question(sees_networks, 'Can the laptop see Wi-Fi networks?').
question(can_connect, 'Can it connect to the Wi-Fi network?').
question(connected_to_wifi, 'Does it show connected to Wi-Fi?').
question(internet_access, 'Does the internet work on the laptop?').
question(other_devices_connect, 'Do other devices connect to that same Wi-Fi?').
question(other_devices_internet, 'Do other devices have internet on that Wi-Fi?').

% ask/2 predicate
ask(Fact, Answer) :-
    known(Fact, Answer), !.
ask(Fact, Answer) :-
    question(Fact, Question),
    py_ask(Question, Answer),
    assert(known(Fact, Answer)).  

% fact/1 predicate
fact(Fact) :-
    known(Fact, yes).  

% reset/0 predicate
reset :-
    retractall(known(_, _)).

% Diagnosis rules
diagnosis(airplane_mode_enabled, 95) :-
    fact(airplane_mode).  

% Diagnosis rules
diagnosis(airplane_mode_enabled, 95) :-
    fact(airplane_mode). 

diagnosis(adapter_or_driver_issue, 80) :-
    known(airplane_mode, no),
    known(wifi_enabled, yes),
    known(sees_networks, no).

diagnosis(password_or_profile_issue, 85) :-
    known(airplane_mode, no),
    known(wifi_enabled, yes), 
    known(sees_networks, yes),
    known(can_connect, no),
    known(other_devices_connect, yes).

diagnosis(dns_or_ip_stack_issue, 80) :-
    known(connected_to_wifi, yes),
    known(internet_access, no),
    known(other_devices_internet, yes).

diagnosis(router_or_isp_problem, 75) :-
    known(other_devices_connect, no).

diagnosis(router_or_isp_problem, 75) :-
    known(other_devices_internet, no). 

% best_diagnosis/2 predicate
best_diagnosis(Diagnosis, Score) :-           
    
   
