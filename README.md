# SMS for Flow

SMS for Flow provides the ability for users to send SMS messages via Flow and Process Builder using the Twilio Messaging API.  Easily drag and drop these invocable Apex methods into a flow to send case status updates, order delivery updates, or appointment confirmations to your customers. This requires your own Twilio account.

## Installation

This package requires some post-installation configuration. These steps have been captured in the 'SMS for Flows Implementation and User Guide'.

## Documentation

- [AppExchange Listing](https://appexchange.salesforce.com/appxListingDetail?listingId=a0N3A00000FeF9YUAV)
- [SMS for Flows Implementation and User Guide](https://appexchange.salesforce.com/servlet/servlet.FileDownload?file=00P3A00000gAwX0UAK)

---

## Salesforce Packaging

Created PHY3

- This is my 'Packaging Org' which is where the namespace is registered
- Did NOT enable Dev Hub
- Registered the namespace `SetGoTwilioTest`: <https://developer.salesforce.com/docs/atlas.en-us.sfdx_dev.meta/sfdx_dev/sfdx_dev_dev2gp_create_namespace.htm>

Then from the Dev Hub Org I link the namespace. When you get the popup to login you use the credentials from the Packaging Org.

```bash
sfdx force:project:create --outputdir expense-manager-workspace --projectname expenser-app --defaultpackagedir source-folder

sfdx force:project:create --outputdir . --projectname expenser-app2 --defaultpackagedir source-folder
```

FlowSMSLab namesace prefix: `flowsmslab`
I'll use: `setgosmsforflow`

Log into Dev Hub

- `sfdx auth:web:login -d -a Phy2-DevHub`
- `sfdx auth:web:login -a Phy3`
- > Successfully authorized whenke@phy.com with org ID 00D4x000005RG77EAG
- `-d` is for default hub
- `-a` will then also set an alias

Example commands

- Open the DevHub: `sfdx force:org:open -u Phy2-DevHub`
- `sfdx force:limits:api:display -u Phy2-DevHub`
- `sfdx force:org:list --verbose --all`

Create a scratch org

- `sfdx force:org:create -s -f config/project-scratch-def.json`
- `sfdx force:org:create -s -f config/project-scratch-def.json`
- `sfdx force:org:create edition=Developer -s -a MyScratchOrg -v PHY2-Dev-ED`

Open the scratch org in the browser

- `sfdx force:org:open -u MyScratchOrg`

---

## TODO Move these docs to my Salesforce docs project

```bash
# Example retrieving metadata from an org
sfdx force:mdapi:retrieve -s -r ./metadata -u <some alias here> -p FlowSMSLab
# Example converting metadata to source format
sfdx force:mdapi:convert --rootdir ./metadata --outputdir ./force-app
```

- `sfdx force:source:convert --outputdir SetGoTwilioTest --packagename SetGoTwilioTest`
- `sfdx force:mdapi:deploy --deploydir SetGoTwilioTest -u Phy3`
- `sfdx force:mdapi:deploy:report -u Phy3 -i 0Af5Y000005rkMaSAI`
  - The alias is needed since this isn't the default but the job id isn't normally needed since the latest job id is cached locally and used if omitted

---

Issues pulling source

- <https://github.com/forcedotcom/cli/issues/205>
- Adding `AppBrand.app` to .forceignore did work

Ok, just going to delete this scratch org and retry

- `sfdx force:org:delete -u MyScratchOrg`
- `sfdx force:org:create edition=Developer -s -a MyScratchOrg -v PHY2-Dev-ED`
- `sfdx force:org:open -u MyScratchOrg`
- `sfdx force:source:push -u MyScratchOrg --loglevel trace`
- `sfdx force:source:status`
- `sfdx force:source:pull -u MyScratchOrg --loglevel trace`

Convert from source format to metadata format and deploy to the 'Packaging Org' (Phy3)

- `sfdx force:source:convert --outputdir SetGoTwilioTest --packagename SetGoTwilioTest`
- `sfdx force:mdapi:deploy --deploydir SetGoTwilioTest -u Phy3`
- `sfdx force:mdapi:deploy:report -u Phy3 -i 0Af5Y000005rkMaSAI`
  - The alias is needed since this isn't the default but the job id isn't normally needed since the latest job id is cached locally and used if omitted

---

Random

- Set scratch org user password: `sfdx force:user:password:generate -u MyScratchOrg`
  - Then can see login url with: `sfdx force:user:display`
- This might be easier than I thought, the Twilio configs are stored in a Hierarchal Custom Setting which means it can be set per org, profile, or user. The more specific value takes precedence
  - <https://help.salesforce.com/articleView?id=sf.cs_define.htm&type=5>
  - Might not have to edit the Twilio SMS Flow page, these custom settings can be set from: `Setup -> Custom Code -> Custom Settings`
    - Click 'Manage' and then you can set values for a user, profile, or Default Organization Level
    - If a user doesn't have a field set it will use a value from either a profile or the org default
- Apex code to test

  ```java
  User testUser = [SELECT Id FROM User WHERE Id = '0051h000005utiHAAQ'];
  System.debug('Test User: ' + testUser);

  TwilioCredentials__c orgDefaultCreds = TwilioCredentials__c.getOrgDefaults();
  System.debug('Twilio - Org Default Account Id: ' + orgDefaultCreds.SetGoTwilioTest__Account_Id__c);
  System.debug('Twilio Creds - Org Default API Key: ' + orgDefaultCreds.SetGoTwilioTest__API_Key__c);
  System.debug('Twilio Creds - Org Default API Secret: ' + orgDefaultCreds.SetGoTwilioTest__API_Secret__c);
  System.debug('Twilio Creds - Org Default Outbound Number: ' + orgDefaultCreds.SetGoTwilioTest__Outbound_Number__c);

  TwilioCredentials__c userCreds = TwilioCredentials__c.getInstance(testUser.Id);
  System.debug('Twilio - User Account Id: ' + userCreds.SetGoTwilioTest__Account_Id__c);
  System.debug('Twilio - User API Key: ' + userCreds.SetGoTwilioTest__API_Key__c);
  System.debug('Twilio - User API Secret: ' + userCreds.SetGoTwilioTest__API_Secret__c);
  System.debug('Twilio - User Outbound Number: ' + userCreds.SetGoTwilioTest__Outbound_Number__c);
  ```

Manual changes needed after install (todo make this not manual)

- Update System Administrator Profile: `Custom Tab Settings -> Flow SMS Setup = Default On`
