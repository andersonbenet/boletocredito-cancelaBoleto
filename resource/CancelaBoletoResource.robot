*** Settings ***
Library  RequestsLibrary
Library  String
Library  BuiltIn
Library  Collections
Library  OperatingSystem
Library  DatabaseLibrary
Library  JSONSchemaLibrary  C:\\Users\\anderson_benet\\Documents\\git_robotframework\\boletocredito-cancelaBoleto\\schemas

*** Variables ***
${base_uri}  https://boletocredito-parcela-boleto-api-hom.uat.rs-1.paas.sicredi.net
${base_path}  /cancelaBoleto
&{headers}
    ...   Content-Type=application/json

*** Keywords ***
Solicitar cancelamento
    [Arguments]  ${agencia}  ${dataCancelamento}  ${motivoCancelamento}  ${parcela}  ${titulo}
    Create Session      api    ${base_uri}  disable_warnings=1

    ${body}    Get File    C:\\Users\\anderson_benet\\Documents\\git_robotframework\\boletocredito-cancelaBoleto\\request\\request_cancela_boleto.json
    ${body}    Replace String  ${body}  new_agencia             ${agencia}
    ${body}    Replace String  ${body}  new_dataCancelamento    ${dataCancelamento}
    ${body}    Replace String  ${body}  new_motivoCancelamento  ${motivoCancelamento}
    ${body}    Replace String  ${body}  new_parcela             ${parcela}
    ${body}    Replace String  ${body}  new_titulo              ${titulo}

    ${response}=    POST Request    api    ${base_path}/   data=${body}  headers=${headers}
    Set Global Variable    ${response}
    Log  ${response}

Validar status code sucesso
    Should Be Equal As Strings	${response.status_code}	200

Validar status code falha
    Should Be Equal As Strings	${response.status_code}	400

Buscar Boleto
     [Arguments]  ${user}  ${password}  ${connect_string}
     connect to database using custom params  cx_Oracle  ${connect_string}
     @{queryResults}=  Query  SELECT P.NUM_AGENCIA, P.COD_SITUACAO, P.NUM_PARCELA, P.COD_TITULO FROM PARCELABOLETO_OWNER.PARCELA_BOLETO P WHERE p.COD_SITUACAO = 'PA' AND ROWNUM < 2

     [Return]  @{queryResults}
