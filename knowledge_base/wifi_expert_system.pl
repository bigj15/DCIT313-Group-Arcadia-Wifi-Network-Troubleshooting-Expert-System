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
    findall(Score-Diagnosis, diagnosis(Diagnosis, Score), List),
    sort(List, Sorted), 
    reverse(Sorted, [Score-Diagnosis|_]), !.
best_diagnosis(no_clear_diagnosis, 0).      

% Advice rules
advice(airplane_mode_enabled, [
    'Turn off Airplane Mode.',
    'Enable Wi-Fi afterwards if it remains off.',
    'Reconnect to the Wi-Fi network.',
    'Restart the laptop if Wi-Fi still does not appear.'
]). 

advice(wifi_disabled, [
    'Turn on Wi-Fi from settings or the Wi-Fi key or switch.',
    'Confirm the Wi-Fi adapter is enabled in network settings.',
    'Reconnect to the correct network.',
    'Restart the laptop if Wi-Fi will not enable.'
]).

advice(adapter_or_driver_issue, [
    'Restart the laptop.',
    'Check the Wi-Fi adapter is enabled in Device Manager or Network settings.',
    'Update or reinstall the Wi-Fi driver.',
    'Test with a mobile hotspot or USB Wi-Fi adapter to isolate hardware issues.'
]).

advice(password_or_profile_issue, [
    'Forget the Wi-Fi network and reconnect.',
    'Re-enter the password carefully and confirm it is the latest one.',
    'Restart the router and try again.',
    'Try connecting to a mobile hotspot to confirm the laptop can connect elsewhere.'
]).

advice(dns_or_ip_stack_issue, [
    'Disconnect and reconnect to Wi-Fi.',
    'Renew IP or DHCP or run the network troubleshooter.',
    'Flush DNS and retry.',
    'Temporarily change DNS to a public DNS such as 8.8.8.8 or 1.1.1.1 to test.'
]).

advice(router_or_isp_problem, [
    'Restart the router by powering it off for about 10 seconds and then on again.',
    'Check the router Internet or WAN indicator lights.',
    'Try another network such as a mobile hotspot to confirm the laptop is not the issue.',
    'Contact the ISP if the internet remains down for all devices.'
]).

advice(no_clear_diagnosis, [
    'Collect more details about the connection problem.',
    'Restart both the laptop and router.',
    'Test with another Wi-Fi network or hotspot.',
    'Escalate to technical support if the issue continues.'
]).

% Explanation rules
explain(airplane_mode_enabled, [
    'Airplane Mode disables wireless radios, including Wi-Fi, so the laptop cannot connect until it is turned off.'
]).

explain(wifi_disabled, [
    'Wi-Fi is turned off on the laptop, preventing it from scanning and connecting to networks.'
]).

explain(adapter_or_driver_issue, [
    'Wi-Fi is enabled and Airplane Mode is off, but no networks are visible, indicating the adapter may be disabled, malfunctioning, or the driver is faulty.'
]).

explain(password_or_profile_issue, [
    'The laptop sees networks but cannot connect while other devices can, suggesting incorrect credentials or a corrupted saved Wi-Fi profile.'
]).

explain(dns_or_ip_stack_issue, [
    'The laptop is connected to Wi-Fi but has no internet while other devices do, indicating a DNS or IP configuration problem on the laptop.'
]).

explain(router_or_isp_problem, [
    'If multiple devices cannot connect or cannot access the internet, the issue is likely with the router or the ISP rather than the laptop.'
]).

explain(no_clear_diagnosis, [
    'The available answers do not match any rule strongly enough to produce a confident diagnosis.'
]).