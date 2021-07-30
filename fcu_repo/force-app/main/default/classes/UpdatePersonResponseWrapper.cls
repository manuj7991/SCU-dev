public class UpdatePersonResponseWrapper {

	public class Errors {
		public Error Error;
	}

	public class Error {
		public String ErrorMessage;
		public String ErrorNumber;
	}

	public PersonMaintenanceResponse PersonMaintenanceResponse;

	public class PersonMaintenanceResponse {
		public Errors Errors;
		public String RequestTypeCode;
		public String WasSuccessful;
	}

	
	public static UpdatePersonResponseWrapper parse(String json) {
		return (UpdatePersonResponseWrapper) System.JSON.deserialize(json, UpdatePersonResponseWrapper.class);
	}
}