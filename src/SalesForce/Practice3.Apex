
//Declare the var of type set
set<string> VarProdCodeSet= new set<string>();
system.debug('The Current set'+VarProdCodeSet);
VarProdCodeSet.add('X24c');
VarProdCodeSet.add('x33b');
VarProdCodeSet.add('x34b');
VarProdCodeSet.add('x35b');
system.debug('The Current set'+VarProdCodeSet);

//clear
//VarProdCodeSet.clear();
system.debug('The Current set'+VarProdCodeSet);

boolean VarCode;
VarCode=VarProdCodeSet.contains('p456');
system.debug('The value contains p456: '+VarCode);

//Remove
VarProdCodeSet.remove('x33b');
system.debug('The Current set'+VarProdCodeSet);

//size
system.debug('The Current set '+VarProdCodeSet.size());

//Set to Store Bank Acc 
set<integer> VarAccNumSet= New set<integer>();
VarAccNumSet.add(12245);
VarAccNumSet.add(22456);
VarAccNumSet.add(12246);
VarAccNumSet.add(13245);

set<string> VarEmailSet= New set<string>();
VarEmailSet.add('radhika@ads.com');
VarEmailSet.add('radhika1@ads.com');
VarEmailSet.add('radhika2@ads.com');
VarEmailSet.add('radhika3@ads.com');
VarEmailSet.add('radhika4@ads.com');
VarEmailSet.add('radhika6@ads.com');
VarEmailSet.add('radhika9@ads.com');
VarEmailSet.add('radhika7@ads.com');
VarEmailSet.add('radhika5@ads.com');
VarEmailSet.add('radhika8@ads.com');
for(string Varem:VarEmailSet){
    system.debug('The string values: '+Varem);
}
//Map
map<string,integer> VarPhoneType= new map<string,integer>();
system.debug('The values in Map:  '+VarPhoneType);
VarPhoneType.put('Iphone x',70000);
VarPhoneType.put('Nokia 22',50000);
VarPhoneType.put('Samsung Galaxy',60000);
VarPhoneType.put('Iphone XS',60000);
system.debug('The values in Map:  '+VarPhoneType);

//clear 
VarPhoneType.clear();
system.debug('The values in Map: '+VarPhoneType);

VarPhoneType.put('Iphone x',70000);
VarPhoneType.put('Nokia 22',50000);
VarPhoneType.put('Samsung Galaxy',60000);
VarPhoneType.put('Iphone XS',60000);

//size
system.debug('The size of Map:  '+VarPhoneType.size());
VarPhoneType.clear();

integer Varsize=VarPhoneType.size();

//Map
map<string,string> VarCurrencyType= new map<string,string>();
VarCurrencyType.put('USA','USD');
VarCurrencyType.put('india','inr');
VarCurrencyType.put('uk','');

String VarVal=VarCurrencyType.get('india');
system.debug('The VarVal:  '+VarVal);

system.debug('The size of Map:  '+VarCurrencyType);

//Keyset()
Set<string> VarKeys =VarCurrencyType.keyset();

//Values()
List<String> currencyVals = VarCurrencyType.values();
system.debug('The currency type values in Map:  '+currencyVals);

system.debug('The VarKeys:  '+VarKeys);


//Declare the var of type set
set<string> VarProdCodeSet= new set<string>();
system.debug('The Current set'+VarProdCodeSet);
VarProdCodeSet.add('X24c');
VarProdCodeSet.add('x33b');
VarProdCodeSet.add('x34b');
VarProdCodeSet.add('x35b');
system.debug('The Current set'+VarProdCodeSet);

//clear
//VarProdCodeSet.clear();
system.debug('The Current set'+VarProdCodeSet);

boolean VarCode;
VarCode=VarProdCodeSet.contains('p456');
system.debug('The value contains p456: '+VarCode);

//Remove
VarProdCodeSet.remove('x33b');
system.debug('The Current set'+VarProdCodeSet);

//size
system.debug('The Current set'+VarProdCodeSet.size());
boolean isEmpty = VarProdCodeSet.isEmpty();
system.debug('Map isEmpty check '+isEmpty);


map<integer,String> VarNameType= new map<integer,String>();
system.debug('The values in Map:  '+VarNameType);
VarNameType.put(1,'Iphone x');
VarNameType.put(2,'Nokia 22');
VarNameType.put(3,'Samsung Galaxy');
VarNameType.put(4,'Iphone');
system.debug('The values in Map:  '+VarNameType);

for(integer varKey:VarNameType.keySet()){
    system.debug('My key is:'+varKey);
    system.debug('My Map Value is'+VarNameType.get(varKey));
}


//Declare the var of type set
set<string> VarProdCodeSet= new set<string>();
system.debug('The Current set'+VarProdCodeSet);
VarProdCodeSet.add('X24c');
VarProdCodeSet.add('x33b');
VarProdCodeSet.add('x34b');
VarProdCodeSet.add('x35b');
system.debug('The Current set'+VarProdCodeSet);

//clear
//VarProdCodeSet.clear();
system.debug('The Current set'+VarProdCodeSet);

boolean VarCode;
VarCode=VarProdCodeSet.contains('p456');
system.debug('The value contains p456: '+VarCode);

//Remove
VarProdCodeSet.remove('x33b');
system.debug('The Current set'+VarProdCodeSet);

//size
system.debug('The Current set'+VarProdCodeSet.size());
boolean isEmpty = VarProdCodeSet.isEmpty();
system.debug('Map isEmpty check '+isEmpty);

List<String> VarListStr = new List<string>();
VarListStr.add('radh');
VarListStr.add('Mah');

for(String name:VarListStr){
    system.debug(name);
}


map<integer,String> VarNameType= new map<integer,String>();
system.debug('The values in Map:  '+VarNameType);
VarNameType.put(1,'Iphone x');
VarNameType.put(2,'Nokia 22');
VarNameType.put(3,'Samsung Galaxy');
VarNameType.put(4,'Iphone');
system.debug('The values in Map:  '+VarNameType);
set<integer> VarKeys= VarNameType.keySet();
for(integer varKey:VarKeys){
    system.debug('My key is:'+varKey);
    system.debug('My Map Value is'+VarNameType.get(varKey));
}

list<string> VarNameList= New list<string>();
VarNameList.add('Mahi');
VarNameList.add('Radhi');
VarNameList.add('Hardhik');
VarNameList.add('Aadhya');
VarNameList.add('Aadhya');
for(string VarName:VarNameList){
    system.debug('Name in the list: '+VarName);
}

set<string> VarNameSet=New set<string>();
VarNameSet.add('Mahi');
VarNameSet.add('Radhi');
VarNameSet.add('Hardhik');
VarNameSet.add('Aadhya');
VarNameSet.add('Aadhya');
for(string VarName:VarNameSet){
    system.debug('Names in set: '+VarName);
}

map<integer,string> VarNameMap=New map<integer,string>();
VarNameMap.put(42,'Mahi');
VarNameMap.put(37,'Radhi');
VarNameMap.put(11,'Hardhik');
VarNameMap.put(5,'Aadhya');

list<string> VarValuesList=VarNameMap.values();
for(string VarValue:VarValuesList){
    system.debug('Value from list: '+VarValue);
    //system.debug('Keys from map: '+VarNameMap.get(VarValue));
}

set<integer> VarKeyValueSet=VarNameMap.keySet();
for(integer ValueKey:VarKeyValueSet){
    system.debug('Key from set: '+ValueKey);
   system.debug('value of Key from map: '+VarNameMap.get(ValueKey));
}


public class AccountHandler {
    public static void insertAccount(Integer newAccountnum){
        list<Account>addAccounts=new list<Account>();
        integer n=0;
        while(n<=newAccountnum){
            Account a=new Account();
            a.Name='Acme Inc' +n;
            a.AccountNumber='A0'+n;
            addAccounts.add(a);
            n++;
        }
        insert addAccounts;
    }
}


AccountHandler.insertAccount(6);


Trigger ContactAddressUpdate on Account(before insert){
    for(Account acc:Trigger.New){
        List<Contact> contacts =[SELECT Id
                                  FROM contacts
                                  WHERE ACCOUNTID=: acc.Id];
        for(Contact con : Contacts){
            con.MailingStreet = acc.BillingStreet;
            con.MailingCity   = acc.BillingCity;
            con.MailingState   = acc.BillingState;
            con.MailingCountry  = acc.BillingCountry;
            con.MailingPostalCode   = acc.BillingPostalCode;
        }
        Update Contacts;
    }

}



public class AccountUtility {
    public static void viewAnnualRevenue(){
        List<Account> accountsList = [SELECT Name,AnnualRevenue
                                      FROM Account];
        for (Account acc:accountsList){
            string acctRev =acc.Name+ ' : '+acc.AnnualRevenue;
            system.debug(acctRev);
        } 
    }
}

public class PropertyUtility {
    public static void newListedProperties(){
        List<Property__c> newPropList =[SELECT Name,Broker__r.Email__c, Days_On_Market__c  
                                     FROM Property__c 
                                     WHERE Days_On_Market__c<=30];
        for(Property__c prop:newPropList){
            string propEmail = prop.Name+' : '+prop.Broker__r.Email__c;
            system.debug(propEmail);
        }
        
    }

}

SELECT MAX(Salary__c) 
FROM Employee__c

SELECT AVG(Salary__c) 
FROM Employee__c


SELECT Salary__c
FROM Employee__c
WHERE Salary__c>1000

SELECT COUNT()
FROM Employee__c

SELECT COUNT(Salary__c)
FROM Employee__c

SELECT COUNT_DISTINCT(Salary__c)
FROM Employee__c

SELECT Name
FROM Employee__c
ORDER BY Experience__c
LIMIT 3

SELECT Name,CreatedDate
FROM User
ORDER BY CreatedDate Desc
LIMIT 2



SELECT Name,CreatedDate
FROM User
WHERE Name LIKE 'ROB DA___'

SELECT Name,CreatedDate
FROM User
WHERE Name LIKE 'ROB DA___'

SELECT Industry, Rating
FROM Account WHERE Industry = 'Banking' OR Rating='Hot'

SELECT Name, Phone
FROM Contact WHERE Name LIKE '%Reddy'

SELECT Name, Phone
FROM Contact WHERE Name LIKE 'Ra% _eddy'

SELECT Name,Industry, Rating, NumberOfEmployees, Website
FROM Account 
WHERE (Industry = 'Finance' AND Rating='Hot' AND NumberOfEmployees>10000) OR (Website LIKE '%.com' AND Industry = 'Finance') 