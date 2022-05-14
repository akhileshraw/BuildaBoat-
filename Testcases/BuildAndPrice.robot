*** Settings ***
Documentation    Test Suite For Build/Configuration and Pricing
Resource    ../Resources/Functional.robot
Suite Setup    Launch Application Using     chrome
Test Setup    Navigate To Home Page
Suite Teardown    Close Application

*** Test Cases ***
Build And Price A Boat Should Be Successful
    [Tags]    Build    Functional    Regression
    [Documentation]    Test case to Verify Successful Configuration and Pricing
    Navigate To Build And Price
    Select A Model To Build    ALL BOATS    Jon Boat
    Build The Lund    1040 tiller
    Boat Configuration Page Should Be Visible    1040 Jon Boat - Boat Configurator
    ${BasePrice}    Get Boat Base Price
    ${OptionPrice}    Configure A Boat    Default    Default    6.6 Gallon Portable Fuel Tank
    View Build Summary For Zip    60007
    Estimated Boat Price Should Be Base Price Plus Options Price    ${BasePrice}    ${OptionPrice}


