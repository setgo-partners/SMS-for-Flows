/*
 * Copyright (c) 2018, salesforce.com, inc.
 * All rights reserved.
 * SPDX-License-Identifier: BSD-3-Clause
 * For full license text, see the LICENSE file in the repo root or https://opensource.org/licenses/BSD-3-Clause
 */
 
global with sharing class TwilioMessage {
    @invocableVariable
    global String toNumber;
    
    @invocableVariable
    global String messageBody;

    // TODO - Add a description
    @InvocableVariable(label='User ID with Twilio Custom Settings' required=false description='User ID with Twilio Custom Settings - TODO finish this')
    global ID userId;

    // TODO - Add a description
    @InvocableVariable(label='Fallback To Org Defaults' required=false description='TODO')
    global Boolean fallbackToOrgDefaults;
}