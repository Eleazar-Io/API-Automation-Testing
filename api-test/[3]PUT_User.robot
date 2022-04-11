*** Settings ***
Library         RequestsLibrary
Library         Collections
Library         JSONLibrary
Library         String

Resource        ../resources/Keywords.robot

*** Variables ***
#Test data that Will be use for parameter
${user_id}              2991

*** Test Cases ***
Update User Info
    #Create test data
    ${userInfo}=        Create User Info
    #PUT Request with params, then get JSON data typed body
    ${user}=            New PUT Request     ${user_id}      ${userInfo}
    #Get name's value from JSON data typed body
    ${name}=            get value from json         ${user}     $.name
    
    #Pass if name's value from body is equal to name's value from test data
    Should be equal     ${name[0]}     ${userInfo.name}

*** Keywords ***
Create User Info
    #Generate test data
    ${name}=            Generate Random String      8       [LETTERS]
    ${status}=          set variable        inactive

    #Create dictionary variable using test data
    &{user_info}=       create dictionary           name=${name}        status=${status}

    #Returning test data variable
    [Return]            ${user_info}

New PUT Request
    [Arguments]         ${id}       ${user_info}
    
    #Create new session
    ${mySession}=       New Session
    #PUT Request with parameters using session, then get respons
    ${res}=             PUT On Session      ${mySession}       users/${id}      data=${user_info}
    #Get JSON data typed body
    ${$body}=           set variable        ${res.json()}
    
    #Pass if status code is less than 400 (OK)
    Should be equal     ${res.ok}       ${True}
    #Returning JSON data typed body
    [Return]            ${$body}