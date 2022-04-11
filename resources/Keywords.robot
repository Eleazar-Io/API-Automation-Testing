*** Settings ***
Library         RequestsLibrary
Library         Collections
Library         OperatingSystem
Library         JSONLibrary
Variables       ../resources/variables.py

*** Keywords ***
#Create new session, returning session
New Session
    #setting header (authorization)
    ${header}=          create dictionary       Authorization=Bearer ${access_token}   
    #create session based on url and header
    Create Session      mySession       ${base_url}         headers=${header}
    #returning session's name
    [Return]            mySession

#Export data to JSON file
Export Body to JSON File
    [Arguments]         ${file_name}            ${body}
    #Convert data to String
    ${body}=            Convert to String       ${body}
    #Convert String data into new JSON file
    Create File         ./api-test/result/${file_name}.json         ${body}

#Import JSON file, returning data
Import JSON File
    [Arguments]         ${file_name}
    #Get data from JSON file
    ${json}=            Load JSON From File         ./api-test/result/${file_name}.json
    #returning data
    [Return]            ${json}