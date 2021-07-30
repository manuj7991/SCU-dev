@isTest
public class SubmitOfferResponseTest {

    
	static testMethod void testParse() {
		String json=		'{'+
		'   "SendOfferReplyResult": {'+
		'     '+
		'      "MemberID": "5555",'+
		'      "SessionID": "edb8fa4f-1478-4c3d-9213-c85099d848c0",'+
		'      "Status": {'+
		'         "StatusCode": "0",'+
		'         "ServerStatusCode": "Summit",'+
		'         "Severity": "Info",'+
		'         "StatusDesc": "Success."'+
		'      },'+
		'      "FulfillmentsRan": {'+
		'         "Fulfillment": {'+
		'            "ID": "3",'+
		'            "Name": "Member Service Email",'+
		'            "Status": {'+
		'               "StatusCode": "0",'+
		'               "ServerStatusCode": "Summit",'+
		'               "Severity": "Info",'+
		'               "StatusDesc": "Success."'+
		'            }'+
		'         }'+
		'      }'+
		'   }'+
		'}';
		SubmitOfferResponse obj = SubmitOfferResponse.parse(json);
		System.assert(obj != null);
	}
	
}