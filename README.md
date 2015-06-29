# MailChimp v3 API Wrapper for Coldfusion (Railo 4.x, Lucee 5)

This a bare-bones wrapper for the MailChimp API v3 ( REST ). Since the v3 api is REST based, the implementation should be really straight forward ( like one line of code per api call. See MailChimpAPI.cfc )

As it currently stands, only one API endpoint has been added.

### Sample usage
```
mc = new MailchimpAPI(	apiKey="PutYourAPIKEYHere", serviceURL="https://<dc>.api.mailchimp.com/3.0/");
members = mc.getListMembers(listId="MailListIDHere",debug=false);
writeDump(var="#members#");
```
### For more details see
http://kb.mailchimp.com/api/article/api-3-overview
