public class SubmitOfferResponse{
	public cls_SendOfferReplyResult SendOfferReplyResult;
	public class cls_SendOfferReplyResult {
		public String MemberID;	//5555
		public String SessionID;	//edb8fa4f-1478-4c3d-9213-c85099d848c0
		public cls_Status Status;
		public cls_FulfillmentsRan FulfillmentsRan;
	}
	public class cls_Status {
		public String StatusCode;	//0
		public String ServerStatusCode;	//Summit
		public String Severity;	//Info
		public String StatusDesc;	//Success.
	}
	public class cls_FulfillmentsRan {
		public cls_Fulfillment Fulfillment;
	}
	public class cls_Fulfillment {
		public String ID;	//3
		public String Name;	//Member Service Email
		public cls_Status Status;
	}
	public static SubmitOfferResponse parse(String json){
		return (SubmitOfferResponse) System.JSON.deserialize(json, SubmitOfferResponse.class);
	}

    /*
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
		SubmitOfferResponse obj = parse(json);
		System.assert(obj != null);
	}
	*/
}