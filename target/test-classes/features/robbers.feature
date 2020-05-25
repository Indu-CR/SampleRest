Feature: Check list of robbers returned by the API

  Background:
    * url baseURI
    * def func1 =
      """
      	function(args)
      	{
      		return args.length
      	}
      """
    * def func2 =
      """
      	function(args)
      	{
      		for(i=0;i<=args.length;i++)
      		{
      			if(args[i].id == 4)
      			{
      				return args[i]
      			}
      		}
      	}
      """

  Scenario: GET operation to list all the robbers resources
    Given path endpoint1
    When method GET
    Then status 200
    And match response != null
    ##################################################################################################
    * def data = response
    Then print "Response data:", data
    * def returnedData1 = call func1 data
    Then print "Number of Users:", returnedData1
    * def returnedData2 = call func2 data
    Then print "User id at 4:", returnedData2
    ##################################################################################################
    * def abc =
      """
      {
      	id: '#number? _ > 0',
      	name: '#string',
      	country: '#string'
      }
      """
    * def validation = read('result.json')
    * match validation == '#[] abc'

  ####################################################################################################
  Scenario: GET operation to list a robber
    Given path endpoint2
    When method GET
    Then status 200

  ####################################################################################################
  Scenario: POST Operation to create a new robber
    Given path endpoint3
    And request {"id" : 6, "name" : "Helsinki", "country" : "Finland"}
    When method POST
    Then status 200
    * def data1 = response
    Then print "Response data:", data1
    And match data1 == {"id" : 6, "name" : "Helsinki", "country" : "Finland"}

  ####################################################################################################
  Scenario: PUT Operaiton to verify that the robbers information is successfully updated
    Given path endpoint4
    And request {"id" : 2, "name" : "Rio de Janeiro", "country" : "Brazil"}
    When method PUT
    Then status 200
    And print 'Updated response is:', response
    And match response == {"id" : 2, "name" : "Rio de Janeiro", "country" : "Brazil"}

  ####################################################################################################
  Scenario: DELETE Operation to verify that the robber information is successfully deleted
    Given path endpoint5
    When method DELETE
    Then status 200
