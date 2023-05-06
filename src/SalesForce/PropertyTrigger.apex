Trigger PropertyTrigger on Property__c (before insert,before update) {

    //trigger.new == 
    List<Property__c> listOfoBJS = NEW list<Property__c>();
    for(Property__c varName:listofobjs){

    }

    for(Property__c prop:trigger.new){       
        //if(ISPICKVAL(prop.type__c,"Row house")){
         if(prop.Type__c=='Row house'){   
            prop.Price__c = prop.Price__c-0.05*prop.Price__c;    
        }
    }
}

Trigger ParkerPenTrigger on Parker_Pen__c (before insert,before update,after insert,after update) {
    
    if(Trigger.isBefore==true && Trigger.isInsert==true){
        
        //This is for non static way of method calling in the class.
        //ContextVariableTask cvtask = new ContextVariableTask();
        //cvtask.functionA();

        //Static way of method calling of the class
        ContextVariableTask.functionA();
    }
    if(Trigger.isBefore==true && Trigger.isUpdate==true){
        ContextVariableTask.functionB();
    }
    if(Trigger.isAfter==true && Trigger.isInsert==true){
        ContextVariableTask.functionC();
    }
    if(Trigger.isAfter==true && Trigger.isUpdate==true){
        ContextVariableTask.functionD();
    }    

}

public class ContextVariableTask {
     static integer A=1;
    public static void functionA(){
       
        system.debug('FunctionA got called'+A++);
    }
    public static void functionB(){
        system.debug('FunctionB got called'+A++);
    }
    public static void functionC(){
        system.debug('FunctionC got called'+A++);
    }
    public static void functionD(){
        system.debug('FunctionD got called'+A++);
    }
    

}

if(Trigger.isUpdate==true &&trigger.isAfter==true){

}

if(Trigger.isDelete==true && trigger.isBefore==true){

}

if(Trigger.isInsert==true && trigger.isBefore==true){
    ContextVariableTask.functionA();
 
}  
if(Trigger.isUpdate==true && trigger.isBefore==true){
    ContextVariableTask.functionB();
 
}  
if(Trigger.isInsert==true && trigger.isAfter==true){
    ContextVariableTask.functionC();
 
}  
if(Trigger.isInsert==true && trigger.isAfter==true){
    ContextVariableTask.functionD();
 
}  





//Mobile object trigger

Trigger MobileTrigger on Mobile__c(before insert){
  MobileClass.discountPrice(Trigger.New);  
  

}


//Mobile trigger Class

public class MobileClass {
    Public static void discountPrice(list<Mobile__c> listOfMobiles){
    	for(Mobile__c mobileC:listOfMobiles){
            if(mobileC.Brand_Names__c=='Samsung'){
                mobileC.Price__c=mobileC.Price__c-20;
            }
		}
    }
     
}




@isTest
class MobileClassTest{

    @isTest
    static void TestDiscount(){
        
        //Creating a record for testing
        Mobile__c varMobile= New Mobile__c();
        varMobile.Brand_Names__c='Samsung';
        varMobile.Price__c=900;
        varMobile.Name='Galaxy IX';
        
        //Inserting the record in database
        insert varMobile;
        
        //creating a instance and fetching the values and storing in it.
        Mobile__c varMobile1= New Mobile__c();
        varMobile1=[SELECT Brand_Names__c,Price__c FROM Mobile__c WHERE Id=:varMobile.Id];
        
        //Asserting the functionality and values are correct
        System.assertEquals(880,varMobile1.Price__c);
        System.assertEquals('Samsung',varMobile1.Brand_Names__c);
    }

}
 
// Scenario 2 Trigger for Mobile object
Trigger MobileTrigger on Mobile__c(before insert){
  if(Trigger.isBefore==true && Trigger.isInsert==true){
      MobileClass.discountPrice(Trigger.New);
  }
}

public class MobileClass {
    Public static void discountPrice(list<Mobile__c> listOfMobiles){
        for(Mobile__c Name:listOfMobiles){
            if(Name.Brand_Names__c=='Samsung'){
                Name.Price__c=Name.Price__c-0.05*Name.Price__c;
            }
            if(Name.Brand_Names__c=='Apple'){
                Name.Price__c=Name.Price__c-0.15*Name.Price__c;
                
                }
        }
    }
     
}

@isTest
class MobileClassTest{

    @isTest
    static void TestDiscount(){
        
        //Creating a record for testing
        Mobile__c varMobile= New Mobile__c();
        varMobile.Brand_Names__c='Samsung';
        varMobile.Price__c=900;
        varMobile.Name='Galaxy IX';
        
        //Inserting the record in database
        insert varMobile;
        
        //creating a instance and fetching the values and storing in it.
        Mobile__c varMobile1= New Mobile__c();
        varMobile1=[SELECT Brand_Names__c,Price__c FROM Mobile__c WHERE Id=:varMobile.Id];
        
        //Asserting the functionality and values are correct
        System.assertEquals(855,varMobile1.Price__c);
        System.assertEquals('Samsung',varMobile1.Brand_Names__c);
        
        
         //Creating a record for testing
        Mobile__c varMobile2= New Mobile__c();
        varMobile2.Brand_Names__c='Apple';
        varMobile2.Price__c=900;
        varMobile2.Name='Iphone XS';
        
        //Inserting the record in database
        insert varMobile2;
        
        //creating a instance and fetching the values and storing in it.
        Mobile__c varMobile3= New Mobile__c();
        varMobile3=[SELECT Brand_Names__c,Price__c FROM Mobile__c WHERE Id=:varMobile2.Id];
        
        //Asserting the functionality and values are correct
        System.assertEquals(765,varMobile3.Price__c);
        System.assertEquals('Apple',varMobile3.Brand_Names__c);
    }

}


//Trigger Scenario 3 for Mobile object

Trigger MobileTrigger on Mobile__c(before insert, before update){
  if(Trigger.isBefore==true && Trigger.isInsert==true){
      MobileClass.discountPriceSale(Trigger.New);
  }
  if(Trigger.isBefore==true && Trigger.isUpdate==true){
      MobileClass.discountPrice(Trigger.New);
  }
}

public class MobileClass {
    Public static void discountPriceSale(list<Mobile__c> listOfMobiles){
        for(Mobile__c Name:listOfMobiles){
            if(Name.Brand_Names__c=='Samsung'){
                Name.Price__c=Name.Price__c-0.10*Name.Price__c;
                Name.Discount_Status__c='Congrats,you got 10% discount';
            }
            if(Name.Brand_Names__c=='Apple'){
                Name.Price__c=Name.Price__c-0.20*Name.Price__c;
                Name.Discount_Status__c='Congrats,you got 20% discount';
                }
        }
    }
     Public static void discountPrice(list<Mobile__c> listOfMobiles){
        for(Mobile__c Name:listOfMobiles){
            if(Name.Brand_Names__c=='Samsung'){
                Name.Price__c=Name.Price__c-0.5*Name.Price__c;
                Name.Discount_Status__c='Congrats,you got 10% discount';
            }
            if(Name.Brand_Names__c=='Apple'){
                Name.Price__c=Name.Price__c;
                Name.Discount_Status__c='Sorry,no discount';
                }
        }
    }
}

//Trigger for student object
Trigger StudentTrigger on student1__c (before insert) {
    if(Trigger.isInsert==true && Trigger.isBefore==true){
        Student1Class.experienceValid(Trigger.New);

    }


}

public class Student1Class{
    public static void experienceValid(list<student1__c> varListOfStudent){
        for(student1__c varStudent:varListOfStudent){
            if(varStudent.Age__c <30 && varStudent.Experience__c>8){ 
                varStudent.Status__c='Selected';
            
            }
        
        }
    
    
    }

}

@isTest
class Student1Test{
    @isTest 
    public static void experienceValidTest(){
        student1__c varStudtest= New student1__c();
        varStudtest.Name='Krishna';
        varStudtest.Age__c=28;
        varStudtest.Experience__c=9;
        
        insert varStudtest;
        
        student1__c varStudtest1= New student1__c();
        varStudtest1=[SELECT Status__c FROM student1__c WHERE Id=:varStudtest.Id];
        System.assertEquals('Selected',varStudtest1.Status__c);
    }


}


//old apex trigger for computer object

Trigger ComputerTrigger on Computer__c (before insert,before update) {
    if(Trigger.isBefore==true && Trigger.isInsert==true){
        Computerclass.capacityCheck(Trigger.New);
    }
    if(Trigger.isBefore==true && Trigger.isUpdate==true){
        Computerclass.capacityCheck(Trigger.New);
    }
}


//New apex trigger for computer object

Trigger ComputerTrigger on Computer__c (before insert,before update) {
    if(Trigger.isBefore==true && Trigger.isInsert==true){
        Computerclass.NewCapacityCheck(Trigger.New);
    }
    if(Trigger.isBefore==true && Trigger.isUpdate==true){
        Computerclass.OldCapacityCheck(Trigger.New);
    }
}



//old class code for computer object
public class Computerclass{
    public static void capacityCheck(list<Computer__c> varListofComp){
        for(Computer__c varcomputer:varListofComp){
          if(varcomputer.Processor__c<2  || varcomputer.RAM__c<1  || varcomputer.Hdisk__c<50){
              varcomputer.Capacity__c='Low Capacity';
          }
        }
    }

}

//new class code for computer object

public class Computerclass{
    public static void NewCapacityCheck(list<Computer__c> varListofComp){
        for(Computer__c varcomputer:varListofComp){
          if(varcomputer.Processor__c<2  || varcomputer.RAM__c<1  || varcomputer.Hdisk__c<50){
              varcomputer.Capacity__c='Low Capacity';
          }
        }
    }
     public static void OldCapacityCheck(list<Computer__c> varListofComp1){
        for(Computer__c varcomputer:varListofComp1){
          if(varcomputer.Processor__c<2  || varcomputer.RAM__c<1  || varcomputer.Hdisk__c<50){
              varcomputer.Capacity__c='Low Capacity';
          }
        }
    }
}



@isTest  
class PenDiscountClassTest {
 
    @isTest
    static void TestFunction1() { 

        //Create record for testing SAME LIKE ANY MANUAL QA WILL DO 
        Pen__c VarP = new Pen__c();
        VarP.Name='Shekhar';
        VarP.Price__c=200;
    
        //Inserting record in database  
        insert VarP;
    
        //(Trigger will be called, discount code will run)
        //Create new box VarP2 and fetch new value of the record which we just inserted  
        Pen__c VarP2 = New Pen__c(); 
        VarP2 = [SELECT Price__c FROM Pen__c WHERE Id =: VarP.Id];
    
        //Compare the new value with expected value 
        System.assertEquals(180, VarP2.Price__c); 
 
    } 
 

    @isTest
    static void TestFunction2() { 
 
        //Create record for testing SAME LIKE ANY MANUAL QA WILL DO      
        Pen__c VarP = new Pen__c();      
        VarP.Name='Shekhar';      
        VarP.Price__c=75;
        
        //Inserting record in database        
        insert VarP;
        
        //(Trigger will be called, discount code will run)
        //Create new box VarP2 and fetch new value of the record which we just inserted 
        Pen__c VarP2 = New Pen__c(); 
        VarP2 = [SELECT Price__c FROM Pen__c WHERE Id =: VarP.Id];
        
        //Compare the new value with expected value 
        System.assertEquals(65, VarP2.Price__c); 
 
    } 

}

trigger TriggerName on ObjectName (trigger_events) {
   code_block
}

public class StringArrayTest {
    public static List<string> generateStringArray(integer n){      
       List<string> Test=New List<string>();
       integer i;
       for(i=0;i<n;i++){
         Test.add('Test '+i);
       }
       return Test;
    }
}


List<string> Test= StringArrayTest.generateStringArray(5);
system.debug(Test);

//Trailhead Hands-on triggers on account object

trigger AccountAddressTrigger on Account (before insert,before update) {
    for(Account acc:trigger.new){
        if(acc.Match_Billing_Address__c==true){
            acc.ShippingPostalCode=acc.BillingPostalCode;
        }
    }
    
}    

SELECT count(id),LeadSource
FROM Lead
WHERE LeadSource<>null
GROUP BY LeadSource
having count(id)>=2
limit 10

trigger HelloWorldTrigger on Account (before insert) {
    for(Account a : Trigger.new) {
        a.Description = 'New description';
    }   
}

trigger ContextExampleTrigger on Account (before insert, after insert, after delete) {
    if (Trigger.isInsert) {
        if (Trigger.isBefore) {
            
        } else if (Trigger.isAfter) {
            
        }        
    }
    else if (Trigger.isDelete) {
        
    }
}

 trigger ExampleTrigger on Contact (after insert, after delete) {
    if (Trigger.isInsert) {
        Integer recordCount = Trigger.new.size();
        EmailManager.sendMail('Your email address', 'Trailhead Trigger Tutorial', 
                    recordCount + ' contact(s) were inserted.');
    }
    else if (Trigger.isDelete) {
       
    }
}



Contact c = new Contact(LastName='Test Contact');
insert c;


trigger AddRelatedRecord on Account(after insert, after update) {
    List<Opportunity> oppList = new List<Opportunity>();
    Map<Id,Account> acctsWithOpps = new Map<Id,Account>(
        [SELECT Id,(SELECT Id FROM Opportunities) FROM Account WHERE Id IN :Trigger.new]);
    for(Account a : Trigger.new) {
        System.debug('acctsWithOpps.get(a.Id).Opportunities.size()=' + acctsWithOpps.get(a.Id).Opportunities.size());        
        if (acctsWithOpps.get(a.Id).Opportunities.size() == 0) {           
            oppList.add(new Opportunity(Name=a.Name + ' Opportunity',
                                       StageName='Prospecting',
                                       CloseDate=System.today().addMonths(1),
                                       AccountId=a.Id));
        }           
    }
    if (oppList.size() > 0) {
        insert oppList;
    }
}
trigger AccountDeletion on Account (before delete) {  
    for (Account a : [SELECT Id FROM Account
                     WHERE Id IN (SELECT AccountId FROM Opportunity) AND
                     Id IN :Trigger.old]) {
        Trigger.oldMap.get(a.Id).addError(
            'Cannot delete account with related opportunities.');
    }
}
public class CalloutClass {
    @future(callout=true)
    public static void makeCallout() {
        HttpRequest request = new HttpRequest();      
        String endpoint = 'http://yourHost/yourService';
        request.setEndPoint(endpoint);        
        request.setMethod('GET'); 
        Http http = new HTTP();

        HttpResponse response = http.send(request);
    }
}
trigger CalloutTrigger on Account (before insert, before update) {
    CalloutClass.makeCallout();
}

SELECT [id, LeadSource FROM Lead WHERE LeadSource<>null GROUP BY LeadSource]; 

SELECT [COUNT(Id), LeadSource FROM Lead WHERE LeadSource!=null GROUP BY LeadSource LIMIT 3];

SELECT count(id),LeadSource
FROM Lead
WHERE LeadSource<>null
GROUP BY LeadSource
having count(id)>=7
limit 1

List<Account> VarAccList= New List<Account>();
For(Account acc:VarAccList){
acc = [FIND '*.com'in Website Return acc.Id,acc.Website];
}
system.debug(VarAccList);

Trigger ParkerPenTrigger on Parker_Pen__c(before insert){
    for(Parker_Pen__c:Trigger.New){
        if(Trigger.New==before && Trigger.New==insert){
            PenClassDemonstration.applyDiscountPen(Trigger.New);
        }
    }
}

public class PenClassDemonstration {
    
    //public static void applyDiscountPen()
    public static List<Parker_Pen__c> applyDiscountPen(){
        List<Parker_Pen__c> VarPenListNew=New List<Parker_Pen__c >();
        for(Parker_Pen__c VarPen:VarPenListNew){
            
            if(VarPen.Price__c >= 100 && VarPen.Price__c<150){
                VarPen.Price__c = VarPen.Price__c-VarPen.Price__c*0.1;
            }else if(VarPen.Price__c>=150 && VarPen.Price__c<200){
                VarPen.Price__c = VarPen.Price__c-VarPen.Price__c*0.15;
            }else if(VarPen.Price__c>=200 && VarPen.Price__c<350){
                VarPen.Price__c = VarPen.Price__c-VarPen.Price__c*0.2;
            }else if(VarPen.Price__c>=350){
                VarPen.Price__c = VarPen.Price__c-VarPen.Price__c*0.25;
            }
            
        }
       // system.debug(VarPenListNew);
       Return VarPenListNew;
    }    
}



Http http = new Http();
HttpRequest request = new HttpRequest();
request.setEndpoint('https://th-apex-http-callout.herokuapp.com/animals');
request.setMethod('GET');
HttpResponse response = http.send(request);
// If the request is successful, parse the JSON response.
if(response.getStatusCode() == 200) {
    // Deserialize the JSON string into collections of primitive data types.
    Map<String, Object> results = (Map<String, Object>)JSON..deserializeUntyped(response.getBody());
    // Cast the values in the 'animals' key as a list
    List<Object> animals = (List<Object>) results.get('animals');
    System.debug('Received the following animals:');
    for(Object animal: animals) {
        System.debug(animal);
    }
}



Http http = new Http();
HttpRequest request = new HttpRequest();
request.setEndpoint('https://th-apex-http-callout.herokuapp.com/animals');
request.setMethod('POST');
request.setHeader('Content-Type', 'application/json;charset=UTF-8');
// Set the body as a JSON object
request.setBody('{"name":"mighty moose"}');
HttpResponse response = http.send(request);
// Parse the JSON response
if(response.getStatusCode() != 201) {
    System.debug('The status code returned was not expected: ' + response.getStatusCode() + ' ' + response.getStatus());
} else {
    System.debug(response.getBody());
}
  

@isTest
private class AnimalsCalloutsTest {
        @isTest 
        static  void testGetCallout() {
        // Create the mock response based on a static resource
        StaticResourceCalloutMock mock = new StaticResourceCalloutMock();
        mock.setStaticResource('GetAnimalResource');
        mock.setStatusCode(200);
        mock.setHeader('Content-Type', 'application/json;charset=UTF-8');
        // Associate the callout with a mock response
        Test.setMock(HttpCalloutMock.class, mock);
        // Call method to test
        HttpResponse result = AnimalsCallouts.makeGetCallout();
        // Verify mock response is not null
        System.assertNotEquals(null,result, 'The callout returned a null response.');
        // Verify status code
        System.assertEquals(200,result.getStatusCode(), 'The status code is not 200.');
        // Verify content type   
        System.assertEquals('application/json;charset=UTF-8',
          result.getHeader('Content-Type'),
          'The content type value is not expected.');  
        // Verify the array contains 3 items     
        Map<String, Object> results = (Map<String, Object>) 
            JSON.deserializeUntyped(result.getBody());
        List<Object> animals = (List<Object>) results.get('animals');
        System.assertEquals(3, animals.size(), 'The array should only contain 3 items.');          
    }   
}


public class HttpCalloutMock{
   
   global HTTPResponse respond(HTTPRequest request){
      HttpResponse response = new HttpResponse();
        response.setHeader('Content-Type', 'application/json');
        response.setBody('{"radhika": ["majestic badger", "fluffy bunny", "scary bear", "chicken", "mighty moose"]}');
        response.setStatusCode(200);
  }

}

@isTest
global class AnimalsHttpCalloutMock implements HttpCalloutMock {
    // Implement this interface method

    @override
    global HTTPResponse respond(HTTPRequest request) {
        // Create a fake response
        HttpResponse response = new HttpResponse();
        response.setHeader('Content-Type', 'application/json');
        response.setBody('{"animals": ["majestic badger", "fluffy bunny", "scary bear", "chicken", "mighty moose"]}');
        response.setStatusCode(200);
        return response; 
   }
}


public clsss MakeCallOut{                    
    public static HttpResponse makePostCallout() {
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://th-apex-http-callout.herokuapp.com/animals');
        request.setMethod('POST');
        request.setHeader('Content-Type', 'application/json;charset=UTF-8');
        request.setBody('{"name":"mighty moose"}');
        HttpResponse response = http.send(request);
        // Parse the JSON response
        if(response.getStatusCode() != 201) {
            System.debug('The status code returned was not expected: ' +
                response.getStatusCode() + ' ' + response.getStatus());
        } else {
            System.debug(response.getBody());
        }
        return response;        
    }        
}



@isTest
global class MakeCallOutMock implements HttpCalloutMock {
    // Implement this interface method
    global HTTPResponse respond(HTTPRequest request) {
        // Create a fake response
        HttpResponse response = new HttpResponse();
        response.setHeader('Content-Type', 'application/json');
        response.setBody('{"animals": ["majestic badger", "fluffy bunny", "scary bear", "chicken", "mighty moose"]}');
        response.setStatusCode(200);
        return response; 
   }
}



  @isTest 
public class MakeCallOutTest{  
    @isTest 
    static void testPostCallout() {
        // Set mock callout class 
        Test.setMock(HttpCalloutMock.class, new MakeCallOutMock()); 
        // This causes a fake response to be sent
        // from the class that implements HttpCalloutMock. 
        HttpResponse response = MakeCallOut.makePostCallout();
        // Verify that the response received contains fake values
        String contentType = response.getHeader('Content-Type');
        System.assert(contentType == 'application/json');
        String actualValue = response.getBody();
        System.debug(response.getBody());
        String expectedValue = '{"animals": ["majestic badger", "fluffy bunny", "scary bear", "chicken", "mighty moose"]}';
        System.assertEquals(expectedValue, actualValue);
        System.assertEquals(200, response.getStatusCode());
    }
}


public class AnimalLocator {
    
    public static String getAnimalNameById (integer idNum){        
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://th-apex-http-callout.herokuapp.com/animals/'+idNum);
        request.setMethod('GET');
        HttpResponse response = http.send(request);
        // If the request is successful, parse the JSON response.
        
        
            // Deserializes the JSON string into collections of primitive data types.
             Map<String, Object> result = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
             Map<String, Object> animal = (Map<String, Object>) result.get('animal');
             return string.valueOf(animal.get('name'));
  
        
    }
    
}


String name =AnimalLocator.getAnimalNameById(1); 
System.debug('NAME '+ name);


@isTest
global class AnimalLocatorMock implements HttpCalloutMock {
     global HTTPResponse respond(HTTPRequest request) {
        // Create a fake response
        HttpResponse response = new HttpResponse();
        response.setHeader('Content-Type', 'application/json');
        response.setBody('{"animal":{"id":1,"name":"chicken","eats":"chicken food","says":"cluck cluck"}}');
        response.setStatusCode(200);
        return response; 
    }

}

@isTest
public class AnimalLocatorTest {
    
    @isTest
    static void testAnimalLocator(){
		Test.setMock(HttpCalloutMock.class, new AnimalLocatorMock());
        String name = AnimalLocator.getAnimalNameById(1);
    	string expectedReturn='chicken';
        system.assertEquals(expectedReturn, name);
    }
        
    
}

//Nested class call for wsdl add method for calculatoraAPI
tempuriOrg.CalculatorSoap temp = new tempuriOrg.CalculatorSoap();
System.debug(temp.Add(2,11));

//SOAP
//wsdltoApex
//WSDL File- calculatorServices.apex,asynccalculatorServices
public class AwesomeCalculator {
    public static Double add(Double x, Double y) {
        calculatorServices.CalculatorImplPort calculator = 
            new calculatorServices.CalculatorImplPort();
        return calculator.doAdd(x,y);
    }
}

//Mock response Test file:

@isTest
global class CalculatorCalloutMock implements WebServiceMock {
   global void doInvoke(
           Object stub,
           Object request,
           Map<String, Object> response,
           String endpoint,
           String soapAction,
           String requestName,
           String responseNS,
           String responseName,
           String responseType) {
        // start - specify the response you want to send
        calculatorServices.doAddResponse response_x = 
            new calculatorServices.doAddResponse();
        response_x.return_x = 3.0;
        // end
        response.put('response_x', response_x); 
   }
}

@isTest
private class AwesomeCalculatorTest {
    @isTest static void testCallout() {              
        // This causes a fake response to be generated
        Test.setMock(WebServiceMock.class, new CalculatorCalloutMock());
        // Call the method that invokes a callout
        Double x = 1.0;
        Double y = 2.0;
        Double result = AwesomeCalculator.add(x, y);
        // Verify that a fake result is returned
        System.assertEquals(3.0, result); 
    }
}


public class ParkLocator {
    
    public static String[] country(String country) {
        ParkService.ParksImplPort parkService = 
            new ParkService.ParksImplPort();
        return parkService.byCountry(country);
    }
 

}


String[] parks = ParkLocator.country('India');
system.debug('ParkNames '+parks);

@isTest
global class ParkServiceMock implements WebServiceMock {
global void doInvoke(
           Object stub,
           Object request,
           Map<String, Object> response,
           String endpoint,
           String soapAction,
           String requestName,
           String responseNS,
           String responseName,
           String responseType) {
        // start - specify the response you want to send
        ParkService.byCountryResponse response_x = 
            new ParkService.byCountryResponse();
               response_x.return_x = new List<String>{'National Park','ABC Park'};
                  
        // end
        response.put('response_x', response_x); 
   }
}

@isTest
public class ParkLocatorTest {
    
    @isTest 
    static void testCallout() {              
        // This causes a fake response to be generated
        Test.setMock(WebServiceMock.class, new ParkServiceMock());
        // Call the method that invokes a callout
       
        
        // Verify that a fake result is returned
        System.assertEquals(new List<String>{'National Park','ABC Park'}, ParkLocator.country('India')); 

	}
}


https://url.com/data/service/cases/1234

@RestResource(urlMapping='/Cases/*')
global with sharing class CaseManager {
    @HttpGet
    global static Case getCaseById() {
        RestRequest request = RestContext.request;
        // grab the caseId from the end of the URL
        String recordId = request.requestURI.substring(
          request.requestURI.lastIndexOf('/')+1);
        Case result =  [SELECT CaseNumber,Subject,Status,Origin,Priority
                        FROM Case
                        WHERE Id = :caseId];

                        SELECT Id,Name,(SELECT Id FROM Contacts) FROM Account 
                                       WHERE Id= :caseId
        return result;
    }
    @HttpPost
    global static ID createCase(String subject, String status,
        String origin, String priority) {
        Case thisCase = new Case(
            Subject=subject,
            Status=status,
            Origin=origin,
            Priority=priority);
        insert thisCase;
        return thisCase.Id;
    }   
    @HttpDelete
    global static void deleteCase() {
        RestRequest request = RestContext.request;
        String caseId = request.requestURI.substring(
            request.requestURI.lastIndexOf('/')+1);
        Case thisCase = [SELECT Id FROM Case WHERE Id = :caseId];
        delete thisCase;
    }     
    @HttpPut
    global static ID upsertCase(String subject, String status,
        String origin, String priority, String id) {
        Case thisCase = new Case(
                Id=id,
                Subject=subject,
                Status=status,
                Origin=origin,
                Priority=priority);
        // Match case by Id, if present.
        // Otherwise, create new case.
        upsert thisCase;
        // Return the case ID.
        return thisCase.Id;
    }
    @HttpPatch
    global static ID updateCaseFields() {
        RestRequest request = RestContext.request;
        String caseId = request.requestURI.substring(
            request.requestURI.lastIndexOf('/')+1);
        Case thisCase = [SELECT Id FROM Case WHERE Id = :caseId];
        // Deserialize the JSON string into name-value pairs
        Map<String, Object> params = (Map<String, Object>)JSON.deserializeUntyped(request.requestbody.tostring());
        // Iterate through each parameter field and value
        for(String fieldName : params.keySet()) {
            // Set the field and value on the Case sObject
            thisCase.put(fieldName, params.get(fieldName));
        }
        update thisCase;
        return thisCase.Id;
    }    


  
}

  //CaseManagerTest

@IsTest
private class CaseManagerTest {
    @isTest static void testGetCaseById() {
        Id recordId = createTestRecord();
        // Set up a test request
        RestRequest request = new RestRequest();
        request.requestUri =
            'https://yourInstance.my.salesforce.com/services/apexrest/Cases/'
            + recordId;
        request.httpMethod = 'GET';
        RestContext.request = request;
        // Call the method to test
        Case thisCase = CaseManager.getCaseById();
        // Verify results
        System.assert(thisCase != null);
        System.assertEquals('Test record', thisCase.Subject);
    }
    @isTest static void testCreateCase() {
        // Call the method to test
        ID thisCaseId = CaseManager.createCase(
            'Ferocious chipmunk', 'New', 'Phone', 'Low');
        // Verify results
        System.assert(thisCaseId != null);
        Case thisCase = [SELECT Id,Subject FROM Case WHERE Id=:thisCaseId];
        System.assert(thisCase != null);
        System.assertEquals(thisCase.Subject, 'Ferocious chipmunk');
    }
    @isTest static void testDeleteCase() {
        Id recordId = createTestRecord();
        // Set up a test request
        RestRequest request = new RestRequest();
        request.requestUri =
            'https://yourInstance.my.salesforce.com/services/apexrest/Cases/'
            + recordId;
        request.httpMethod = 'DELETE';
        RestContext.request = request;
        // Call the method to test
        CaseManager.deleteCase();
        // Verify record is deleted
        List<Case> cases = [SELECT Id FROM Case WHERE Id=:recordId];
        System.assert(cases.size() == 0);
    }
    @isTest static void testUpsertCase() {
        // 1. Insert new record
        ID case1Id = CaseManager.upsertCase(
                'Ferocious chipmunk', 'New', 'Phone', 'Low', null);
        // Verify new record was created
        System.assert(Case1Id != null);
        Case case1 = [SELECT Id,Subject FROM Case WHERE Id=:case1Id];
        System.assert(case1 != null);
        System.assertEquals(case1.Subject, 'Ferocious chipmunk');
        // 2. Update status of existing record to Working
        ID case2Id = CaseManager.upsertCase(
                'Ferocious chipmunk', 'Working', 'Phone', 'Low', case1Id);
        // Verify record was updated
        System.assertEquals(case1Id, case2Id);
        Case case2 = [SELECT Id,Status FROM Case WHERE Id=:case2Id];
        System.assert(case2 != null);
        System.assertEquals(case2.Status, 'Working');
    }    
    @isTest static void testUpdateCaseFields() {
        Id recordId = createTestRecord();
        RestRequest request = new RestRequest();
        request.requestUri =
            'https://yourInstance.my.salesforce.com/services/apexrest/Cases/'
            + recordId;
        request.httpMethod = 'PATCH';
        request.addHeader('Content-Type', 'application/json');
        request.requestBody = Blob.valueOf('{"status": "Working"}');
        RestContext.request = request;
        // Update status of existing record to Working
        ID thisCaseId = CaseManager.updateCaseFields();
        // Verify record was updated
        System.assert(thisCaseId != null);
        Case thisCase = [SELECT Id,Status FROM Case WHERE Id=:thisCaseId];
        System.assert(thisCase != null);
        System.assertEquals(thisCase.Status, 'Working');
    }  
    // Helper method
    static Id createTestRecord() {
        // Create test record
        Case caseTest = new Case(
            Subject='Test record',
            Status='New',
            Origin='Phone',
            Priority='Medium');
        insert caseTest;
        return caseTest.Id;
    }          
}



@RestResource(urlMapping='/Accounts/*')
global with sharing class AccountManager {
    
    
    @HttpGet
    global static Account getAccount() {
        RestRequest request = RestContext.request;
        // grab the caseId from the end of the URL
        String accountId = request.requestURI.substring(
          request.requestURI.lastIndexOf('/')+1);
        Account result =  [SELECT Id,Name,(SELECT Id,Name FROM Contacts) FROM Account 
                                       WHERE Id= :accountId];

                    
        return result;
    }
}


@isTest
private class AccountManagerTest {
    
    @isTest 
    static void testGetAccount() {
        Account a = new Account(
            Name='Test Account');
        insert a;
        Contact c = new Contact(AccountId=a.Id,
            FirstName='Test ',LastName='Contact1');
         insert c;
        
        // Set up a test request
        RestRequest request = new RestRequest();
        request.requestUri =
            'https://creative-goat-p0t2ea-dev-ed.trailblaze.my.salesforce.com/services/apexrest/Accounts/'+a.Id+'/contacts';
        request.httpMethod = 'GET';
        RestContext.request = request;
        
        // Call the method to test
        Account thisAccount = AccountManager.getAccount();
        // Verify results
        System.assert(thisAccount != null);
        System.assertEquals('Test Account', thisAccount.Name);
       // System.assert(thisAccount.Contacts.size() > 0);
       
        //System.assertEquals('Test ', thisAccount.Contacts[0].FirstName);
    }
    

}



trigger MyTriggerNotBulk on Account(before insert) {
    Account a = Trigger.new[0];
    a.Description = 'New description';
}


trigger MyTriggerBulk on Account(before insert) {
    for(Account a : Trigger.new) {
        a.Description = 'New description';
    }
}

trigger SoqlTriggerNotBulk on Account(after update) {   
    for(Account a : Trigger.new) {
        // Get child records for each account
        // Inefficient SOQL query as it runs once for each account!
        Opportunity[] opps = [SELECT Id,Name,CloseDate 
                             FROM Opportunity WHERE AccountId=:a.Id];
        // Do some other processing
    }
}


trigger SoqlTriggerBulk on Account(after update) {  
    // Perform SOQL query once.    
    // Get the accounts and their related opportunities.
    List<Account> acctsWithOpps = 
        [SELECT Id,(SELECT Id,Name,CloseDate FROM Opportunities) 
         FROM Account WHERE Id IN :Trigger.new];
    // Iterate over the returned accounts    
    for(Account a : acctsWithOpps) { 
        Opportunity[] relatedOpps = a.Opportunities;  
        // Do some other processing
    }
}


trigger SoqlTriggerBulk on Account(after update) {  
    // Perform SOQL query once.    
    // Get the accounts and their related opportunities.
    List<Account> acctsWithOpps = 
        [SELECT Id,(SELECT Id,Name,CloseDate FROM Opportunities) 
         FROM Account WHERE Id IN :Trigger.new];
    // Iterate over the returned accounts    
    for(Account a : acctsWithOpps) { 
        Opportunity[] relatedOpps = a.Opportunities;  
        // Do some other processing
    }
}

trigger SoqlTriggerBulk on Account(after update) {  
    // Perform SOQL query once.    
    // Get the related opportunities for the accounts in this trigger.
    List<Opportunity> relatedOpps = [SELECT Id,Name,CloseDate FROM Opportunity
        WHERE AccountId IN :Trigger.new];
    // Iterate over the related opportunities    
    for(Opportunity opp : relatedOpps) { 
        // Do some other processing
    }
}

trigger SoqlTriggerBulk on Account(after update) {  
    // Perform SOQL query once.    
    // Get the related opportunities for the accounts in this trigger,
    // and iterate over those records.
    for(Opportunity opp : [SELECT Id,Name,CloseDate FROM Opportunity
        WHERE AccountId IN :Trigger.new]) {
        // Do some other processing
    }
}


trigger DmlTriggerNotBulk on Account(after update) {   
    // Get the related opportunities for the accounts in this trigger.        
    List<Opportunity> relatedOpps = [SELECT Id,Name,Probability FROM Opportunity
        WHERE AccountId IN :Trigger.new];          
    // Iterate over the related opportunities
    for(Opportunity opp : relatedOpps) {      
        // Update the description when probability is greater 
        // than 50% but less than 100% 
        if ((opp.Probability >= 50) && (opp.Probability < 100)) {
            opp.Description = 'New description for opportunity.';
            // Update once for each opportunity -- not efficient!
            update opp;
        }
    }    
}

trigger DmlTriggerBulk on Account(after update) {   
    // Get the related opportunities for the accounts in this trigger.        
    List<Opportunity> relatedOpps = [SELECT Id,Name,Probability FROM Opportunity
        WHERE AccountId IN :Trigger.new];
    List<Opportunity> oppsToUpdate = new List<Opportunity>();
    // Iterate over the related opportunities
    for(Opportunity opp : relatedOpps) {      
        // Update the description when probability is greater 
        // than 50% but less than 100% 
        if ((opp.Probability >= 50) && (opp.Probability < 100)) {
            opp.Description = 'New description for opportunity.';
            oppsToUpdate.add(opp);
        }
    }
    // Perform DML on a collection
    update oppsToUpdate;
}

List<Account> toProcess = null;
switch on Trigger.operationType {
    when AFTER_INSERT {
        // do stuff
    }
    when AFTER_UPDATE {
        // do stuff
    }
}

when AFTER_INSERT {
     toProcess = Trigger.New;
}

when AFTER_UPDATE {
     toProcess = [SELECT Id,Name FROM Account
                  WHERE Id IN :Trigger.New AND
                  Id NOT IN (SELECT AccountId FROM Opportunity WHERE AccountId in :Trigger.New)];
}

trigger AddRelatedRecord on Account(after insert, after update) {
    List<Opportunity> oppList = new List<Opportunity>();
    // Add an opportunity for each account if it doesn't already have one.
    // Iterate over accounts that are in this trigger but that don't have opportunities.
    List<Account> toProcess = null;
    switch on Trigger.operationType {
        when AFTER_INSERT {
        // All inserted Accounts will need the Opportunity, so there is no need to perform the query
            toProcess = Trigger.New;
        }
        when AFTER_UPDATE {
            toProcess = [SELECT Id,Name FROM Account
                         WHERE Id IN :Trigger.New AND
                         Id NOT IN (SELECT AccountId FROM Opportunity WHERE AccountId in :Trigger.New)];
        }
    }
    for (Account a : toProcess) {
        // Add a default opportunity for this account
        oppList.add(new Opportunity(Name=a.Name + ' Opportunity',
                                    StageName='Prospecting',
                                    CloseDate=System.today().addMonths(1),
                                    AccountId=a.Id));
    }
    if (oppList.size() > 0) {
        insert oppList;
    }
}

trigger ClosedOpportunityTrigger on Opportunity (after insert, after update)
{
    if(Trigger.isAfter)
    {
        if(Trigger.isInsert || Trigger.isUpdate)
        {
               List<task> tasLists = new List<task>();
            for(opportunity opp : Trigger.new)
              {    
                   if(opp.stagename =='Closed Won')
                   {
                    task tas = new task(Whatid = opp.id, Status = 'Active', Subject = 'Follow Up Test Task', 
                                           Priority = 'High', ActivityDate = system.today());
                       tasLists.add(tas); 
                }
              }
            if(tasLists.size()>0)
            {
                 insert tasLists;   
            }
        }
    }    
}

trigger ClosedOpportunityTrigger on Opportunity (after insert, after update) {
    
  List<Opportunity> toProcess =null;
    
    switch on Trigger.operationType{
        when AFTER_INSERT{
           toProcess=Trigger.New; 
        }
        when AFTER_UPDATE{
            toProcess= [select id,StageName from Opportunity where id in:Trigger.New AND StageName='Closed Won'];        
        }
    }
    List<Task> taskList = new List<Task>();
    for(Opportunity p:toProcess){
        if(p.StageName=='closedWon'){
            Task t = new Task();
            t.WhatId=p.Id;
            t.subject='Follow Up Test Task';
            taskList.add(t);
        }
        insert taskList;
    }
}    


// Create the account sObject 
Account acct = new Account(Name='Acme', Phone='(415)555-1212', NumberOfEmployees=100);
// Insert the account by using DML
insert acct;

// Create the account sObject 
Account acct = new Account(Name='Acme', Phone='(415)555-1212', NumberOfEmployees=100);
// Insert the account by using DML
insert acct;
// Get the new ID on the inserted sObject argument
ID acctID = acct.Id;
// Display this ID in the debug log
System.debug('ID = ' + acctID);
// Debug log result (the ID will be different in your case)
// DEBUG|ID = 001D000000JmKkeIAF



// Create a list of contacts
List<Contact> conList = new List<Contact> {
    new Contact(FirstName='Joe',LastName='Smith',Department='Finance'),
        new Contact(FirstName='Kathy',LastName='Smith',Department='Technology'),
        new Contact(FirstName='Caroline',LastName='Roth',Department='Finance'),
        new Contact(FirstName='Kim',LastName='Shain',Department='Education')};
// Bulk insert all contacts with one DML call
insert conList;
// List to hold the new contacts to update
List<Contact> listToUpdate = new List<Contact>();
// Iterate through the list and add a title only
//   if the department is Finance
for(Contact con : conList) {
    if (con.Department == 'Finance') {
        con.Title = 'Financial analyst';
        // Add updated contact sObject to the list.
        listToUpdate.add(con);
    }
}
// Bulk update all contacts with one DML call
update listToUpdate;
upsert sObjectList Account.Fields.MyExternalId;

// Insert the Josh contact
Contact josh = new Contact(FirstName='Josh',LastName='Kaplan',Department='Finance');       
insert josh;
// Josh's record has been inserted
//   so the variable josh has now an ID
//   which will be used to match the records by upsert
josh.Description = 'Josh\'s record has been updated by the upsert operation.';
// Create the Kathy contact, but don't persist it in the database
Contact kathy = new Contact(FirstName='Kathy',LastName='Brown',Department='Technology');
// List to hold the new contacts to upsert
List<Contact> contacts = new List<Contact> { josh, kathy };
// Call upsert
upsert contacts;
// Result: Josh is updated and Kathy is created.

Contact jane = new Contact(FirstName='Jane',
                         LastName='Smith',
                         Email='jane.smith@example.com',
                         Description='Contact of the day');
insert jane;
// 1. Upsert using an idLookup field
// Create a second sObject variable.
// This variable doesn’t have any ID set.
Contact jane2 = new Contact(FirstName='Jane',
                         LastName='Smith',  
                         Email='jane.smith@example.com',
                         Description='Prefers to be contacted by email.');
// Upsert the contact by using the idLookup field for matching.
upsert jane2 Contact.fields.Email;
// Verify that the contact has been updated
System.assertEquals('Prefers to be contacted by email.',
                   [SELECT Description FROM Contact WHERE Id=:jane.Id].Description);


                   
try {
    // This causes an exception because 
    //   the required Name field is not provided.
    Account acct = new Account();
    // Insert the account 
    insert acct;
} catch (DmlException e) {
    System.debug('A DML exception has occurred: ' +
                e.getMessage());
}

Database.insert(recordList, false);
Database.SaveResult[] results = Database.insert(recordList, false);
Database.insert(recordList);
Database.insert(recordList, true);

// Create a list of contacts
List<Contact> conList = new List<Contact> {
        new Contact(FirstName='Joe',LastName='Smith',Department='Finance'),
        new Contact(FirstName='Kathy',LastName='Smith',Department='Technology'),
        new Contact(FirstName='Caroline',LastName='Roth',Department='Finance'),
        new Contact()};
// Bulk insert all contacts with one DML call
Database.SaveResult[] srList = Database.insert(conList, false);
// Iterate through each returned result
for (Database.SaveResult sr : srList) {
    if (sr.isSuccess()) {
        // Operation was successful, so get the ID of the record that was processed
        System.debug('Successfully inserted contact. Contact ID: ' + sr.getId());
    } else {
        // Operation failed, so get all errors
        for(Database.Error err : sr.getErrors()) {
            System.debug('The following error has occurred.');
            System.debug(err.getStatusCode() + ': ' + err.getMessage());
            System.debug('Contact fields that affected this error: ' + err.getFields());
	 }
    }
}


Account acct = new Account(Name='SFDC Account');
insert acct;
// Once the account is inserted, the sObject will be 
// populated with an ID.
// Get this ID.
ID acctID = acct.ID;
// Add a contact to this account.
Contact mario = new Contact(
    FirstName='Mario',
    LastName='Ruiz',
    Phone='415.555.1212',
    AccountId=acctID);
insert mario;

// Query for the contact, which has been associated with an account.
Contact queriedContact = [SELECT Account.Name 
                          FROM Contact 
                          WHERE FirstName = 'Mario' AND LastName='Ruiz'
                          LIMIT 1];
// Update the contact's phone number
queriedContact.Phone = '(415)555-1213';
// Update the related account industry
queriedContact.Account.Industry = 'Technology';
// Make two separate calls 
// 1. This call is to update the contact's phone.
update queriedContact;
// 2. This call is to update the related account's Industry field.
update queriedContact.Account; 

Account[] queriedAccounts = [SELECT Id FROM Account WHERE Name='SFDC Account'];
delete queriedAccounts;

public class AccountHandler {
    public static Account insertNewAccount(String name) {
        Account a = new Account();
        a.Name = name;
        try {
            insert a;
        } catch (Exception e) {
            return null;
        }
        return a;
    }
}

Account[] accts = [SELECT Name,Phone FROM Account];

// Add account and related contact
Account acct = new Account(
    Name='SFDC Computing',
    Phone='(415)555-1212',
    NumberOfEmployees=50,
    BillingCity='San Francisco');
insert acct;
// Once the account is inserted, the sObject will be 
// populated with an ID.
// Get this ID.
ID acctID = acct.ID;
// Add a contact to this account.
Contact con = new Contact(
    FirstName='Carol',
    LastName='Ruiz',
    Phone='(415)555-1212',
    Department='Wingo',
    AccountId=acctID);
insert con;
// Add account with no contact
Account acct2 = new Account(
    Name='The SFDC Query Man',
    Phone='(310)555-1213',
    NumberOfEmployees=50,
    BillingCity='Los Angeles',
    Description='Expert in wing technologies.');
insert acct2;

SELECT Name,Phone FROM Account

SELECT fields FROM ObjectName [WHERE Condition]

SELECT Name,Phone FROM Account

SELECT Name,Phone FROM Account WHERE Name='SFDC Computing'

SELECT Name,Phone FROM Account WHERE (Name='SFDC Computing' AND NumberOfEmployees>25)

SELECT Name,Phone FROM Account WHERE (Name='SFDC Computing' OR (NumberOfEmployees>25 AND BillingCity='Los Angeles'))

SELECT Name,Phone FROM Account ORDER BY Name

SELECT Name,Phone FROM Account ORDER BY Name ASC

SELECT Name,Phone FROM Account ORDER BY Name DESC

Account oneAccountOnly = [SELECT Name,Phone FROM Account LIMIT 1];

SELECT Name,Phone FROM Account 
                   WHERE (Name = 'SFDC Computing' AND NumberOfEmployees>25)
                   ORDER BY Name
                   LIMIT 10


                   Account[] accts = [SELECT Name,Phone FROM Account 
                   WHERE (Name='SFDC Computing' AND NumberOfEmployees>25)
                   ORDER BY Name
                   LIMIT 10];
System.debug(accts.size() + ' account(s) returned.');
// Write all account array info
System.debug(accts);

String targetDepartment = 'Wingo';
Contact[] techContacts = [SELECT FirstName,LastName 
                          FROM Contact WHERE Department=:targetDepartment];



SELECT Name, (SELECT LastName FROM Contacts) FROM Account WHERE Name = 'SFDC Computing'

Account[] acctsWithContacts = [SELECT Name, (SELECT FirstName,LastName FROM Contacts)
                               FROM Account 
                               WHERE Name = 'SFDC Computing'];
// Get child records
Contact[] cts = acctsWithContacts[0].Contacts;
System.debug('Name of first associated contact: ' 
             + cts[0].FirstName + ', ' + cts[0].LastName);


Contact[] cts = [SELECT Account.Name FROM Contact 
                 WHERE FirstName = 'Carol' AND LastName='Ruiz'];
Contact carol = cts[0];
String acctName = carol.Account.Name;
System.debug('Carol\'s account name is ' + acctName);

for (variable : [soql_query]) {
    code_block
}

for (variable_list : [soql_query]) {
    code_block
}

insert new Account[]{new Account(Name = 'for loop 1'), 
                     new Account(Name = 'for loop 2'), 
                     new Account(Name = 'for loop 3')};
// The sObject list format executes the for loop once per returned batch
// of records
Integer i=0;
Integer j=0;
for (Account[] tmp : [SELECT Id FROM Account WHERE Name LIKE 'for loop _']) {
    j = tmp.size();
    i++;
}
System.assertEquals(3, j); // The list should have contained the three accounts
                       // named 'yyy'
System.assertEquals(1, i); // Since a single batch can hold up to 200 records and,
                       // only three records should have been returned, the 
                       // loop should have executed only once



public class ContactSearch {
    public static List<Contact> searchForContacts(String lastName,  String postalCode) {
        return [
            select Name
            from Contact
            where LastName = :lastName and
                MailingPostalCode = :postalCode
        ];
    }
}



//SOSL Query
List<List<SObject>> searchList = [FIND 'SFDC' IN ALL FIELDS 
                                      RETURNING Account(Name), Contact(FirstName,LastName)];


FIND {Wingo} IN ALL FIELDS RETURNING Account(Name), Contact(FirstName,LastName,Department)

FIND 'SearchQuery' [IN SearchGroup] [RETURNING ObjectsAndFields]

FIND {SearchQuery} [IN SearchGroup] [RETURNING ObjectsAndFields]

String soslFindClause = 'Wingo OR SFDC';
List<List<sObject>> searchList = [FIND :soslFindClause IN ALL FIELDS
                    RETURNING Account(Name),Contact(FirstName,LastName,Department)];
Account[] searchAccounts = (Account[])searchList[0];
Contact[] searchContacts = (Contact[])searchList[1];
System.debug('Found the following accounts.');
for (Account a : searchAccounts) {
    System.debug(a.Name);
}
System.debug('Found the following contacts.');
for (Contact c : searchContacts) {
    System.debug(c.LastName + ', ' + c.FirstName);
}

public class ContactAndLeadSearch {

public static List<List<SObject>> searchContactsAndLeads(String param)
{
    Contact a = new Contact();
    a.LastName='Smith';
    insert a;

    Lead b = new Lead();
    b.LastName='Smith';
    b.Company='Infosys';
    insert b;

    List<List<SObject>> retvalue = [FIND 'Smith' IN ALL FIELDS RETURNING Contact(Name, LastName, FirstName 
                                                                                 where LastName=:param or FirstName=:param), 
                                    Lead(Name, LastName, FirstName where LastName=:param or FirstName=:param)];
    return retvalue;
}
}

public class SomeClass {
  @future
  public static void someFutureMethod(List<Id> recordIds) {
    List<Account> accounts = [Select Id, Name from Account Where Id IN :recordIds];
    // process account records to do awesome stuff
  }
}

public class SMSUtils {
    // Call async from triggers, etc, where callouts are not permitted.
    @future(callout=true)
    public static void sendSMSAsync(String fromNbr, String toNbr, String m) {
        String results = sendSMS(fromNbr, toNbr, m);
        System.debug(results);
    }
    // Call from controllers, etc, for immediate processing
    public static String sendSMS(String fromNbr, String toNbr, String m) {
        // Calling 'send' will result in a callout
        String results = SmsMessage.send(fromNbr, toNbr, m);
        insert new SMS_Log__c(to__c=toNbr, from__c=fromNbr, msg__c=results);
        return results;
    }
}

@isTest
public class SMSCalloutMock implements HttpCalloutMock {
    public HttpResponse respond(HttpRequest req) {
        // Create a fake response
        HttpResponse res = new HttpResponse();
        res.setHeader('Content-Type', 'application/json');
        res.setBody('{"status":"success"}');
        res.setStatusCode(200);
        return res;
    }
}

@IsTest
private class Test_SMSUtils {
  @IsTest
  private static void testSendSms() {
    Test.setMock(HttpCalloutMock.class, new SMSCalloutMock());
    Test.startTest();
      SMSUtils.sendSMSAsync('111', '222', 'Greetings!');
    Test.stopTest();
    // runs callout and check results
    List<SMS_Log__c> logs = [select msg__c from SMS_Log__c];
    System.assertEquals(1, logs.size());
    System.assertEquals('success', logs[0].msg__c);
  }
}
public class AccountProcessor{
    @future
    public static void countContacts(List<Id> accountIds){
        List<Account> vAccountList = new List<Account>();
        List<Account> acc = [SELECT Id,Name,
                             (SELECT Id,Name FROM Contacts) 
                             FROM Account WHERE Id IN :accountIds];
        System.debug('total contact in Account: ' + acc);
        
        if(acc.size() > 0){
            for(Account a: acc){
                List<Contact> con = [SELECT Id,Name FROM Contact WHERE accountId = :a.Id];
                a.Number_of_Contacts__c = con.size();
                vAccountList.add(a);
            }
            if(vAccountList.size()>0)
            {
                update vAccountList;
            }
        }
    }
}

@isTest
public class AccountProcessorTest {
    @isTest public static void testNoOfContacts(){
        Account a = new Account(Name = 'Acme1');
        Insert a;
        Account b = new Account(Name = 'Acme2');
        insert b;
        Contact c = new Contact(FirstName = 'Gk', LastName = 'Gupta', accountId = a.Id);
        insert c;
        Contact c1 = new Contact(FirstName = 'Gk1', LastName = 'Gupta1', accountId = b.Id);
        insert c1;
        
        List<account> acnt = [SELECT Id FROM Account WHERE Name = :a.Name OR Name = :b.Name];
        System.debug('size of acnt: ' + acnt);
        List<ID> acntIDLST = new List<Id>();
        for(Account ac: acnt){
            acntIDLST.add(ac.Id);
        }
        Test.startTest();
        AccountProcessor.countContacts(acntIDLST);
        Test.stopTest();
    }
}

public class MyBatchClass implements Database.Batchable<sObject> {
    public (Database.QueryLocator | Iterable<sObject>) start(Database.BatchableContext bc) {
        // collect the batches of records or objects to be passed to execute
    }
    public void execute(Database.BatchableContext bc, List<P> records){
        // process each batch of records
    }
    public void finish(Database.BatchableContext bc){
        // execute any post-processing operations
    }
}

MyBatchClass myBatchObject = new MyBatchClass();
Id batchId = Database.executeBatch(myBatchObject);

Id batchId = Database.executeBatch(myBatchObject, 100);

AsyncApexJob job = [SELECT Id, Status, JobItemsProcessed, TotalJobItems, NumberOfErrors FROM AsyncApexJob WHERE ID = :batchId ];

public class UpdateContactAddresses implements
    Database.Batchable<sObject>, Database.Stateful {
    // instance member to retain state across transactions
    public Integer recordsProcessed = 0;
    public Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator(
            'SELECT ID, BillingStreet, BillingCity, BillingState,' +
            'BillingPostalCode, (SELECT ID, MailingStreet, MailingCity, ' +
            'MailingState, MailingPostalCode FROM Contacts) FROM Account ' +
            'Where BillingCountry = \'USA\''
        );
    }
    public void execute(Database.BatchableContext bc, List<Account> scope){
        // process each batch of records
        List<Contact> contacts = new List<Contact>();
        for (Account account : scope) {
            for (Contact contact : account.contacts) {
                contact.MailingStreet = account.BillingStreet;
                contact.MailingCity = account.BillingCity;
                contact.MailingState = account.BillingState;
                contact.MailingPostalCode = account.BillingPostalCode;
                // add contact to list to be updated
                contacts.add(contact);
                // increment the instance member counter
                recordsProcessed = recordsProcessed + 1;
            }
        }
        update contacts;
    }
    public void finish(Database.BatchableContext bc){
        System.debug(recordsProcessed + ' records processed. Shazam!');
        AsyncApexJob job = [SELECT Id, Status, NumberOfErrors,
            JobItemsProcessed,
            TotalJobItems, CreatedBy.Email
            FROM AsyncApexJob
            WHERE Id = :bc.getJobId()];
        // call some utility to send email
        EmailUtils.sendMessage(job, recordsProcessed);
    }
}

@isTest
private class UpdateContactAddressesTest {
    @testSetup
    static void setup() {
        List<Account> accounts = new List<Account>();
        List<Contact> contacts = new List<Contact>();
        // insert 10 accounts
        for (Integer i=0;i<10;i++) {
            accounts.add(new Account(name='Account '+i,
                billingcity='New York', billingcountry='USA'));
        }
        insert accounts;
        // find the account just inserted. add contact for each
        for (Account account : [select id from account]) {
            contacts.add(new Contact(firstname='first',
                lastname='last', accountId=account.id));
        }
        insert contacts;
    }
    @isTest static void test() {
        Test.startTest();
        UpdateContactAddresses uca = new UpdateContactAddresses();
        Id batchId = Database.executeBatch(uca);
        Test.stopTest();
        // after the testing stops, assert records were updated properly
        System.assertEquals(10, [select count() from contact where MailingCity = 'New York']);
    }
}


global class LeadProcessor implements Database.Batchable <SObject> {
//START METHOD
    global Database.QueryLocator start(Database.BatchableContext bc){
        String Query='Select id,LeadSource from Lead';
        return Database.getQueryLocator(Query);
            }
//EXECUTE METHOD
    global void execute(Database.BatchableContext bc, List<Lead> scope){
        for(Lead l: scope){
            l.LeadSource='DreamForce';
        }
        update scope;
    }
//FINISH METHOD
    global void finish(Database.BatchableContext bc){
        Id job= bc.getJobId();
        System.debug(job);
    }
}


@istest
private class LeadProcessorTest {
    @istest
    static void tetslead(){
        List<Lead> l= new List<Lead>();
        lead l1= new Lead();
        l1.LastName='surya';
        l1.Company='Dell';
        l1.Status='Closed-Converted';
        l1.LeadSource='Dreamforce';
        l.add(l1);
        insert l;
   
    Test.startTest();
    LeadProcessor lp= new LeadProcessor();
    Id jobid= Database.executeBatch(lp);
    Test.stopTest();
    }
}

@future
static void myFutureMethod(List<String> params) {
    // call synchronous method
    mySyncMethod(params);
}

public class SomeClass implements Queueable {
    public void execute(QueueableContext context) {
        // awesome code here
    }
}



public class UpdateParentAccount implements Queueable {
    private List<Account> accounts;
    private ID parent;
    public UpdateParentAccount() {
       
    }
    public UpdateParentAccount(List<Account> records, ID id) {
        this.accounts = records;
        this.parent = id;
    }
    public void execute(QueueableContext context) {
        for (Account account : accounts) {
          account.parentId = parent;
          // perform other processing or callout
        }
        update accounts;
    }
}

// find all accounts in ‘NY’
List<Account> accounts = [select id from account where billingstate = ‘NY’];
// find a specific parent account for all records
Id parentId = [select id from account where name = 'ACME Corp'][0].Id;
// instantiate a new instance of the Queueable class
UpdateParentAccount updateJob = new UpdateParentAccount(accounts, parentId);
// enqueue the job for processing
ID jobID = System.enqueueJob(updateJob);

SELECT Id, Status, NumberOfErrors FROM AsyncApexJob WHERE Id = :jobID

@isTest
public class UpdateParentAccountTest {
    @testSetup
    static void setup() {
        List<Account> accounts = new List<Account>();
        // add a parent account
        accounts.add(new Account(name='Parent'));
        // add 100 child accounts
        for (Integer i = 0; i < 100; i++) {
            accounts.add(new Account(
                name='Test Account'+i
            ));
        }
        insert accounts;
    }
    static testmethod void testQueueable() {
        // query for test data to pass to queueable class
        Id parentId = [select id from account where name = 'Parent'][0].Id;
        List<Account> accounts = [select id, name from account where name like 'Test Account%'];
        // Create our Queueable instance
        UpdateParentAccount updater = new UpdateParentAccount(accounts, parentId);
        // startTest/stopTest block to force async processes to run
        Test.startTest();
        System.enqueueJob(updater);
        Test.stopTest();
        // Validate the job ran. Check if record have correct parentId now
        System.assertEquals(100, [select count() from account where parentId = :parentId]);
    }
}


public class FirstJob implements Queueable {
    public void execute(QueueableContext context) {
        // Awesome processing logic here
        // Chain this job to next job by submitting the next job
        System.enqueueJob(new SecondJob());
    }
}


public class AddPrimaryContact implements Queueable {
public contact c;
public String state;

public AddPrimaryContact(Contact c, String state) {
this.c = c;
this.state = state;
}

public void execute(QueueableContext qc) {
system.debug('this.c = '+this.c+ 'this.state = '+this.state);
List<Account> accList = new List<account>([select id, name, BillingState from account 
                                           where account.BillingState = :this.state limit 200]);
List<contact> insertContact = new List<contact>();
for(account a: accList) {
contact c = new contact();
c = this.c.clone(false, false, false, false);
c.AccountId = a.Id;
insertContact.add(c);
}
insert insertContact;
}

}

@isTest
public class AddPrimaryContactTest {

@testSetup
static void setup() {
List<Account> insertAccount = new List<Account>();
for(integer i=0; i<=100; i++) {
if(i <=50) {
insertAccount.add(new Account(Name='Acc'+i, BillingState = 'NY'));
} else {
insertAccount.add(new Account(Name='Acc'+i, BillingState = 'CA'));
}
}
insert insertAccount;
}

static testMethod void testAddPrimaryContact() {
Contact con = new Contact(LastName = 'LastName');
AddPrimaryContact addPC = new AddPrimaryContact(con, 'CA');
Test.startTest();
system.enqueueJob(addPC);
Test.stopTest();

system.assertEquals(50, [select count() from Contact]);
}

}


public class SomeClass implements Schedulable {
    public void execute(SchedulableContext ctx) {
        // awesome code here
    }
}

RemindOpptyOwners reminder = new RemindOpptyOwners();
// Seconds Minutes Hours Day_of_month Month Day_of_week optional_year
String sch = '20 30 8 10 2 ?';
String jobID = System.schedule('Remind Opp Owners', sch, reminder);



@isTest
private class RemindOppyOwnersTest {
    // Dummy CRON expression: midnight on March 15.
    // Because this is a test, job executes
    // immediately after Test.stopTest().
    public static String CRON_EXP = '0 0 0 15 3 ? 2022';
    static testmethod void testScheduledJob() {
        // Create some out of date Opportunity records
        List<Opportunity> opptys = new List<Opportunity>();
        Date closeDate = Date.today().addDays(-7);
        for (Integer i=0; i<10; i++) {
            Opportunity o = new Opportunity(
                Name = 'Opportunity ' + i,
                CloseDate = closeDate,
                StageName = 'Prospecting'
            );
            opptys.add(o);
        }
        insert opptys;
        // Get the IDs of the opportunities we just inserted
        Map<Id, Opportunity> opptyMap = new Map<Id, Opportunity>(opptys);
        List<Id> opptyIds = new List<Id>(opptyMap.keySet());
        Test.startTest();
        // Schedule the test job
        String jobId = System.schedule('ScheduledApexTest',
            CRON_EXP,
            new RemindOpptyOwners());
        // Verify the scheduled job has not run yet.
        List<Task> lt = [SELECT Id
            FROM Task
            WHERE WhatId IN :opptyIds];
        System.assertEquals(0, lt.size(), 'Tasks exist before job has run');
        // Stopping the test will run the job synchronously
        Test.stopTest();
        // Now that the scheduled job has executed,
        // check that our tasks were created
        lt = [SELECT Id
            FROM Task
            WHERE WhatId IN :opptyIds];
        System.assertEquals(opptyIds.size(),
            lt.size(),
            'Tasks were not created');
    }
}


global class DailyLeadProcessor implements Schedulable {

    global void execute(SchedulableContext ctx) {
        List<Lead> lList = [Select Id, LeadSource from Lead where LeadSource = null limit 200];
        list<lead> led = new list<lead>();
        if(!lList.isEmpty()) {
            for(Lead l: lList) {
                l.LeadSource = 'Dreamforce';
                led.add(l);
            }
            update led;
        }
    }
}

@isTest
public class DailyLeadProcessorTest{

    static void testMethod1() 
    {
        Test.startTest();
        
        List<Lead> lstLead = new List<Lead>();
        for(Integer i=0 ;i <200;i++)
        {
            Lead led = new Lead();
            led.FirstName ='FirstName';
            led.LastName ='LastName'+i;
            led.Company ='demo'+i;
            lstLead.add(led);
        }
        
        insert lstLead;
        
        DailyLeadProcessor ab = new DailyLeadProcessor();
         String jobId = System.schedule('jobName','0 5 * * * ? ' ,ab) ;
        
   
        Test.stopTest();
    }
}

AsyncApexJob jobInfo = [SELECT Status, NumberOfErrors
    FROM AsyncApexJob WHERE Id = :jobID];

CronTrigger ct = [SELECT TimesTriggered, NextFireTime FROM CronTrigger WHERE Id = :jobID];

public class DoAwesomeStuff implements Schedulable {
    public void execute(SchedulableContext sc) {
        // some awesome code
        CronTrigger ct = [SELECT TimesTriggered, NextFireTime FROM CronTrigger WHERE Id = :sc.getTriggerId()];
    }
}

CronTrigger job = [SELECT Id, CronJobDetail.Id, CronJobDetail.Name, CronJobDetail.JobType 
FROM CronTrigger ORDER BY CreatedDate DESC LIMIT 1];

CronJobDetail ctd = [SELECT Id, Name, JobType FROM CronJobDetail WHERE Id = :job.CronJobDetail.Id];

SELECT COUNT() FROM CronTrigger WHERE CronJobDetail.JobType = '7’

@isTest static void testName() {
    // code_block
}



@isTest
private class MyTestClass {
    @isTest static void myTest() {
        // code_block
    }
}

public class TemperatureConverter {
    // Takes a Fahrenheit temperature and returns the Celsius equivalent.
    public static Decimal FahrenheitToCelsius(Decimal fh) {
        Decimal cs = (fh - 32) * 5/9;
        return cs.setScale(2);
    }
}

@isTest
private class TemperatureConverterTest {
    @isTest static void testWarmTemp() {
        Decimal celsius = TemperatureConverter.FahrenheitToCelsius(70);
        System.assertEquals(21.11,celsius);
    }
    @isTest static void testFreezingPoint() {
        Decimal celsius = TemperatureConverter.FahrenheitToCelsius(32);
        System.assertEquals(0,celsius);
    }
    @isTest static void testBoilingPoint() {
        Decimal celsius = TemperatureConverter.FahrenheitToCelsius(212);        
        System.assertEquals(100,celsius,'Boiling point temperature is not expected.');
    } 
    @isTest static void testNegativeTemp() {
        Decimal celsius = TemperatureConverter.FahrenheitToCelsius(-10);
        System.assertEquals(-23.33,celsius);
    }
}

    @isTest static void testBoilingPoint() {
        Decimal celsius = TemperatureConverter.FahrenheitToCelsius(212);        
        // Simulate failure
        System.assertEquals(0,celsius,'Boiling point temperature is not expected.');
    }

    public class TaskUtil {
    public static String getTaskPriority(String leadState) {
        // Validate input
        if (String.isBlank(leadState) || leadState.length() > 2) {
            return null;
        }
        String taskPriority;
        if (leadState == 'CA') {
             taskPriority = 'High'; 
        } else {
             taskPriority = 'Normal';
        }
        return taskPriority;
    }
}

@isTest
private class TaskUtilTest {
    @isTest static void testTaskPriority() {
        String pri = TaskUtil.getTaskPriority('NY');
        System.assertEquals('Normal', pri);
    }
}

@isTest
private class TaskUtilTest {
    @isTest static void testTaskPriority() {
        String pri = TaskUtil.getTaskPriority('NY');
        System.assertEquals('Normal', pri);
    }
    @isTest static void testTaskHighPriority() {
        String pri = TaskUtil.getTaskPriority('CA');
        System.assertEquals('High', pri);
    }
    @isTest static void testTaskPriorityInvalid() {
        String pri = TaskUtil.getTaskPriority('Montana');
        System.assertEquals(null, pri);
    }
}


public class VerifyDate {
	
	//method to handle potential checks against two dates
	public static Date CheckDates(Date date1, Date date2) {
		//if date2 is within the next 30 days of date1, use date2.  Otherwise use the end of the month
		if(DateWithin30Days(date1,date2)) {
			return date2;
		} else {
			return SetEndOfMonthDate(date1);
		}
	}
	
	//method to check if date2 is within the next 30 days of date1
	private static Boolean DateWithin30Days(Date date1, Date date2) {
		//check for date2 being in the past
        	if( date2 < date1) { return false; }
        
        	//check that date2 is within (>=) 30 days of date1
        	Date date30Days = date1.addDays(30); //create a date 30 days away from date1
		if( date2 >= date30Days ) { return false; }
		else { return true; }
	}

	//method to return the end of the month of a given date
	private static Date SetEndOfMonthDate(Date date1) {
		Integer totalDays = Date.daysInMonth(date1.year(), date1.month());
		Date lastDay = Date.newInstance(date1.year(), date1.month(), totalDays);
		return lastDay;
	}


}


@isTest
public class TestVerifyDate {
    @isTest static void testCheckDatesdate2() {
        Date d1 = VerifyDate.CheckDates(System.today(), System.today()+10);
        System.assertEquals(System.today()+10, d1);
    }
    
    @isTest static void testCheckDatesenddate() {
        Date d2 = VerifyDate.CheckDates(System.today(), System.today()+50);
        Date startDate = System.Date.today().toStartOfMonth(); 
        System.assertEquals(startDate.addMonths(1).addDays(-1), d2);
    }
}

trigger AccountDeletion on Account (before delete) {
    // Prevent the deletion of accounts if they have related opportunities.
    for (Account a : [SELECT Id FROM Account
                     WHERE Id IN (SELECT AccountId FROM Opportunity) AND
                     Id IN :Trigger.old]) {
        Trigger.oldMap.get(a.Id).addError(
            'Cannot delete account with related opportunities.');
    }
}

@isTest
private class TestAccountDeletion {
    @isTest static void TestDeleteAccountWithOneOpportunity() {
        // Test data setup
        // Create an account with an opportunity, and then try to delete it
        Account acct = new Account(Name='Test Account');
        insert acct;
        Opportunity opp = new Opportunity(Name=acct.Name + ' Opportunity',
                                       StageName='Prospecting',
                                       CloseDate=System.today().addMonths(1),
                                       AccountId=acct.Id);
        insert opp;
        // Perform test
        Test.startTest();
        Database.DeleteResult result = Database.delete(acct, false);
        Test.stopTest();
        // Verify 
        // In this case the deletion should have been stopped by the trigger,
        // so verify that we got back an error.
        System.assert(!result.isSuccess());
        System.assert(result.getErrors().size() > 0);
        System.assertEquals('Cannot delete account with related opportunities.',
                             result.getErrors()[0].getMessage());
    }
}

trigger RestrictContactByName on Contact (before insert, before update) {
	
	//check contacts prior to insert or update for invalid data
	For (Contact c : Trigger.New) {
		if(c.LastName == 'INVALIDNAME') {	//invalidname is invalid
			c.AddError('The Last Name "'+c.LastName+'" is not allowed for DML');
		}

	}



}

@isTest
public class TestRestrictContactByName {
    
    @isTest static void TestRestrictContactByNameValid() {
        
        List<Contact> contest = new List<Contact>();
        
        contest.add(new Contact(LastName='Welter',FirstName = 'Harry'));
        contest.add(new Contact(LastName='AAA'));
        contest.add(new Contact(LastName='INVALIDNAME',FirstName = 'Harry'));
       	contest.add(new Contact());
        
        Test.startTest();
        Database.SaveResult[] result = Database.insert(contest, false);
        Test.stopTest();
        
        for(Database.SaveResult sr : result){
            if(!sr.isSuccess()){
                System.assert(!sr.isSuccess());
            }else{
                System.assert(sr.isSuccess());
            }
        }
        
    }    

}


@isTest
public class TestDataFactory {
    public static List<Account> createAccountsWithOpps(Integer numAccts, Integer numOppsPerAcct) {
        List<Account> accts = new List<Account>();
        for(Integer i=0;i<numAccts;i++) {
            Account a = new Account(Name='TestAccount' + i);
            accts.add(a);
        }
        insert accts;
        List<Opportunity> opps = new List<Opportunity>();
        for (Integer j=0;j<numAccts;j++) {
            Account acct = accts[j];
            // For each account just inserted, add opportunities
            for (Integer k=0;k<numOppsPerAcct;k++) {
                opps.add(new Opportunity(Name=acct.Name + ' Opportunity ' + k,
                                       StageName='Prospecting',
                                       CloseDate=System.today().addMonths(1),
                                       AccountId=acct.Id));
            }
        }
        // Insert all opportunities for all accounts.
        insert opps;
        return accts;
    }
}

        // Test data setup
        // Create one account with one opportunity by calling a utility method
        Account[] accts = TestDataFactory.createAccountsWithOpps(1,1);

        @isTest
private class TestAccountDeletion {
    @isTest static void TestDeleteAccountWithOneOpportunity() {
        // Test data setup
        // Create one account with one opportunity by calling a utility method
        Account[] accts = TestDataFactory.createAccountsWithOpps(1,1);
        // Perform test
        Test.startTest();
        Database.DeleteResult result = Database.delete(accts[0], false);
        Test.stopTest();
        // Verify that the deletion should have been stopped by the trigger,
        // so check that we got back an error.
        System.assert(!result.isSuccess());
        System.assert(result.getErrors().size() > 0);
        System.assertEquals('Cannot delete account with related opportunities.',
                             result.getErrors()[0].getMessage());
    }        
}

@isTest
private class TestAccountDeletion {
    @isTest static void TestDeleteAccountWithOneOpportunity() {
        // Test data setup
        // Create one account with one opportunity by calling a utility method
        Account[] accts = TestDataFactory.createAccountsWithOpps(1,1);
        // Perform test
        Test.startTest();
        Database.DeleteResult result = Database.delete(accts[0], false);
        Test.stopTest();
        // Verify that the deletion should have been stopped by the trigger,
        // so check that we got back an error.
        System.assert(!result.isSuccess());
        System.assert(result.getErrors().size() > 0);
        System.assertEquals('Cannot delete account with related opportunities.',
                             result.getErrors()[0].getMessage());
    }
    @isTest static void TestDeleteAccountWithNoOpportunities() {
        // Test data setup
        // Create one account with no opportunities by calling a utility method
        Account[] accts = TestDataFactory.createAccountsWithOpps(1,0);
        // Perform test
        Test.startTest();
        Database.DeleteResult result = Database.delete(accts[0], false);
        Test.stopTest();
        // Verify that the deletion was successful
        System.assert(result.isSuccess());
    }
    @isTest static void TestDeleteBulkAccountsWithOneOpportunity() {
        // Test data setup
        // Create accounts with one opportunity each by calling a utility method
        Account[] accts = TestDataFactory.createAccountsWithOpps(200,1);
        // Perform test
        Test.startTest();
        Database.DeleteResult[] results = Database.delete(accts, false);
        Test.stopTest();
        // Verify for each record.
        // In this case the deletion should have been stopped by the trigger,
        // so check that we got back an error.
        for(Database.DeleteResult dr : results) {
            System.assert(!dr.isSuccess());
            System.assert(dr.getErrors().size() > 0);
            System.assertEquals('Cannot delete account with related opportunities.',
                                 dr.getErrors()[0].getMessage());
        }
    }
    @isTest static void TestDeleteBulkAccountsWithNoOpportunities() {
        // Test data setup
        // Create accounts with no opportunities by calling a utility method
        Account[] accts = TestDataFactory.createAccountsWithOpps(200,0);
        // Perform test
        Test.startTest();
        Database.DeleteResult[] results = Database.delete(accts, false);
        Test.stopTest();
        // For each record, verify that the deletion was successful
        for(Database.DeleteResult dr : results) {
            System.assert(dr.isSuccess());
        }
    }
}

FIND {term} RETURNING ObjectTypeName

FIND {march 2016 email} RETURNING Campaign

FIND {term} RETURNING ObjectTypeName1, ObjectTypeName2, ObjectTypeNameYouGetTheIdea

FIND {recycled materials} RETURNING Product2, ContentVersion, FeedItem

FIND {pink hi\-top} RETURNING Merchandise__c

FIND {jsmith@cloudkicks.com} IN EMAIL FIELDS RETURNING Contact

FIND {Cloud Kicks} RETURNING Account

FIND {Cloud Kicks} RETURNING Account(Name, Industry)

FIND {Cloud Kicks} RETURNING Account (Name, Industry ORDER BY Name)

FIND {Cloud Kicks} RETURNING Account (Name, Industry ORDER BY Name LIMIT 10)

FIND {Cloud Kicks} RETURNING Account (Name, Industry ORDER BY Name LIMIT 10 OFFSET 25)

FIND {Cloud Kicks} RETURNING Account (Name, Industry)
    WITH DIVISION = 'Global'

FIND {race} RETURNING KnowledgeArticleVersion
(Id, Title WHERE PublishStatus='online' and language='en_US')
WITH DATA CATEGORY Location__c AT America__c

FIND {first place} RETURNING User (Id, Name),
FeedItem (id, ParentId WHERE CreatedDate = THIS_YEAR Order by CreatedDate DESC)
WITH NETWORK = '00000000000001'

Find {shoe} RETURNING Product2 WITH PricebookId = '01sxx0000002MffAAE'

/vXX.X/search/suggestTitleMatches?q=search string&language=article language&publishStatus=article publication status

/vXX.X/search/suggestTitleMatches?q=race+tips&language=en_US&publishStatus=Online

{
  "autoSuggestResults" : [ {
    "attributes" : {
    "type" : "KnowledgeArticleVersion",
    "url" : "/services/data/v30.0/sobjects/KnowledgeArticleVersion/ka0D00000004CcQ"
    },
  "Id" : "ka0D00000004CcQ",
  "UrlName" : "tips-for-your-first-trail-race",
  "Title" : "race tips",
  "KnowledgeArticleId" : "kA0D00000004Cfz",
  "isMasterLanguage" : "1",
  } ],
  "hasMoreResults" : false
}

public with sharing class AccountController {
  public static List<Account> getAllActiveAccounts() {
    return [SELECT Id, Name, Active__c FROM Account WHERE Active__c = 'Yes' WITH SECURITY_ENFORCED];
  }
}

//From the BankAcct class, instantiate an object named chkAcct
BankAcct chkAcct = new BankAcct();
//Set the accttype attribute of the chkAcct object to Checking
chkAcct.accttype = 'Checking';
//Set the acctName attribute of the chkAcct object to D.Castillo-Chk
chkAcct.acctName = 'D.Castillo-Chk ';
//Invoke the makeDeposit method with 150 as the argument
chkAcct.makeDeposit(150);
//From the BankAcct class, instantiate an object named savAcct
BankAcct savAcct = new BankAcct();
//Set the accttype attribute of the savAcct object to Savings
savAcct.accttype = 'Savings';
//Set the acctName attribute of the savAcct object to D.Castillo-Sav
savAcct.acctName = 'D.Castillo–Sav';
//Invoke the makeDeposit method with 220 as the argument
savAcct.makeDeposit(220);
//From the List class, instantiate a BankAcct List object named bankAccts
List<BankAcct> bankAccts = new List<BankAcct>();
System.debug('The BankAcct List has ' + bankAccts.size() + ' bank accounts.');
//Add the chkAcct object to the bankAccts list
bankAccts.add(chkAcct);
//Add the savAcct object to the bankAccts list
bankAccts.add(savAcct);
System.debug('The BankAcct List has ' + bankAccts.size() + ' bank accounts.');
System.debug('Here is the list: ' + bankAccts);

public with sharing class CreateContactFromCan {
    //Declare a method that returns void and accepts a Candidate list named candsFromTrigger
    public static void createContact (List<Candidate__c> candsFromTrigger) {
        //Instantiate a Contact list named conList
        List<Contact> conList = new List<Contact>();
        //Declare a list FOR loop that uses an iteration variable named currentCandidate
        //to loop through the candsFromTrigger list
        for(Candidate__c currentCandidate:candsFromTrigger) {
            //Create a Contact and add it to conList
            //Set the FirstName, LastName, and Email attributes to match the
            //corresponding attributes of the currentCandidate object (First_Name__c,
            //Last_Name__c, and Email__c)
            conList.add(new Contact(
                //Set the AccountId for the contact(we'll do this in the next unit)
                //AccountId = candAccts[0].Id,
                FirstName = currentCandidate.First_Name__c,
                LastName = currentCandidate.Last_Name__c,
                Email = currentCandidate.Email__c)
            );
        }
        //Save conList to the database
        Database.insert(conList);
    }
}