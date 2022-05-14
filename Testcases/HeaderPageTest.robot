*** Settings ***
Documentation    Test Suite with Single Test for Verifying Header elements
Library    SeleniumLibrary
Library    Collections
Resource    ../Resources/HeaderPage.robot
Test Setup    Open new browser to work    ${url}    ${browser}
Test Teardown    Close Browser
*** Variables ***
${browser}    chrome
${url}    https://www.lundboats.com/

*** Test Cases ***
Verify Header page elements 
    
    Verify Items in the Header
    Click on First Header Element
    Click on ExploreBoatsLink
    Verify the title



