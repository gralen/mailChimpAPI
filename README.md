# MailChimp v3 API Wrapper for Coldfusion (Railo 4.x, Lucee 5)

This a bare-bones wrapper for the MailChimp API v3 ( REST ). Since the v3 api is REST based, the implementation should be really straight forward ( like one line of code per api call. See MailChimpAPI.cfc )

Please take a look at MailChimpAPI.cfc to see which REST endpoints have been implemented.


### Sample usage
```
mc = new MailchimpAPI(		apiKey="PutYourAPIKEYHere", 									
							serviceURL="https://<dc>.api.mailchimp.com/3.0/");

members = mc.getListMembers(listId="MailListIDHere",debug=false);
writeDump(var="#members#");

newMember = mc.addMember(	listId=Application.mailchimpListId,
							email="sampleEmailAddress@gmail.com",
							status=mc.STATUS_SUBSCRIBED,
							mergeFields={
								"FNAME": "John", 
    							"LNAME": "Smith"
							},
							debug=true
						);
if (newMember.status eq 400){
	writeOutput("Already existed");
}
else {
	writeOutput("OK. It was added.");
}

```

### For more details see
http://kb.mailchimp.com/api/article/api-3-overview