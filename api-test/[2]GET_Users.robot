*** Settings ***
Library         RequestsLibrary
Library         Collections
Library         JSONLibrary

Resource        ../resources/Keywords.robot

*** Variables ***
#Test data that Will be use for parameter
${user_id}      2991

*** Test Cases ***
Get Users List
    #GET Request, then get body
    ${user}=            New GET Request     users
    #Print body
    log                 ${user}

Get User Details
    #GET Request with extra params, then get body
    ${user}=            New GET Request     users/${user_id}
    #Print body
    log                 ${user}
    #Get name's value from body
    ${name}=            get value from json         ${user}     $.name
    #Print name's value
    log                 ${name}

*** Keywords ***
New GET Request
    [Arguments]         ${url}

    #Create new session
    ${mySession}=       New Session
    #GET Request, then get respons
    ${res}=             GET On Session      ${mySession}       ${url}
    #Get body from respons
    ${body}=            set variable        ${res.json()}

    #Pass if status code is less than 400 (OK)
    Should be equal     ${res.ok}       ${True}
    #Returning body
    [Return]            ${body}