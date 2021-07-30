@IsTest
public class UpdateBusinessResponseWrapper_Test {
	
	static testMethod void testParse() {
		String json = '{'+
		'    \"OrgMaintenanceResponse\": {'+
		'        \"Errors\": {'+
		'            \"Error\": {'+
		'                \"ErrorMessage\": \"Phone Area Code is invalid. Number must be 3 digits in length.\",'+
		'                \"ErrorNumber\": \"1001\",'+
        '                \"OraErrorMessage\":  \"Built-in Exceptions\"'+
		'            }'+
		'        },'+
		'        \"RequestTypeCode\": \"7707\",'+
		'        \"WasSuccessful\": \"false\"'+
		'    }'+
		'}';
		UpdateBusinessResponseWrapper obj = UpdateBusinessResponseWrapper.parse(json);
		System.assert(obj != null);
	}
}