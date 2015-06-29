/**
*
* @file  /C/inetpub/wwwroot/cfPlayground.local/wwwroot/mailchimp/APIHelpers.cfc
* @author  
* @description
*
*/

component accessors=true {
	property name="serviceURL" type="string" setter="true";
	property name="apiKey" type="string" setter="true";
	property name="httpTimeout" type="numeric" setter="true";

	public function init(){
		return this;
	}
	private struct function apiCall(required string RESTEndPoint,required string method,struct requestBody,boolean debug){
		var loc={};		
		loc.httpRequest = new http(	url="#getServiceURL()#/#arguments.RESTEndPoint#",
									method=arguments.method,
									timeout=getHttpTimeout()
									);

		loc.httpRequest.addParam(type="header",name="Authorization", value="apikey #getApiKey()#");
		if (arguments.method eq "POST" or arguments.method eq "PUT"){
			loc.httpRequest.addParam(type="body", value=SerializeJSON(Arguments.requestBody));
		}
		loc.result = loc.httpRequest.send(); // Execution suspended until timeout or success
		loc.errorLabel="Your #Arguments.method# request for the REST API Endpoint: #Arguments.RESTEndPoint# failed with: #loc.result.getPrefix().errordetail#";

		if ( isRequestTimeout( loc.result ) ){
			if (Arguments.debug){
				writeDump(var=loc.result.getPrefix(),label=loc.errorLabel);
			}
			throw(message="HTTP Error #loc.result.getPrefix().statuscode#",detail="ERROR: #loc.errorLabel#");
		}
		return deserializeJSON(loc.result.getPrefix().filecontent);
	}
	private void function writeDebugOutput(httpResult){
		writeOutputLn("Error Detail: " & arguments.httpResult.errordetail );	
		writeOutputLn("STATUS CODE: " & arguments.httpResult.statuscode );
		writeOutputLn("RESP:");
		writeDump(deserializeJSON(arguments.httpResult.filecontent));
	}
	private void function writeOutputLn(any t){
		writeOutput(t & "<BR>");
	}
	private boolean function isRequestSuccesful(httpResult:org.railo.cfml.Result){
		if ( Val(arguments.httpResult.getPrefix().statuscode) eq 200 ){
			return true;
		}
		return false;
	}
	private boolean function isRequestTimeout(httpResult:org.railo.cfml.Result){
		if ( Val(arguments.httpResult.getPrefix().statuscode) eq 408 ){
			return true;
		}
		return false;
	}
}