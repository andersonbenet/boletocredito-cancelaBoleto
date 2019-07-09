*** Settings ***
Library  RequestsLibrary
Library  String
Library  BuiltIn
Library  Collections
Library  OperatingSystem
Library  JSONSchemaLibrary  C:\\Users\\anderson_benet\\Documents\\git_robotframework\\boletocredito-cancelaBoleto\\schemas

*** Variables ***
${base_uri}  https://boletocredito-parcela-boleto-api-hom.uat.rs-1.paas.sicredi.net
${base_path}  /cancelaBoleto

&{headers}
    ...   Content-Type=application/json


*** Keywords ***
################################################################
#TC001: Validar cancelamento de boleto no crédito
################################################################
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

Validar status code sucesso
    Should Be Equal As Strings	${response.status_code}	200

Validar status code falha
    Should Be Equal As Strings	${response.status_code}	400





#Validar status code falha
#    ${status_code}=  Set Variable   ${response.status_code}
#    Run Keyword If  ${status_code}== 200  Log  Passou
#    ...	ELSE IF	${status_code}== 400      Log  Falhou