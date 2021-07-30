public class SubmitOfferRequest{
	public cls_Request Request;
	class cls_Request {
		public string SessionID;	//edb8fa4f-1478-4c3d-9213-c85099d848c0
		public string MemberID;	//5555
		public string OfferID;	//3
		public string PresentationID;	//3
		public string ResponseCode;	//Yes
		public String Details;	//Call Consumer after 5 PM at 555-1212
		public cls_ContactDetails ContactDetails;
	}
	
    class cls_ContactDetails {
		public String Name;	//John Doe
		public String Address1;	//123 Street
		public String Address2;	//Apt 123
		public cls_Address3 Address3;
		public String City;	//Test City
		public String State;	//IL
		public String Zip;	//10001
		public String Phone;	//111-222-3333
		public String Email;	//test@test.com
	}
	class cls_Address3 {
	}
    
    
	public static SubmitOfferRequest parse(String json){
		return (SubmitOfferRequest) System.JSON.deserialize(json, SubmitOfferRequest.class);
	}
    public SubmitOfferRequest(){
    }
    
    public SubmitOfferRequest(Offer__c offer)
    {
        Request = new cls_Request();
        Request.SessionID = offer.Session_Id__c;
        
        Request.OfferId = offer.id__c;
        Request.PresentationID = offer.Presentation_Id__c;
        Request.ResponseCode = offer.Offer_Response__c;
        Request.Details = offer.Description__c;
        Request.ContactDetails = new cls_ContactDetails();
        Account acct = [Select Name, firstname, lastname, DNA_Cust_Key__c, PersonHomePhone, PersonEMail, PersonMailingStreet, PersonMailingCity, PersonMailingState, PersonMailingPostalCode, Work_Phone__c, Work_Email__C, Mailing_Street_Business__c, Mailing_City_Business__c, Mailing_State_Business__c, Mailing_Postal_Code_Business__c from account where Id =: offer.Account__c];
        Request.MemberID = acct.DNA_Cust_Key__c;
        if (acct.DNA_Cust_Key__c.contains('O')){
            Request.ContactDetails.Name = acct.Name;
            Request.ContactDetails.Address1 = acct.Mailing_Street_Business__c;
            Request.ContactDetails.City = acct.Mailing_City_Business__c;
            Request.ContactDetails.State = acct.Mailing_State_Business__c;
            Request.ContactDetails.Zip = acct.Mailing_Postal_Code_Business__c;
            Request.ContactDetails.Phone = acct.Work_Phone__c;
            Request.ContactDetails.Email = acct.Work_Email__C; 
        }
        else
        {
            Request.ContactDetails.Name = acct.FirstName + ' ' + acct.LastName;
            Request.ContactDetails.Address1 = acct.PersonMailingStreet;
            Request.ContactDetails.City = acct.PersonMailingCity;
            Request.ContactDetails.State = acct.PersonMailingState;
            Request.ContactDetails.Zip = acct.PersonMailingPostalCode;
            Request.ContactDetails.Phone = acct.PersonHomePhone;
            Request.ContactDetails.Email = acct.PersonEMail; 
        }
    }

    
	
}