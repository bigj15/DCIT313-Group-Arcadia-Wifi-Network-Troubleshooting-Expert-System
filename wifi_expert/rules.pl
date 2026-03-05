% =============================================================================
% rules.pl  —  Diagnosis Rules
% Each rule encodes the conditions required for a specific diagnosis.
% Rules are tried in priority order by the inference engine.
% =============================================================================

% 1. Airplane mode is on — highest priority shortcut
diagnosis(airplane_mode_enabled) :-
    ask(airplane_mode, yes).

% 2. Wi-Fi is disabled on the device
diagnosis(wifi_disabled) :-
    ask(airplane_mode, no),
    ask(wifi_enabled,  no).

% 3. Adapter / driver prevents any networks from appearing
diagnosis(adapter_or_driver_issue) :-
    ask(airplane_mode,  no),
    ask(wifi_enabled,   yes),
    ask(sees_networks,  no).

% 4. Network is visible but the device cannot join it; others can
diagnosis(password_or_profile_issue) :-
    ask(airplane_mode,         no),
    ask(wifi_enabled,          yes),
    ask(sees_networks,         yes),
    ask(can_connect,           no),
    ask(other_devices_connect, yes).

% 5. Joined the network but no internet; other devices are fine
diagnosis(dns_or_ip_stack_issue) :-
    ask(connected_to_wifi,      yes),
    ask(internet_access,        no),
    ask(other_devices_internet, yes).

% 6. Multiple devices cannot connect OR cannot reach the internet (OR rule)
diagnosis(router_or_isp_problem) :-
    (   ask(other_devices_connect,   no)    % Pattern A: nobody can join
    ;   ask(other_devices_internet,  no)    % Pattern B: joined but all offline
    ).
