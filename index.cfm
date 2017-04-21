<cfscript>
	mc = new MailchimpAPI(			apiKey=Application.mailchimpAPIkey,
									serviceURL=Application.mailchimpUrl,
									httpTimeout=10);

	/*members = mc.getListMembers(	listId=Application.mailchimpListId,
									debug=false);

	member = mc.getMember(	listId=Application.mailchimpListId,
							memberHash="e19e1a5ce42a920d9eba2360858e0ff1",
							debug=true
						);
*/
	/*if (isObject(member)){
		dump(var="#checkMember#", expand=true, keys=10, label="Dump at line 12",format="simple");
	}*/

	newMember = mc.addMember(	listId=Application.mailchimpListId,
								email="jonathan.gralen@gmail.com"
								mergeFields={
									FNAME: "Jonathan", 
        							LNAME: "Smith"
								}
							);
	if (newMember.getStatus() eq 400){
		writeOutput("Already existed");
	}
	if (newMember.isSuccessful()){
		writeOutput("OK");
	}
	if (newMember.getStatus() eq 408){
		writeOutput("Request Timed Out");
	}

	writeDump(var="#newMember.getResponse()#");
</cfscript>