Feature: Check the swagger

  Background:
    * url baseURI1

  Scenario: GET operation to list the swagger json resouces
    Given path endpoint6
    When method GET
    Then status 200
    And match response != null