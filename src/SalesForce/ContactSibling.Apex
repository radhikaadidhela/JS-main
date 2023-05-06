trigger ContactTrigger on Contact (after insert) {
    if(trigger.isAfter==true && trigger.isInsert==true){
		ContactSiblingHandler.CountSibling(Trigger.New);
    }
}


public class ContactSiblingHandler {
    public static void CountSibling(List<Contact> VarContactList){
        
        system.debug(VarContactList+'contact List');

        Set<Id> AccountIds = New Set<Id>();
        
        for(Contact Con:VarContactList){
            if(Con.AccountId != Null){
                AccountIds.add(Con.AccountId);
            }           
        }
        
        List<Account> VarAccountList =[SELECT Id,Name,(SELECT Id FROM Contacts) FROM Account 
                                       WHERE Id IN:AccountIds];

        MAP<Id,Integer> VarAccountContactMap = New MAP<Id,Integer>();
        
        for(Account Acc:VarAccountList){
            Integer Count;
            if(Acc.Contacts.Size()>0){
               Count = Acc.Contacts.Size()-1;
            }else if(Acc.Contacts.Size()==0){
                Count = 0;
            }
            
            VarAccountContactMap.Put(Acc.Id,Count);
            
        }
        
        
        List<Contact> VarConList=[SELECT ID,Sibling_Count__c, AccountId FROM Contact 
                                  WHERE AccountId IN:VarAccountContactMap.keyset()];
        List<Contact> VarContacts= New List<Contact>();
        for(Contact Cont:VarConList){
            Cont.Sibling_Count__c = VarAccountContactMap.get(Cont.AccountId);
            VarContacts.add(Cont);
        }
        
        Update VarContacts;
        
        
        
        
        
    }

}

public class AccountHandler {
    public static void insertAccount(Integer newAccountnum){
        list<Account>addAccounts=new list<Account>();
        integer n=0;
        while(n<=newAccountnum){
            Account a=new Account();
            a.Name='Acme Inc' +n;
            a.AccountNumber='A000'+n;
            addAccounts.add(a);
            n++;
        }
        insert addAccounts;
    }
}


<apex:page controller="NameClass">
    <head>
        <meta charset="utf-8" />
	  <meta name="viewport" content="width=device-width, initial-scale=1" />
      <title>Quick Start: Visualforce</title>
      <!-- Import the Design System style sheet -->
      <apex:slds />
    </head>
    <body>
        <apex:form >
            <apex:pageBlock title="NameDetails">
            	<apex:pageBlockSection title="My Name Details Section" columns="1">
                    <apex:outputLabel >Enter First Name:</apex:outputLabel>
                    <apex:inputText value="{!FirstName}"/>
                    <apex:outputLabel >Enter Middle Name:</apex:outputLabel>
                    <apex:inputText value="{!MiddleName}"/>
                    <apex:outputLabel >Enter Last Name:</apex:outputLabel>
                    <apex:inputText value="{!LastName}"/>
                    
                </apex:pageBlockSection>
                <apex:pageBlockButtons >
                     
                    <apex:commandButton action="{!ShowFullName}" value="{!ShowFullName}"></apex:commandButton>
                </apex:pageBlockButtons>
                <apex:pageBlockButtons >
                   <apex:commandButton action="{!mysave}" value="Save"/>
                </apex:pageBlockButtons>
            
            </apex:pageBlock>
        </apex:form>
    </body>
</apex:page>

public with sharing class NameClass {
    public string ShowFullName{set;get;}
    public string FirstName{set;get;}
    public string MiddleName{set;get;}
    public string LastName{set;get;}
    public void ShowFullName(){
        ShowFullName = FirstName+MiddleName+LastName;
    }
    public void mySave(){
        List<EMP_NAME__c> varEmpName = new List<EMP_NAME__c>();
        
        EMP_NAME__c VarName = new EMP_NAME__c();
        VarName.LAST_NAME__c=LastName;
        VarName.Name=FirstName+' '+' '+MiddleName+' '+LastName;
        
        EMP_NAME__c VarName1 = new EMP_NAME__c();
        VarName1.LAST_NAME__c=LastName+' Test';
        VarName1.Name=FirstName+' '+' '+MiddleName+' '+LastName;
        
        varEmpName.add(VarName);
        varEmpName.add(VarName1);
        
        
        
        
        
       
        insert varEmpName;
    }
}


<apex:page standardcontroller="Contact"> 
    <head>
        
      <meta charset="utf-8" />
	  <meta name="viewport" content="width=device-width, initial-scale=1" />
      <title>Quick Start: Visualforce</title>
      <!-- Import the Design System style sheet -->
      <apex:slds />
     </head>
    <body> 
      <apex:form >
      <apex:pageBlock title="New Contact">
        <!--Buttons -->
         <apex:pageBlockButtons >
            <apex:commandButton action="{!save}" value="Save"/>
         </apex:pageBlockButtons>
         <!--Input form -->
          <apex:pageBlockSection columns="1">
             <apex:inputField value="{!Contact.Firstname}"/>
             <apex:inputField value="{!Contact.Lastname}"/>
             <apex:inputField value="{!Contact.Email}"/>
          </apex:pageBlockSection>
        </apex:pageBlock>
        </apex:form>
     </body>
</apex:page>

<apex:page showHeader="false">
    <h1>
        DisplayImage
    </h1>
    <apex:image url="https://developer.salesforce.com/files/salesforce-developer-network-logo.png" title="Display Image"/>
</apex:page>

<apex:page >
    <apex:pageBlock title="User Status">
        <apex:pageBlockSection columns="1">
        	{!$User.FirstName} {!$User.FirstName}
        	{!$User.UserName}
        </apex:pageBlockSection>
    </apex:pageBlock>
</apex:page>

<apex:page standardController="Contact" recordSetVar="contacts">
    <apex:form>
        <apex:pageBlock title="Contacts List" id="contacts_list">
            Filter:
            <apex:selectList value="{! filterId }" size="1">
                <apex:selectOptions value="{! listViewOptions }"/>
                <apex:actionSupport event="onchange" reRender="contacts_list"/>
            </apex:selectList>
            <!-- Contacts List -->
            <apex:pageBlockTable value="{! contacts }" var="ct">
                <apex:column value="{! ct.FirstName }"/>
                <apex:column value="{! ct.LastName }"/>
                <apex:column value="{! ct.Email }"/>
                <apex:column value="{! ct.Account.Name }"/>
            </apex:pageBlockTable>
        </apex:pageBlock>
    </apex:form>
</apex:page>

//visualforce page custom controller

public class NewCaseListController {

    public List<Case> getNewCases() {
        List<Case> results = Database.query(
            'SELECT Id, CaseNumber, Status ' +
            'FROM Case ' +
            'WHERE Status = \'New\' '
        );
   
    return results;
    }

}

public class NewCaseListController {

    public List<Case> getNewCases() {
        List<Case> results = Database.query(
            'SELECT Id, CaseNumber, Status ' +
            'FROM Case ' +
            'WHERE Status = \'New\' '
        );
   
    return results;
    }

}

<apex:page >
    <apex:image url="{!URLFOR($Resource.vfimagetest,'cats/kitten1.jpg')}"/>
</apex:page>