/*
 * Copyright (c) 2018, salesforce.com, inc.
 * All rights reserved.
 * SPDX-License-Identifier: BSD-3-Clause
 * For full license text, see the LICENSE file in the repo root or https://opensource.org/licenses/BSD-3-Clause
 */
 
@IsTest
public with sharing class TwilioServiceCredentialsControllerTest {
    
    static testmethod void controllerTestMethod() {

        PageReference pageRef = Page.TwilioServiceCredentials;
        Test.setCurrentPage(pageRef);
        Test.startTest();

        User testUser = new user();
        testUser.Id = '0051h000005utiHAAQ';

        TwilioCredentials__c credsBefore = new TwilioCredentials__c();
        credsBefore.Name = testUser.Id;
        credsBefore.SetupOwnerId = testUser.Id;
        credsBefore.API_Key__c = 'OLD VALUE API KEY';
        credsBefore.API_Secret__c = 'OLD VALUE API SECRET';
        credsBefore.Outbound_Number__c = '1111111111';
        credsBefore.Account_Id__c = 'OLD VALUE ACCOUNT ID';
        insert credsBefore;

        TwilioServiceCredentialsController controller = new TwilioServiceCredentialsController();
        controller.APIKey = 'ABC123';
        controller.APISecret = 'XYZ123';
        controller.outboundNumber = '5555555555';
        controller.accountId = 'ABCDEF';
        controller.userId = testUser.Id;

        controller.saveCustomSettings();
        TwilioCredentials__c credsAfter = TwilioCredentials__c.getValues(testUser.Id);
        system.assertEquals('ABC123', credsAfter.API_Key__c);
        system.assertEquals('XYZ123', credsAfter.API_Secret__c);
        system.assertEquals('5555555555', credsAfter.Outbound_Number__c);
        system.assertEquals('ABCDEF', credsAfter.Account_Id__c);
        controller.cancelCustomSettings();
        Test.stopTest();

    }
}