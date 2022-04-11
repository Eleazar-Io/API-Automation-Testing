*** Settings ***
Library         RequestsLibrary
Library         Collections
Library         JSONLibrary

Resource        ../resources/Keywords.robot

*** Test Cases ***
Delete User
    #Get first id's value from first index of body
    ${user_id}=         Get First User Id
    #DELETE Request using id's value, then get respons
    ${res}=             New DELETE Request  ${user_id}
    #Print respons
    log                 ${res}

*** Keywords ***
Get First User Id
    #Create new session
    ${mySession}=       New Session
    #GET Request, then get respons
    ${res}=             GET On Session      ${mySession}       users
    #Get JSON typed body from respons
    ${body}=            set variable        ${res.json()}
    #Get id's value from first index of JSON typed body
    ${id}=              get value from json         ${body}     $[0].id

    #Pass if status code is less than 400 (OK)
    Should be equal     ${res.ok}       ${True}
    #Returning id's value
    [Return]            ${id[0]}
    
New DELETE Request
    [Arguments]         ${id}

    #Create new session
    ${mySession}=       New Session
    #DELETE Request, then get respons
    ${res}=             DELETE On Session      ${mySession}       users/${id}

    #Pass if status code is less than 400 (OK)
    Should be equal     ${res.ok}       ${True}

    #Returning respons
    [Return]            ${res}