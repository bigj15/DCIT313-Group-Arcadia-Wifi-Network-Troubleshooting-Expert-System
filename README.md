# DCIT313-Group-Arcadia-Wifi-Network-Troubleshooting-Expert-System

## Project Overview
This project implements a **WiFi Network Troubleshooting Expert System** using **Prolog**.  
The system simulates the reasoning process of a network troubleshooting expert to diagnose common Wi-Fi connectivity problems.

The expert system interacts with the user by asking a series of diagnostic questions and storing the responses as facts. Using **rule-based reasoning and Prolog’s backward chaining mechanism**, the system evaluates IF–THEN rules in the knowledge base to determine the most probable cause of the problem.

Once a diagnosis is made, the system provides:
- The most likely issue
- Recommended troubleshooting steps
- An explanation of the reasoning used to reach the conclusion

The system demonstrates key **Artificial Intelligence concepts** such as:
- Knowledge acquisition
- Knowledge representation
- Inference mechanisms
- Explanation facilities

Common Wi-Fi issues handled by the system include:
- Airplane mode enabled
- Wi-Fi disabled
- Incorrect password or corrupted network profile
- Network adapter or driver issues
- DNS/IP configuration errors
- Router or Internet Service Provider (ISP) problems

This project applies expert system techniques to automate structured troubleshooting tasks in the domain of **computer network diagnostics**. :contentReference[oaicite:0]{index=0}

---

# Group Members

| Name | Student ID | Role |
|-----|-----|-----|
| **Jedidiah Nii Saban Delali Annan** | 22037871 | Project Manager |
| **Isaac Morrison Nii Lartey Quaye** | 22079872 | Knowledge Engineer |
| **Eyram Mami Araba Kumah** | 22047897 | Knowledge Engineer |
| **Emmanuel Eyram Korku Agbetor** | 22206812 | Programmer |
| **Jephthah Peprah** | 22036173 | Programmer |
| **Selorm Sem** | 22243032 | Programmer |
| **Musharafa Moro** | 22059797 | Programmer |

---

# Roles and Responsibilities

### Project Manager
**Jedidiah Nii Saban Delali Annan**

- Coordinated project planning and task distribution
- Oversaw development progress
- Managed integration of system components
- Prepared documentation and ensured project requirements were met

---

### Knowledge Engineers
**Isaac Morrison Nii Lartey Quaye**  
**Eyram Mami Araba Kumah**

- Acquired domain knowledge for Wi-Fi troubleshooting
- Designed the knowledge base for the expert system
- Developed IF–THEN diagnostic rules
- Defined system facts, conditions, and inference logic
- Prepared troubleshooting advice and explanations

---

### Programmers
**Emmanuel Eyram Korku Agbetor**  
**Jephthah Peprah**  
**Selorm Sem**  
**Musharafa Moro**

- Implemented the expert system using **Prolog**
- Built the consultation engine to ask diagnostic questions
- Encoded rule-based inference mechanisms
- Integrated knowledge base with the inference engine
- Implemented output formatting for diagnosis, advice, and explanations
- Conducted system testing and debugging

---

# Technologies Used
- **Logic Engine:** SWI-Prolog
- **Rule-Based Knowledge Representation**
- **Backward Chaining Inference**

---

# Project Structure

```
DCIT313-Group-Arcadia-Wifi-Network-Troubleshooting-Expert-System/
│
├── wifi_expert/
│   ├── wifi_expert.pl
│   │       Entry point. Loads all modules and exposes start/0 and run_tests/0.
│   │
│   ├── knowledge_base.pl
│   │       Static knowledge: diagnostic questions, confidence scores,
│   │       explanations, and step-by-step advice for each diagnosis.
│   │
│   ├── rules.pl
│   │       Six IF-THEN diagnosis rules evaluated by the inference engine
│   │       using Prolog's backward chaining mechanism.
│   │
│   ├── engine.pl
│   │       Inference engine: finds the first matching diagnosis, handles
│   │       the Q&A loop with answer caching, and prints the diagnosis report.
│   │
│   └── tests.pl
│           Automated test suite with 7 pre-loaded test cases covering
│           all six diagnoses, including both patterns of router/ISP failure.
│
└── README.md
        Project overview, group members, setup instructions, and system description.
```

---

# How to Run the System

1. Install **SWI-Prolog**
2. Clone this repository
3. Open the Prolog file

```prolog
?- [wifi_expert].

Run the expert system

?- go.

Answer the diagnostic questions with:

yes.
or
no.
