*** Settings ***

Resource  ../resource/CancelaBoletoResource.robot

*** Test Case ***
TC001: Validar cancelamento de boleto no crédito com sucesso
    Solicitar cancelamento  0307  2019-07-09T15:55:02.917Z  PA  17  B919326461
    Validar status code sucesso


TC002: Validar cancelamento de boleto no crédito com falha
    Solicitar cancelamento  0307  2019-07-09T15:55:02.917Z  PA  17  B919326461
    Validar status code falha