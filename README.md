# MailChimp v3 API Wrapper for Coldfusion (Railo 4.x, Lucee 5)

This a bare-bones wrapper for the MailChimp API v3 ( REST ). Since the v3 api is REST based, the implementation should be really straight forward ( like one line of code per api call. See MailChimpAPI.cfc )

Please take a look at MailChimpAPI.cfc to see which REST endpoints have been implemented.


### Sample Usage

*Instantiate*
```
mc = new MailchimpAPI(		apiKey="PutYourAPIKEYHere", 									
							serviceURL="https://<dc>.api.mailchimp.com/3.0/",
							httpTimeout=3);
```
*Get Lists*
```
lists = mc.getLists();
```

*Get List Members*
```
listMembers = mc.getListMembers(listId="MailListIDHere");
```

*Add a List Member*
```
newMember = mc.addMember(	listId="MailListIDHere",
							email="sampleEmailAddress@gmail.com",							
							mergeFields={
								FNAME: "John", 
    							LNAME: "Smith",
    							FAVCOLOR: "Red"
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
```

*Update a List Member*
```
member = mc.getMember( 	listId="MailListIDHere",
						email="sampleEmailAddress@gmail.com" );

if (member.getStatus() eq 200){
	updateMember = mc.updateMember(	listId="MailListIDHere",
									email="sampleEmailAddress@gmail.com",							
									mergeFields={
    									FAVCOLOR: "Green" 							
									}
								}
}
```
### For more details see
http://kb.mailchimp.com/api/article/api-3-overview