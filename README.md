# SMS for Flow

SMS for Flow provides the ability for users to send SMS messages via Flow and Process Builder using the Twilio Messaging API.  Easily drag and drop these invocable Apex methods into a flow to send case status updates, order delivery updates, or appointment confirmations to your customers. This requires your own Twilio account.

## Installation

This package requires some post-installation configuration. These steps have been captured in the 'SMS for Flows Implementation and User Guide'.

## Documentation

- [AppExchange Listing](https://appexchange.salesforce.com/appxListingDetail?listingId=a0N3A00000FeF9YUAV)
- [SMS for Flows Implementation and User Guide](https://appexchange.salesforce.com/servlet/servlet.FileDownload?file=00P3A00000gAwX0UAK)

---

## Salesforce Packaging

A packaging org is a Developer Edition org configured with a managed package namespace. The packaging org is where new versions of the package are created. Every managed package has one and only one packaging org.

- So basically I think I have...
  - One Org set as the Dev Hub Org (this needs to be enabled)
    - This is likely a Dev Org but watch out for API/version restrictions?
  - Then I create a separate Dev Org as the 'Packaging Org'
    - This is where I create the namespace and push changes to

Created PHY3

- This is my 'Packaging Org' which is where the namespace is registered
- Did NOT enable Dev Hub
- Registered the namespace `SetGoTwilioTest`: <https://developer.salesforce.com/docs/atlas.en-us.sfdx_dev.meta/sfdx_dev/sfdx_dev_dev2gp_create_namespace.htm>

Then from the Dev Hub Org I link the namespace. When you get the popup to login you use the credentials from the Packaging Org.

Packaging Useful Links

- [Link a Namespace to a Dev Hub Org](https://help.salesforce.com/articleView?id=sf.sfdx_dev_reg_namespace.htm)

```bash
sfdx force:project:create --outputdir expense-manager-workspace --projectname expenser-app --defaultpackagedir source-folder

sfdx force:project:create --outputdir . --projectname expenser-app2 --defaultpackagedir source-folder

sfdx force:org:open --targetusername whenke@phy.com --path lightning/setup/Package/home
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

TODO

- From /Workspace/
  - `sfdx force:project:create -n SMS-for-Flows`
- Kept the existing folder structure

`sfdx force:source:push`

`sfdx force:package:install -p 04t46000001DnYm -w 3`

```bash
# Example retrieving metadata from an org
sfdx force:mdapi:retrieve -s -r ./metadata -u <some alias here> -p FlowSMSLab
# Example converting metadata to source format
sfdx force:mdapi:convert --rootdir ./metadata --outputdir ./force-app
```

Push source code to scratch org: `sfdx force:source:push -u MyScratchOrg --loglevel trace`

Had to open: `Setup -> Apps -> App Manager` and edit the Lightning enabled Sales app `App Settings -> Navigation Items` and add Flow SMS Setup
  I un did this
Nevermind this didn't help. From App Manager I had to create a new app and select the visual force page
Then updated the System Administrator profile. Enable Custom Tab Setting for Flow SMS Setup

Pull source code from scratch org: ``

Seems like...

- Make changes to source files locally
- Push source code to scratch org
- Then pull meta data and push that to the packaging org?
