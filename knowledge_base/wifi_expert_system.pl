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