*** Settings ***
Library               Collections
Library               RequestsLibrary


*** Test Cases ***
Positive 1 character
    Set Test Variable   &{headers}      IMSI=_
    Create Session      webserver       http://127.0.0.1:5000
    ${resp}=            Get Request     webserver               /     headers=${headers}
    Status Should Be    200             ${resp}

Positive 15 character
    Set Test Variable   &{headers}      IMSI=09azAZ_12345678
    Create Session      webserver       http://127.0.0.1:5000
    ${resp}=            Get Request     webserver               /     headers=${headers}
    Status Should Be    200             ${resp}

Negative 16 character
    Set Test Variable   &{headers}      IMSI=09azAZ_12345678_
    Create Session      webserver       http://127.0.0.1:5000
    ${resp}=            Get Request     webserver               /     headers=${headers}
    Status Should Be    500             ${resp}

Negative 0 character
    Set Test Variable   &{headers}      IMSI=
    Create Session      webserver       http://127.0.0.1:5000
    ${resp}=            Get Request     webserver               /     headers=${headers}
    Status Should Be    500             ${resp}

Negative without IMSI header
    Create Session      webserver       http://127.0.0.1:5000
    ${resp}=            Get Request     webserver               /
    Status Should Be    500             ${resp}

Negative unsupported character
    Set Test Variable   &{headers}      IMSI=!09azAZ_1234567
    Create Session      webserver       http://127.0.0.1:5000
    ${resp}=            Get Request     webserver               /     headers=${headers}
    Status Should Be    500             ${resp}