*** Settings ***
Library     SeleniumLibrary
Library     String

*** Variables ***
${URL}      https://qademo.onebrick.io/
${domain}   gmail.com

*** Test Cases ***
Sign Up Test Case with Valid Email
    [Documentation]     Scenario: Sign Up with valid email using random email
    User is on the Sign Up page
    User fills in the sign up form with valid email
    User click register button
    User should be successfully registered
    User click ok button
    [Teardown]    Teardown Test Case

Sign Up Test Case with Existing Email
    [Documentation]     Scenario: Sign Up with existing email
    User is on the Sign Up page
    User fills in the sign up form with existing email
    User click register button
    User should be unsuccessfully registered
    User click ok button
    [Teardown]    Teardown Test Case

Sign Up Test Case with Passwords Less Than 6 Character
    [Documentation]     Scenario: Sign Up with password less than 6 character
    User is on the Sign Up page
    User fills in the sign up form with password less than 6 char
    User click register button
    User should see error password at least 6 char
    [Teardown]    Teardown Test Case

Sign Up Test Case with Different Passwords
    [Documentation]     Scenario: Sign Up with different passwords
    User is on the Sign Up page
    User fills in the sign up form with different password
    User click register button
    User should see error different passwords
    [Teardown]    Teardown Test Case

*** Keywords ***
User is on the Sign Up page
    Open Browser        ${URL}      chrome
    Maximize Browser Window

User fills in the sign up form with valid email
    ${email}=       Generate Random Email
    Input Text      id=firstName          Rico
    Input Text      id=lastName           Sc
    Input Text      id=email              ${email}
    Input Text      id=phoneNumber        081285689325
    Input Text      id=address            Jalan Empang Bahagia IX No 27
    Input Text      id=password           Qwerty77!
    Input Text      id=confirm_password   Qwerty77!

User fills in the sign up form with existing email
    Input Text      id=firstName          Rico
    Input Text      id=lastName           Sc
    Input Text      id=email              ricosc28@gmail.com
    Input Text      id=phoneNumber        081285689325
    Input Text      id=address            Jalan Empang Bahagia IX No 27
    Input Text      id=password           Qwerty77!
    Input Text      id=confirm_password   Qwerty77!

User fills in the sign up form with password less than 6 char
    Input Text      id=firstName          Rico
    Input Text      id=lastName           Sc
    Input Text      id=email              ricosc28@gmail.com
    Input Text      id=phoneNumber        081285689325
    Input Text      id=address            Jalan Empang Bahagia IX No 27
    Input Text      id=password           Qwert
    Input Text      id=confirm_password   Qwert

User fills in the sign up form with different password
    Input Text      id=firstName          Rico
    Input Text      id=lastName           Sc
    Input Text      id=email              ricosc28@gmail.com
    Input Text      id=phoneNumber        081285689325
    Input Text      id=address            Jalan Empang Bahagia IX No 27
    Input Text      id=password           Qwerty77!
    Input Text      id=confirm_password   Qwerty77

User click register button
    Click Button        name=register

User should be successfully registered
    Wait Until Page Contains Element        xpath=//*[text()='Success']                                            timeout=15s
    Wait Until Page Contains Element        xpath=//*[text()='Check your email to confirm your registration']      timeout=15s
    Capture Page Screenshot

User should be unsuccessfully registered
    Wait Until Page Contains Element        xpath=//*[text()='Error']                      timeout=15s
    Wait Until Page Contains Element        xpath=//*[text()='Email has been taken!']      timeout=15s
    Capture Page Screenshot

User should see error password at least 6 char
    Wait Until Page Contains Element        xpath=//*[text()='Please enter at least 6 characters.']     timeout=15s
    Capture Page Screenshot

User should see error different passwords
    Wait Until Page Contains Element        xpath=//*[text()='Password need to match']      timeout=15s
    Capture Page Screenshot

User click ok button
    Click Button        class:swal2-confirm.swal2-styled

Generate Random Email
    ${random_string}=    Generate Random String    10    [LOWER]
    ${email}=    Set Variable    brick_${random_string}@${domain}
    RETURN   ${email}

User is on the Login page
    Open Browser        ${URL}
    Maximize Browser Window

User fills in the login form with valid email
    Input Text      id=your_email         ricosc27@gmail.com
    Input Text      id=password           Qwerty77!

User click login button
    Click Button        name=login

User should be successfully logged in
    Wait Until Page Contains Element        xpath=//*[text()='Success']                                            timeout=15s
    Wait Until Page Contains Element        xpath=//*[text()='Check your email to confirm your registration']      timeout=15s
    Capture Page Screenshot

Teardown Test Case
    Close Browser