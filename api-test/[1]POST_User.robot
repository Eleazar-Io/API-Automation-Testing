*** Settings ***
Library         RequestsLibrary
Library         Collections
Library         String
Library         JSONLibrary

Resource        ../resources/Keywords.robot

*** Test Cases ***
Create User
    #Create test data
    ${userInfo}=        Create User Info
    #POST Request using test data, then get body
    ${body}=            New POST Request    ${userInfo}
    #Print body
    log                 ${body}

*** Keywords ***
Create User Info
    #Generate test data
    ${name}=            Generate Random String      8       [LETTERS]
    ${email}=           Generate Random String      8
    ${gender}=          set variable                male
    ${status}=          set variable                active

    #Create dictionary variable using test data
    &{user_info}=       create dictionary           name=${name}    email=${email}@mail.com      gender=${gender}    status=${status}
    #Returning test data variable
    [Return]            ${user_info}

New POST Request
    [Arguments]         ${user_info}
    #Create new session
    ${mySession}=       New Session
    #POST Request with parameters using session, then get respons
    ${res}=             POST On Session     ${mySession}    users   data=${user_info}
    #Get body from respons
    ${body}=            set variable        ${res.json()}

    #Pass if status code is less than 400 (OK)
    Should be equal     ${res.ok}       ${True}
    #Returning body
    [Return]            ${body}