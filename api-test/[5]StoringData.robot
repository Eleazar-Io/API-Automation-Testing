*** Settings ***
Library         RequestsLibrary
Library         Collections
Library         String
Library         JSONLibrary

Resource        ../resources/Keywords.robot

*** Test Cases ***
Get User List then Store Data
    #GET Request, then get body
    ${body}=            New GET Request     users
    #Create JSON file based on body
    Export Body to JSON File                Users       ${body}
    #Get data from JSON file
    ${json}=            Import JSON File    Users

    #Print data from JSON file
    Log                         ${json}
    #Print first object
    Get First User              ${json}
    #Print name's value of first object
    Get First User's Name       ${json}

*** Keywords ***
New GET Request
    [Arguments]         ${url}

    #Create new session
    ${mySession}=       New Session
    #GET Request, then get respons
    ${res}=             GET On Session      ${mySession}       ${url}
    #Get body from respons
    ${body}=            set variable        ${res.content}

    #Pass if status code is less than 400 (OK)
    Should be equal     ${res.ok}       ${True}
    #Returning body
    [Return]            ${body}

Get First User
    [Arguments]         ${body}
    #Print first object
    Log                 ${body[0]}

Get First User's Name
    [Arguments]         ${body}
    #Get name's value from first index of JSON data typed body
    ${name}=            get value from json         ${body[0]}     $.name
    #Print name's value
    Log                 ${name[0]}