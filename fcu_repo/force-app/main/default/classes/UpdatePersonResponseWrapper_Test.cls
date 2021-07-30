@IsTest
public class UpdatePersonResponseWrapper_Test {
	
	static testMethod void testParse() {
		String json = '{'+
		'    \"PersonMaintenanceResponse\": {'+
		'        \"Errors\": {'+
		'            \"Error\": {'+
		'                \"ErrorMessage\": \"Phone Area Code is invalid. Number must be 3 digits in length.\",'+
		'                \"ErrorNumber\": \"1001\"'+
		'            }'+
		'        },'+
		'        \"RequestTypeCode\": \"7707\",'+
		'        \"WasSuccessful\": \"false\"'+
		'    }'+
		'}';
		UpdatePersonResponseWrapper obj = UpdatePersonResponseWrapper.parse(json);
		System.assert(obj != null);
	}
}