public class UpdateBusinessResponseWrapper {

	public class Errors {
		public Error Error;
	}

	public OrgMaintenanceResponse OrgMaintenanceResponse;

	public class OrgMaintenanceResponse {
		public Errors Errors;
		public String RequestTypeCode;
		public String WasSuccessful;
	}

	public class Error {
		public String ErrorMessage;
		public String ErrorNumber;
		public String OraErrorMessage;
	}

    public UpdateBusinessResponseWrapper(){}
    
	public static UpdateBusinessResponseWrapper parse(String json) {
		return (UpdateBusinessResponseWrapper) System.JSON.deserialize(json, UpdateBusinessResponseWrapper.class);
	}
}