*** Settings ***
Documentation       Downloads .zip file, extracts/unzips the file,
...                 reads the content of the pdfs and search for customers in web application

Library             RPA.Browser.Selenium
Library             RPA.FileSystem
Library             RPA.Archive
Library             RPA.PDF

Task Teardown       Teardown


*** Variables ***
${URL}              https://www.rpa-unlimited.com/uipath-rpa-beginners-course/chapter9-files-and-pdf/
${PATH_DOWNLOAD}    C:${/}RPA${/}RoboCorp${/}Tutorials${/}Search from file${/}downloads${/}


*** Tasks ***
Main
    Navigate to website
    Download PDF files

    ${files}    List Files In Directory    ${PATH_DOWNLOAD}
    FOR    ${file}    IN    @{files}
        ${file_path}    Join Path    ${PATH_DOWNLOAD}    ${file}
        ${order_number}    Find order number from PDF    ${file_path}
        Perform search    ${order_number}
        Upload PDF order    ${file_path}
        Go back to front page
    END


*** Keywords ***
Navigate to website
    Set Download Directory    ${PATH_DOWNLOAD}
    Open Available Browser    ${URL}    maximized=True

Download PDF files
    Empty Directory    ${PATH_DOWNLOAD}
    Click Element When Visible    xpath://*[@id="about"]/div/div[1]/a
    Wait Until Created    ${PATH_DOWNLOAD}PDF.zip
    Extract Archive    ${PATH_DOWNLOAD}PDF.zip    ${PATH_DOWNLOAD}
    Remove File    ${PATH_DOWNLOAD}PDF.zip

Find order number from PDF
    [Arguments]    ${file_path}
    Open Pdf    ${file_path}
    ${matches}    Find Text    ORDER    direction=down
    ${string}    Set Variable    ${matches[0].neighbours[0]}
    ${last_three_chars}    Set Variable    ${string[-3:]}
    Close Pdf
    RETURN    ${last_three_chars}

Perform search
    [Arguments]    ${order_number}
    Input Text    xpath://*[@id="search"]    ${order_number}
    Click Element    xpath://*[@id="about"]/div/div[2]/form/input[2]
    Click Element When Visible    xpath://*[@id="about"]/div/ul/li/a
    Wait Until Page Contains Element    xpath://*[@id="fileToUpload"]

Upload PDF order
    [Arguments]    ${file_path}
    Choose File    xpath://*[@id="fileToUpload"]    ${file_path}
    Click Element    xpath://*[@id="about"]/div/form[2]/input
    Element Should Contain    xpath://*[@role="alert"]    File succesfully uploaded

Go back to front page
    Click Element    xpath://*[@id="about"]/div/a

Teardown
    Close All Browsers
    Empty Directory    ${PATH_DOWNLOAD}
