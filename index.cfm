<cfscript>
	mc = new MailchimpAPI(apiKey=Application.mailchimpAPIkey,serviceURL=Application.mailchimpUrl);
	members = mc.getListMembers(listId=Application.mailchimpListId,debug=false);
	writeDump(var="#members#");
</cfscript>