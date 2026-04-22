#!/usr/bin/env python3
"""
WiFi Expert System Interface Module
Provides an interactive CLI for diagnosing WiFi connectivity issues.
"""

from pyswip import Prolog

def ask_user(question):
    """Ask user a yes/no question and return normalized answer."""
    while True:
        user_input = input(f"{question} (yes/no): ").strip().lower()
        if user_input in ['yes', 'y']:
            return 'yes'
        elif user_input in ['no', 'n']:
            return 'no'
        else:
            print("Please answer yes or no.")

def get_question(prolog, fact):
    """Retrieve the question text for a given fact."""
    query_result = list(prolog.query(f"question({fact}, Q)"))
    if query_result:
        return query_result[0]['Q']
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
    
    # If we reach here, use best_diagnosis to find the match
    result = list(prolog.query("best_diagnosis(Diagnosis, Score)"))
    if result:
        diagnosis = result[0]['Diagnosis']
        return get_diagnosis_and_display(prolog, diagnosis)
    else:
        return get_diagnosis_and_display(prolog, 'no_clear_diagnosis')

def get_diagnosis_and_display(prolog, diagnosis):
    """Retrieve and display diagnosis, advice, and explanation."""
    # Get confidence score
    diagnosis_result = list(prolog.query(f"diagnosis({diagnosis}, Score)"))
    if diagnosis_result:
        score = diagnosis_result[0]['Score']
    else:
        score = 0
    
    # Get advice
    advice_query_result = list(prolog.query(f"advice({diagnosis}, Advice)"))
    if advice_query_result:
        advice_list = advice_query_result[0]['Advice']
    else:
        advice_list = []
    
    # Get explanation
    explain_query_result = list(prolog.query(f"explain({diagnosis}, Explanation)"))
    if explain_query_result:
        explain_list = explain_query_result[0]['Explanation']
    else:
        explain_list = []

    # Format and print results
    print("\n" + "="*50)
    print(f"Most Likely Issue: {diagnosis.replace('_', ' ').title()}")
    print(f"Confidence: {score}%")
    print("="*50)
    
    if advice_list:
        print("\nRecommended Actions:")
        for action in advice_list:
            print(f"* {action}")

    if explain_list:
        print("\nExplanation:")
        for explanation in explain_list:
            print(f"* {explanation}")
    
    print("\n" + "="*50)

def main():
    print("Wi-Fi Expert System - Diagnostic Tool")
    print("="*50)
    print("Answer the following questions to diagnose your Wi-Fi problem.\n")
    
    try:
        run_consultation()
    except FileNotFoundError:
        print("Error: Could not find 'knowledge_base/wifi_expert_system.pl'")
        print("Make sure you are running this from the project root directory.")
    except Exception as e:
        print(f"Error: {e}")

if __name__ == "__main__":
    main()
