*** Settings ***
Library     SeleniumLibrary
Library     String

*** Variables ***
${URL}      https://qademo.onebrick.io/
${domain}   gmail.com

*** Test Cases ***
Login Test Case with Valid Email
    [Documentation]     Scenario:  Login with valid email
    User is on the Login page
    User fills in the login form with valid email
    User click login button
    User should be successfully logged in
    [Teardown]    Teardown Test Case

Login Test Case with Invalid Email
    [Documentation]     Scenario:  Login with invalid email
    User is on the Login page
    User fills in the login form with invalid email
    User click login button
    User should be unsuccessfully logged in
    [Teardown]    Teardown Test Case

Login Test Case with Empty Crendentials
    [Documentation]     Scenario:  Login with empty crendentials
    User is on the Login page
    User fills in the login form with empty crendentials
    User click login button
    User should be on login page form
    [Teardown]    Teardown Test Case

Login Test Case with Invalid Password
    [Documentation]     Scenario:  Login with invalid password
    User is on the Login page
    User fills in the login form with invalid password
    User click login button
    User should be unsuccessfully logged in
    [Teardown]    Teardown Test Case

*** Keywords ***
User is on the Login page
    Open Browser        ${URL}      chrome
    Click Element    xpath=//a[@href='/login']
    Maximize Browser Window

User fills in the login form with valid email
    Input Text      id=your_email         ricosc27@gmail.com
    Input Text      id=password           Qwerty77!

User fills in the login form with invalid email
    ${email}=       Generate Random Email
    Input Text      id=your_email         ${email}
    Input Text      id=password           Qwerty77!

User fills in the login form with empty crendentials
    Input Text      id=your_email         ${empty}
    Input Text      id=password           ${empty}

User fills in the login form with invalid password
    Input Text      id=your_email         ricosc27@gmail.com
    Input Text      id=password           invalid password

User click login button
    Click Button        name=login

User should be successfully logged in
    Wait Until Page Contains Element        xpath=//*[text()='Success']                     timeout=15s
    Wait Until Page Contains Element        xpath://*[contains(text(),'Welcome Back')]      timeout=15s
    Click Button                            class:swal2-confirm.swal2-styled
    Wait Until Page Contains Element        xpath=//button[@type='button']                  timeout=15s
    Capture Page Screenshot

User should be unsuccessfully logged in
    Wait Until Page Contains Element        xpath=//*[text()='Error']                      timeout=15s
    Wait Until Page Contains Element        xpath=//*[text()='Wrong email or password']    timeout=15s
    Capture Page Screenshot

User should be on login page form
    Wait Until Page Contains Element        xpath=//*[text()='Login']                      timeout=15s
    Capture Page Screenshot

User should see error password at least 6 char
    Wait Until Page Contains Element        xpath=//*[text()='Please enter at least 6 characters.']     timeout=15s
    Capture Page Screenshot

User should see error different passwords
    Wait Until Page Contains Element        xpath=//*[text()='Password need to match']      timeout=15s
    Capture Page Screenshot

Generate Random Email
    ${random_string}=    Generate Random String    10    [LOWER]
    ${email}=    Set Variable    brick_${random_string}@${domain}
    RETURN   ${email}

Teardown Test Case
    Close Browser