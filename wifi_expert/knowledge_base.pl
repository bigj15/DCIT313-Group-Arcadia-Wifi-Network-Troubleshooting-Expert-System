% =============================================================================
% knowledge_base.pl  —  Static Knowledge
% Contains: questions, confidence scores, explanations, advice
% =============================================================================

% --- Questions (8) -----------------------------------------------------------

question(airplane_mode,          'Is Airplane Mode ON?').
question(wifi_enabled,           'Is Wi-Fi enabled on the laptop?').
question(sees_networks,          'Can the laptop see Wi-Fi networks?').
question(can_connect,            'Can it connect to the Wi-Fi network?').
question(connected_to_wifi,      'Does it show connected to Wi-Fi?').
question(internet_access,        'Does the internet work on the laptop?').
question(other_devices_connect,  'Do other devices connect to that same Wi-Fi?').
question(other_devices_internet, 'Do other devices have internet on that Wi-Fi?').

% --- Confidence Scores -------------------------------------------------------

confidence(airplane_mode_enabled,     95).
confidence(wifi_disabled,             90).
confidence(adapter_or_driver_issue,   80).
confidence(password_or_profile_issue, 85).
confidence(dns_or_ip_stack_issue,     80).
confidence(router_or_isp_problem,     75).

% --- Explanations ------------------------------------------------------------

explanation(airplane_mode_enabled,
    'Airplane Mode disables wireless radios including Wi-Fi, so the laptop cannot connect until it is turned off.').

explanation(wifi_disabled,
    'Wi-Fi is turned off on the laptop, preventing it from scanning and connecting to networks.').

explanation(adapter_or_driver_issue,
    'Wi-Fi is enabled and Airplane Mode is off, but no networks are visible — the adapter may be disabled, malfunctioning, or the driver is faulty.').

explanation(password_or_profile_issue,
    'The laptop sees networks but cannot connect while other devices can, suggesting incorrect credentials or a corrupted saved Wi-Fi profile.').

explanation(dns_or_ip_stack_issue,
    'The laptop is connected to Wi-Fi but has no internet while other devices do, indicating a DNS or IP configuration problem on this laptop.').

explanation(router_or_isp_problem,
    'Multiple devices cannot connect or cannot access the internet, so the issue is likely with the router or the ISP rather than the laptop.').

% --- Advice (3-4 steps each) -------------------------------------------------

advice(airplane_mode_enabled, [
    'Turn off Airplane Mode.',
    'Enable Wi-Fi afterwards if it remains off.',
    'Reconnect to the Wi-Fi network.',
    'Restart the laptop if Wi-Fi still does not appear.'
]).

advice(wifi_disabled, [
    'Turn on Wi-Fi from Settings or the Wi-Fi key/switch.',
    'Confirm the Wi-Fi adapter is enabled in Network Settings.',
    'Reconnect to the correct network.',
    'Restart the laptop if Wi-Fi will not enable.'
]).

advice(adapter_or_driver_issue, [
    'Restart the laptop.',
    'Check the Wi-Fi adapter is enabled in Device Manager / Network Settings.',
    'Update or reinstall the Wi-Fi driver.',
    'Test with a mobile hotspot or USB Wi-Fi adapter to isolate hardware issues.'
]).

advice(password_or_profile_issue, [
    'Forget the Wi-Fi network and reconnect.',
    'Re-enter the password carefully (confirm it is the latest one).',
    'Restart the router and try again.',
    'Try connecting to a mobile hotspot to confirm the laptop connects elsewhere.'
]).

advice(dns_or_ip_stack_issue, [
    'Disconnect and reconnect to Wi-Fi.',
    'Renew IP / DHCP or run the network troubleshooter.',
    'Flush DNS cache and retry.',
    'Temporarily switch to a public DNS (8.8.8.8 or 1.1.1.1) to test.'
]).

advice(router_or_isp_problem, [
    'Restart the router (power off ~10 seconds, then back on).',
    'Check the router Internet/WAN indicator lights.',
    'Try a mobile hotspot to confirm the laptop itself is not the issue.',
    'Contact the ISP if the internet remains down for all devices.'
]).
