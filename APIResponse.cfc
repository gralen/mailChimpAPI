component accessors=true {	
	property name="response" type="struct" setter="true";
	property name="status" type="numeric" setter="true";
	property name="statusTitle" type="string" setter="true";
	property name="statusString" type="string" setter="true";

	this.HTTP_TIMEOUT = 408;
	this.HTTP_TIMEOUT_TEXT = "Request Timeout";

	public function init(required Result result){
		var response= arguments.result.getPrefix();		
		try {
			setResponse( deserializeJSON(response.fileContent) );		
			setStatus(response.status_code);
			setStatusTitle(response.status_text);
			setStatusString(response.status_code & " " & response.status_text);
		}
		catch (any E){
			setResponse({});
			setStatus(this.HTTP_TIMEOUT);
			setStatusTitle(this.HTTP_TIMEOUT_TEXT);
			setStatusString(this.HTTP_TIMEOUT & " " & this.HTTP_TIMEOUT_TEXT);
		}		
		return this;
	}
	public boolean function isSuccessful(){
		if (getStatus() eq 200){
			return true;
		}
		return false;
	}
}