*** Settings ***
Library    SeleniumLibrary
Library    Collections
Library    String
Variables    ../PageObjects/Locators.py

*** Variables ***
${expectedTitle}    EXPLORE BOAT${SPACE}${SPACE}TYPES & MODELS
*** Keywords ***
Open new browser to work
    [arguments]    ${url}    ${browser}
    Open Browser    ${url}    ${browser}
    Maximize Browser Window
Verify Items in the Header
    Wait Until Element Is Visible    ${header_elements}
    @{expectedList}    Create List    BOATS    SHOPPING TOOLS    WHY LUND?    LUND LIFE    OWNER RESOURCES    GEAR    VIEW MY BOATS
    @{actualList}    Create List
    ${elements}    Get WebElements    ${header_elements}
    Sleep    4
    FOR    ${element}    IN    @{elements}
        Append To List    ${actualList}    ${element.text}
        Log    ${element.text}
    END
    Lists Should Be Equal    ${expectedList}    ${ActualList}
Click on First Header Element
    Click Element    ${boatslink}
Click on ExploreBoatsLink
    Click Element    ${exploreAllBoatslink}
Verify the title
    Wait Until Element Is Visible    ${title}
    ${title1}    Get Text    ${title}
    Log    ${title1}
    Should Be Equal As Strings    ${expectedTitle}    ${title1}
