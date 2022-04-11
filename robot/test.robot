*** Settings ***
Suite Setup     Set dir

*** Test Cases ***
Test robot
    log         ${OUTPUT DIR}

*** Keywords ***
Set dir
    ${OUTPUT DIR}=      set variable        ${OUTPUT DIR}\\result
    