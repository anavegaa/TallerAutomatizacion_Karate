@appcontact_createcontact
Feature: create contact to app contact

  Background:
    * url baseUrl
    * header Accept = 'application/json'

  Scenario: Login y crear contacto
    # Login
    Given path '/users/login'
    And request { "email": "testeo12@gmail.com", "password": "testeo1234" }
    When method POST
    Then status 200
    * def authToken = response.token

    # Datos dinámicos para contacto
    * def randomEmail = 'user' + java.util.UUID.randomUUID() + '@test.com'
    * def contactoPayload =
    """
    {
      "firstName": "Christian",
      "lastName": "UDEA",
      "birthdate": "1970-01-01",
      "email": "#(randomEmail)",
      "phone": "8005555555",
      "street1": "1 Main St.",
      "street2": "Apartment A",
      "city": "Anytown",
      "stateProvince": "KS",
      "postalCode": "12345",
      "country": "USA"
    }
    """

    # Crear contacto
    Given path '/contacts'
    And header Authorization = 'Bearer ' + authToken
    And request contactoPayload
    When method POST
    Then status 201
    And match response ==
    """
    {
      "_id": "#string",
      "firstName": "#string",
      "lastName": "#string",
      "birthdate": "#string",
      "email": "#string",
      "phone": "#string",
      "street1": "#string",
      "street2": "#string",
      "city": "#string",
      "stateProvince": "#string",
      "postalCode": "#string",
      "country": "#string",
      "owner": "#string",
      "__v": "#number"
    }
    """
