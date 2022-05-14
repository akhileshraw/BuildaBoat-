*** Settings ***
[Documentation]    Test Automation of Landboats.com
Library    SeleniumLibrary
Library    Collections
Library    String
*** Variables ***
${Timeout}    120 Secs
${url}    https://www.lundboats.com/
${home_page_title}    Lund Aluminum And Fiberglass Fishing Boats
${home_page_link}     xpath://a[@title='Lund Boats']
${build_price_link}    xpath://a[text()='Build & Price']
${build_page_title}    Build Your Boat | Lund
${boat_price_label}    xpath://div[@class='priceHeader']//p[@class='boatPrice']
${NextButton}    xpath://div[@id='nxt']
${ViewSummaryButton}    xpath://button[text()='View Summary']
${ViewSummaryZipText}    xpath:(//input[@name='Zip'])[3]
${YourDealerLabel}    xpath://h3[text()='YOUR DEALER']
${total_price_label}    xpath://div[@class='priceHeader']//p[@class='boatPrice'][normalize-space()='$1,421*']
*** Keywords ***
Launch Application Using 
    [Documentation]    Keyword to launch Website
    [Arguments]    ${browser}
    Set Selenium Timeout    ${Timeout}
    Open Browser    ${url}    ${browser}
    Set Window Position    0    0
    Set Window Size    1920    1024
    Title Should Be    ${home_page_title}
    [Teardown]    Capture Page Screenshot

Navigate To Home Page
    [Documentation]    Keyword to Navigate to HomePage by Clicking on Logo
    Click Element     ${home_page_link}
    Title Should Be     ${home_page_title}
    [Teardown]    Capture Page Screenshot

Navigate To Dealer Page
    [Documentation]    Keyword to Click On Dealer Search on Top Left area
    Click Element    ${Find A Dealer Button}
    [Teardown]    Capture Page Screenshot


Dealer Countries Should Contain
    [Documentation]    Keyword to verify the Dealer country list
    [Arguments]    @{Country List}
    ${Actual Country List}    Get List Items    ${Dealer_Country_List}
    Lists Should Be Equal     ${Country_List}    ${Actual_Country_List}

Search For a Dealer
    [Documentation]    Keyword to search for a dealer by Address
    [Arguments]    ${Country}    ${Address}
    Wait Until Element Is Visible    ${Dealer_Country_List}
    Select From List By Label    ${DealerCountryList}    ${Country}
    Input Text    ${Dealer Address Text}    ${Address}
    Capture Page Screenshot
    Click Element    ${DealerSearchIcon}

Dealer Count Should Be
    [Documentation]    Keyword to verify the Dealer search result count
    [Arguments]    ${Count}
    Title Should Be     ${Dealer Search Page Title}
    Wait Until Element Is Visible    ${FILTER_by_Boat_TYpe_list}
    ${Actual_Count}    Get Element Count    ${Dealer_Search_results}
    Should Be Equal As Integers    ${Count}    ${Actual_Count}
    [Teardown]    Capture Page Screenshot

Navigate To Boat Model
    [Documentation]    Keyword to Navigate to a model by Category And Name
    [Arguments]    ${category}    ${Model}
    Click Element    ${BOATS_MENU}
    Wait Until Element Is Visible    xpath=//a[text()="${Category}"]
    Click Element     xpath=//a[text()="${Category}"]
    Sleep    3    Waiting for menu to appear
    Wait Until Element Is Visible    xpath=//a[text()="${category}"]//following::a[text()="${model}"]
    Click Element    xpath=//a[text()="${Category}"]//following::a[text()="${Model}"]


Model Preview Should Contain Header
    [Documentation]    Keyword to Verify Model preview Popup Header
    [Arguments]    ${header}
    Wait Until Keyword Succeeds    10    2     Element Should be Visible    xpath=//div[@class="tab-pane fade active show"]//h3[text()="${Header}"]
    [Teardown]    Capture Page Screenshot 

Navigate to Model Overview
    [Documentation]    Keyword to Select a Model from Menu
    [Arguments]    {Model}
    Wait Until Element Is Visible    xpath=//div[@class="tab-pane fade active show"]//a[normalize-space9text())="${Model} Overview"]
    Click Element    xpath=//div[@class="tab-pane fade active show"]//a[normalize-space(text())="${Model} Overview"]

Model Overview Page Should be Visible
    [Documentation]    keyword to verify the title of Model Overview page
    [Arguments]    ${Model}
    Title Should Be ${Model}    Series- Family Fishing & Sport Boats | Lund Boats
    [Teardown]    Capture Page Screenshot

Navigate To Build And Price
    [Documentation]    Keyword to navigate to build and price
    CLick Element    ${build_price_link}
    Title Should Be     ${build_page_title}
    [Teardown]    Capture Page Screenshot

Select a Model To Build
    [Documentation]    Keyword to Select a Model by Category and Model Name
    [Arguments]    ${Category}    ${Model}
    Click Element     xpath=//span[text()="${category}"]
    Click Element    xpath=//div[contains(@class,"active")]//h5[text()="${Model}"]/../following-sibling::div/a[text()="SELECT A MODEL"]
    Wait Until Element Is Visible    xpath=//div[contains(@class,"show")]//h4[text()="SELECT YOUR ${Model} MODEL:"]
    [Teardown]    Capture Page Screenshot

Build The Lund
    [Documentation]    Keyword to Click on Build a Model
    [Arguments]    ${SubModel}
    Click Element    xpath=//div[contains(@class,"show")]//h5[@aria-label="${Sub Model}"]//following::a[1]

Boat Configuration Page Should Be Visible
    [Documentation]    Keyword to verify Title of Boat Model Configuration Page
    [Arguments]    ${SubModel}
    Title Should Be    ${SubModel}
    [Teardown]    Capture Page Screenshot

Get Boat Base Price
    [Documentation]    keyword to get Base price of the Boat Model under Configuration Page
    ${price}    Get Element Attribute    ${BOAT PRICE LABEL}    data-dnprice
    [return]    ${Price}

Configure a Boat    
    [Documentation]    Keyword to Select Configuration Options
    [Arguments]    ${Color}    ${Motor}    ${Options}
    Click Element    ${NextButton}
    Click Element    ${NextButton}
    Click Element     Xpath=//p[text()="${Options}"]/../label
    ${OptionPrice}    Get Text    xpath=//p[text()="${Options}"]/following-sibling::p
    ${OptionPrice}    Replace String    ${OptionPrice}    $    ${EMPTY}
    ${OptionPrice}    Convert To Number    ${OptionPrice}
    Click Element    ${Next Button}
    [Return]    ${OptionPrice}

View Build Summary For Zip
    [Documentation]    Keyword to view Build Summary for a Zip code
    [Arguments]    ${Zip Code}
    Wait Until Element Is Visible    ${ViewSummaryButton}
    Input Text    ${ViewSummaryZipText}    ${Zip Code}
    Click Element    ${ViewSummaryButton}
    Wait Until Element Is Visible    ${YourDealerLabel}
    [Teardown]    Capture Page Screenshot

Estimated Boat Price Should Be Base Price Plus Options Price
    [Documentation]    Keyword to verify Estimated Price= Base Price+ Options
    [Arguments]    ${BasePrice}    ${OptionPrice}
    Wait Until Element Is Visible    ${total_price_label}
    ${TotalPrice}    Get Text    ${total_price_label}
    Log    ${TotalPrice}
    ${TotalPrice}=     Remove String    ${TotalPrice}    $    *    ,
    Log    ${TotalPrice}
    ${TotalPrice}=    Convert To Number    ${TotalPrice}
    ${BasePrice}=    Convert To Number    ${BasePrice}
    Log    ${TotalPrice}
    Log    ${BasePrice}
    Log    ${OptionPrice}
    ${ExpectedPrice}=    Evaluate    ${BasePrice}+${OptionPrice}
    Should Be Equal As Numbers    ${ExpectedPrice}    ${TotalPrice}
    [Teardown]    Capture Page Screenshot

Close Application    
    [Documentation]    Keyword to Close all browsers
    Close All Browsers   

