*** Settings ***
Library  DateTime
Resource  ../resource/CancelaBoletoResource.robot


*** Variables ***

${user}=  user_consulta
${password}=  user_consulta
${connect_string}=  '${user}/${password}@(DESCRIPTION=(ADDRESS_LIST=(ADDRESS=(PROTOCOL=TCP)(HOST=dtb1admindb010d.des.sicredi.net)(PORT=1521)))(CONNECT_DATA=(SERVICE_NAME=BOLETOCREDITOHMLPDB)(SERVER=DEDICATED)))'




*** Test Case ***
TC001: Validar cancelamento de boleto no crédito com sucesso
    ${cod_situacao}=  Set Variable  GE
    ${boleto}=  Buscar Boleto  ${user}  ${password}  ${connect_string}  ${cod_situacao}
    ${agencia}=             Set Variable  ${boleto[0][0]}

    ${date}=	Get Current Date
    ${date_format}=  Convert Date  ${date}  result_format=%Y.%m.%d
    ${date}=  Set Variable  ${date_format}T15:55:02.917Z
    ${dataCancelamento}=    Set Variable  ${date}

    ${motivoCancelamento}=  Set Variable  ${boleto[0][1]}
    ${parcela}=             Convert To String  ${boleto[0][2]}
    ${titulo}=              Set Variable  ${boleto[0][3]}

    Solicitar cancelamento  ${agencia}  ${dataCancelamento}  ${motivoCancelamento}  ${parcela}  ${titulo}
    Validar status code sucesso


TC002: Validar cancelamento de boleto no crédito com falha
    ${cod_situacao}=  Set Variable  PA
    ${boleto}=  Buscar Boleto  ${user}  ${password}  ${connect_string}  ${cod_situacao}
    ${agencia}=             Set Variable  ${boleto[0][0]}

    ${date}=	Get Current Date
    ${date_format}=  Convert Date  ${date}  result_format=%Y.%m.%d
    ${date}=  Set Variable  ${date_format}T15:55:02.917Z
    ${dataCancelamento}=    Set Variable  ${date}

    ${motivoCancelamento}=  Set Variable  ${boleto[0][1]}
    ${parcela}=             Convert To String  ${boleto[0][2]}
    ${titulo}=              Set Variable  ${boleto[0][3]}

    Solicitar cancelamento  ${agencia}  ${dataCancelamento}  ${motivoCancelamento}  ${parcela}  ${titulo}
    Validar status code falha
