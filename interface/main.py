#!/usr/bin/env python3
"""
WiFi Expert System Interface Module
Provides an interactive CLI for diagnosing WiFi connectivity issues.
"""

from pyswip import Prolog

def ask_user(question):
    """Ask user a yes/no question and return normalized answer."""
    while True:
        answer = input(f"{question} (yes/no): ").strip().lower()
        if answer in ['yes', 'y']:
            return 'yes'
        elif answer in ['no', 'n']:
            return 'no'
        else:
            print("Please answer yes or no.")

def get_question(prolog, fact):
    """Retrieve the question text for a given fact."""
    result = list(prolog.query(f"question({fact}, Q)"))
    if result:
        return result[0]['Q']
    return None

def assert_answer(prolog, fact, answer):
    """Assert the user's answer into Prolog's knowledge base."""
    prolog.assertz(f"known({fact}, {answer})")

def run_consultation():
    """Run the adaptive consultation flow."""
    # Initialize Prolog
    prolog = Prolog()
    prolog.consult('knowledge_base/wifi_expert_system.pl')
    
    # Reset known facts
    list(prolog.query("reset"))
    
    # Adaptive consultation flow - stops early when diagnosis is determined
    
    # Step 1: Ask about Airplane Mode
    question = get_question(prolog, 'airplane_mode')
    answer = ask_user(question)
    assert_answer(prolog, 'airplane_mode', answer)
    
    if answer == 'yes':
        # High-confidence diagnosis: airplane mode is on
        return get_diagnosis_and_display(prolog, 'airplane_mode_enabled')
    
    # Step 2: Ask about Wi-Fi Enabled
    question = get_question(prolog, 'wifi_enabled')
    answer = ask_user(question)
    assert_answer(prolog, 'wifi_enabled', answer)
    
    if answer == 'no':
        # Diagnosis: Wi-Fi is disabled
        return get_diagnosis_and_display(prolog, 'wifi_disabled')
    
    # Step 3: Ask about seeing networks
    question = get_question(prolog, 'sees_networks')
    answer = ask_user(question)
    assert_answer(prolog, 'sees_networks', answer)
    
    if answer == 'no':
        # Diagnosis: Adapter or driver issue
        return get_diagnosis_and_display(prolog, 'adapter_or_driver_issue')
    
    # Step 4: Ask about connecting to network
    question = get_question(prolog, 'can_connect')
    answer = ask_user(question)
    assert_answer(prolog, 'can_connect', answer)
    
    if answer == 'no':
        # Need to ask about other devices
        question = get_question(prolog, 'other_devices_connect')
        other_devices = ask_user(question)
        assert_answer(prolog, 'other_devices_connect', other_devices)
        
        if other_devices == 'yes':
            # Diagnosis: Password or profile issue
            return get_diagnosis_and_display(prolog, 'password_or_profile_issue')
        else:
            # Diagnosis: Router or ISP problem
            return get_diagnosis_and_display(prolog, 'router_or_isp_problem')
    
    # Step 5: Can connect = yes, ask about connected_to_wifi
    question = get_question(prolog, 'connected_to_wifi')
    answer = ask_user(question)
    assert_answer(prolog, 'connected_to_wifi', answer)
    
    if answer == 'yes':
        # Ask about internet access
        question = get_question(prolog, 'internet_access')
        answer = ask_user(question)
        assert_answer(prolog, 'internet_access', answer)
        
        if answer == 'no':
            # Ask about other devices' internet
            question = get_question(prolog, 'other_devices_internet')
            other_devices = ask_user(question)
            assert_answer(prolog, 'other_devices_internet', other_devices)
            
            if other_devices == 'yes':
                # Diagnosis: DNS or IP stack issue
                return get_diagnosis_and_display(prolog, 'dns_or_ip_stack_issue')
            else:
                # Diagnosis: Router or ISP problem
                return get_diagnosis_and_display(prolog, 'router_or_isp_problem')
            
            