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

    @InvocableVariable(label='User ID - Determines whose Twilio account is used' required=false)
    global ID userId;

    @InvocableVariable(label='Fallback to Org defaults if the user ID has not configured their Twilio Account' required=false)
    global Boolean fallbackToOrgDefaults;
}