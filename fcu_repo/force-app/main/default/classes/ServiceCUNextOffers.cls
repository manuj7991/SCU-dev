public class ServiceCUNextOffers {

	public class Status {
		public String StatusCode;
		public String ServerStatusCode;
		public String Severity;
		public String StatusDesc;
	}

	public GetOffersResult GetOffersResult;

	public class ComplexPresentation_Z {
		public String ID;
		public String Name;
		public String Description;
		public String Content;
		public String Separator;
		public String ResponseRequired;
		public String ResponseCodeCount;
		public DisplayWindow DisplayWindow;
		public String ImageURL;
		public String BriefDescription;
		public String ResponsePageURL;
		public String Script;
		public String ExtraContent;
		public String MoreInformationURL;
		public Responses Responses;
		public String IsPriority;
	}

	public class ComplexPresentation {
		public String ID;
		public String Name;
		public String Description;
		public String Content;
		public String Separator;
		public String ResponseRequired;
		public String ResponseCodeCount;
		public DisplayWindow DisplayWindow;
		public String ImageURL;
		public String BriefDescription;
		public String ResponsePageURL;
		public String Script;
		public String ExtraContent;
		public String MoreInformationURL;
		public Responses Responses;
		public String IsPriority;
	}

	public class Offer {
		public String ID;
		public String Name;
		public String Description;
		public String Type;
		public String Category;
		public String StartDate;
		public String EndDate;
		public ComplexPresentation ComplexPresentation;
	}

	public class OfferResponse {
		public String Code;
		public String LogicalCode;
		public String Description;
	public String AfterResponseURL;
		public String TargetURL;
	}

	public class DisplayWindow {
		public String X;
		public String Y;
		public String Width;
		public String Height;
	}

	public class GetOffersResult {
		public String MemberID;
		public String SessionID;
		public Status Status;
		public Offers Offers;
	}

	public class Offers {
		public List<Offer> Offer;
	}

	public class Responses {
		public List<OfferResponse> OfferResponse;
	}

}