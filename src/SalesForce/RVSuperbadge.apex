//1. Trigger
trigger MaintenanceRequest on Case (before update, after update) {
    if(Trigger.isUpdate && Trigger.isAfter){
        MaintenanceRequestHelper.updateWorkOrders(Trigger.New);
    }    
}


//Apex class
public with sharing class MaintenanceRequestHelper {
    
    public static void updateWorkOrders(list<Case> cs) {
        List<case> newCaseList = new List<case>();
        Integer avgAmount=10000;
        
        List<Equipment_Maintenance_Item__c> newEMI = new List<Equipment_Maintenance_Item__c>();
        List<case> caseList = [SELECT id,Vehicle__c,Subject,ProductID,Product__c, (SELECT id from Equipment_Maintenance_Items__r) from case where status='closed' and Type IN ('Repair', 'Routine Maintenance') and ID IN :cs LIMIT 200];
        Map<id,Equipment_Maintenance_Item__c> equip = new map<id,Equipment_Maintenance_Item__c>([Select ID, Equipment__c, Quantity__c,Equipment__r.id,Equipment__r.Maintenance_Cycle__c from Equipment_Maintenance_Item__c ]);
        for(case c: caseList){
            case newCase = new Case();
            newCase.Type = 'Routine Maintenance';
            newCase.Status = 'New';
            newCase.Vehicle__c = c.Vehicle__c;
            newCase.Subject =  String.isBlank(c.Subject) ? 'Routine Maintenance Request' : c.Subject;
            newCase.Date_Reported__c = Date.today();
            newCase.ProductId = c.ProductId;
            newCase.Product__c = c.Product__c;
            newCase.parentID = c.Id;
            
            
            for(Equipment_Maintenance_Item__c emi : c.Equipment_Maintenance_Items__r ){
                avgAmount = Math.min(avgAmount,Integer.valueOf(equip.get(emi.id).Equipment__r.Maintenance_Cycle__c));
                newEMI.add(new Equipment_Maintenance_Item__c(
                    Equipment__c = equip.get(emi.id).Equipment__c,
                    Maintenance_Request__c = c.id,
                    Quantity__c = equip.get(emi.id).Quantity__c));
            }
            Date dueDate = date.TODAY().adddays(avgAmount);
            newCase.Date_Due__c =dueDate;
            newCaseList.add(newCase);
            
        }
        if(newCaseList.size()>0){
            Database.insert(newCaseList);    
        }
        
        for(Case c2: newCaseList){
            for(Equipment_Maintenance_Item__c emi2 : newEmi){
                if(c2.parentID == emi2.Maintenance_Request__c){
                    emi2.Maintenance_Request__c = c2.id;    
                }
            }
        }
        
        if(newEmi.size()>0){
            Database.insert(newEmi);    
        }     
    }    
    
}



//2. Synch

public with sharing class WarehouseCalloutService {
    private static final String WAREHOUSE_URL = 'https://th-superbadge-apex.herokuapp.com/equipment';
    
    @future(callout=true)
    public static void runWarehouseEquipmentSync() {
        //ToDo: complete this method to make the callout (using @future) to the
        //      REST endpoint and update equipment on hand.
		HttpResponse response = getResponse();
        if(response.getStatusCode() == 200)
        {
            List<Product2> results = getProductList(response); //get list of products from Http callout response
            if(results.size() >0)
            upsert results Warehouse_SKU__c; //Upsert the products in your org based on the external ID SKU
        }
    }
    
    //Get the product list from the external link
    public static List<Product2> getProductList(HttpResponse response)
    {
            List<Object> externalProducts = (List<Object>) JSON.deserializeUntyped(response.getBody()); //desrialize the json response
            List<Product2> newProducts = new List<Product2>();
            for(Object p : externalProducts)
            {
                Map<String, Object> productMap = (Map<String, Object>) p;
                Product2 pr = new Product2();
            	//Map the fields in the response to the appropriate fields in the Equipment object
                pr.Replacement_Part__c = (Boolean)productMap.get('replacement');
                pr.Cost__c = (Integer)productMap.get('cost');
                pr.Current_Inventory__c = (Integer)productMap.get('quantity');
                pr.Lifespan_Months__c = (Integer)productMap.get('lifespan') ;
                pr.Maintenance_Cycle__c = (Integer)productMap.get('maintenanceperiod');
                pr.Warehouse_SKU__c = (String)productMap.get('sku');
                pr.ProductCode = (String)productMap.get('_id');
                pr.Name = (String)productMap.get('name');
                newProducts.add(pr);
            }
            return newProducts;
        }
        // Send Http GET request and receive Http response
    public static HttpResponse getResponse() {
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint(WAREHOUSE_URL);
        request.setMethod('GET');
        HttpResponse response = http.send(request);
        return response;
    }
    }


//Execute below one from anonymous window
WarehouseCalloutService.runWarehouseEquipmentSync(); 


//3. Schedule synchronization

global  class WarehouseSyncSchedule implements Schedulable{
    // implement scheduled code here
    global  void execute (SchedulableContext sc){
        WarehouseCalloutService.runWarehouseEquipmentSync();
        //optional this can be done by debug mode
       String sch = '00 00 01 * * ?';//on 1 pm
       System.schedule('WarehouseSyncScheduleTest', sch, new WarehouseSyncSchedule());
    }
}

//Execute below one from anonymous window
WarehouseSyncSchedule scheduleInventoryCheck();


//Automation tests

@IsTest
private class InstallationTests {
    private static final String STRING_TEST = 'TEST';
    private static final String NEW_STATUS = 'New';
    private static final String WORKING = 'Working';
    private static final String CLOSED = 'Closed';
    private static final String REPAIR = 'Repair';
    private static final String REQUEST_ORIGIN = 'Web';
    private static final String REQUEST_TYPE = 'Routine Maintenance';
    private static final String REQUEST_SUBJECT = 'AMC Spirit';
    public static String CRON_EXP = '0 0 1 * * ?';
    static testmethod void testMaintenanceRequestNegative() {
        Vehicle__c vehicle = createVehicle();
        insert vehicle;
        Id vehicleId = vehicle.Id;
        Product2 equipment = createEquipment();
        insert equipment;
        Id equipmentId = equipment.Id;
        Case r = createMaintenanceRequest(vehicleId, equipmentId);
        insert r;
        Work_Part__c w = createWorkPart(equipmentId, r.Id);
        insert w;
        Test.startTest();
        r.Status = WORKING;
        update r;
        Test.stopTest();
        List<case> allRequest = [SELECT Id
                                 FROM Case];
        Work_Part__c workPart = [SELECT Id
                                 FROM Work_Part__c
                                 WHERE Maintenance_Request__c =: r.Id];
        System.assert(workPart != null);
        System.assert(allRequest.size() == 1);
    }
    static testmethod void testWarehouseSync() {
        Test.setMock(HttpCalloutMock.class, new WarehouseCalloutServiceMock());
        Test.startTest();
        String jobId = System.schedule('WarehouseSyncSchedule',
                                       CRON_EXP,
                                       new WarehouseSyncSchedule());
        CronTrigger ct = [SELECT Id, CronExpression, TimesTriggered, NextFireTime
                          FROM CronTrigger
                          WHERE id = :jobId];
        System.assertEquals(CRON_EXP, ct.CronExpression);
        System.assertEquals(0, ct.TimesTriggered);
        Test.stopTest();
    }
    private static Vehicle__c createVehicle() {
        Vehicle__c v = new Vehicle__c(Name = STRING_TEST);
        return v;
    }
    private static Product2 createEquipment() {
        Product2 p = new Product2(Name = STRING_TEST,
                                  Lifespan_Months__c = 10,
                                  Maintenance_Cycle__c = 10,
                                  Replacement_Part__c = true);
        return p;
    }
    private static Case createMaintenanceRequest(Id vehicleId, Id equipmentId) {
        Case c = new Case(Type = REPAIR,
                          Status = NEW_STATUS,
                          Origin = REQUEST_ORIGIN,
                          Subject = REQUEST_SUBJECT,
                          Equipment__c = equipmentId,
                          Vehicle__c = vehicleId);
        return c;
    }
    private static Work_Part__c createWorkPart(Id equipmentId, Id requestId) {
        Work_Part__c wp = new Work_Part__c(Equipment__c = equipmentId,
                                           Maintenance_Request__c = requestId);
        return wp;
    }
}


public with sharing class MaintenanceRequestHelper {
public static void updateWorkOrders(List<case> caseList) {
List<case> newCases = new List<case>();
Map<String,Integer> result=getDueDate(caseList);
for(Case c : caseList){
if(c.status=='closed')
if(c.type=='Repair' || c.type=='Routine Maintenance'){
Case newCase = new Case();
newCase.Status='New';
newCase.Origin='web';
newCase.Type='Routine Maintenance';
newCase.Subject='Routine Maintenance of Vehicle';
newCase.Vehicle__c=c.Vehicle__c;
newCase.Equipment__c=c.Equipment__c;
newCase.Date_Reported__c=Date.today();
if(result.get(c.Id)!=null)
newCase.Date_Due__c=Date.today()+result.get(c.Id);
else
newCase.Date_Due__c=Date.today();
newCases.add(newCase);
}
}
insert newCases;
}
//
public static  Map<String,Integer> getDueDate(List<case> CaseIDs){
Map<String,Integer> result = new Map<String,Integer>();
Map<Id, case> caseKeys = new Map<Id, case> (CaseIDs);
List<aggregateresult> wpc=[select Maintenance_Request__r.ID cID,min(Equipment__r.Maintenance_Cycle__c)cycle
from Work_Part__c where  Maintenance_Request__r.ID in :caseKeys.keySet() group by             Maintenance_Request__r.ID ];
for(AggregateResult res :wpc){
Integer addDays=0;
if(res.get('cycle')!=null)
addDays+=Integer.valueOf(res.get('cycle'));
result.put((String)res.get('cID'),addDays);
}
return result;
}
}


@isTest
public  class MaintenanceRequestTest {
     static  List<case> caseList1 = new List<case>();
   static List<product2> prodList = new List<product2>();
       static List<work_part__c> wpList = new List<work_part__c>();
@testSetup
    static void getData(){
      caseList1= CreateData( 300,3,3,'Repair');
    }
    public static List<case>   CreateData( Integer numOfcase, Integer numofProd, Integer numofVehicle,
                                String type){
 List<case> caseList = new List<case>();
        //Create Vehicle
        Vehicle__c vc = new Vehicle__c();
        vc.name='Test Vehicle';
        upsert vc;
        //Create Equiment
        for(Integer i=0;i<numofProd;i++){
            Product2 prod = new Product2();
            prod.Name='Test Product'+i;
            if(i!=0)
             prod.Maintenance_Cycle__c=i;
            prod.Replacement_Part__c=true;
            prodList.add(prod);
        }
        upsert  prodlist;
        //Create Case
        for(Integer i=0;i< numOfcase;i++){
            Case newCase = new Case();
           newCase.Status='New';
                 newCase.Origin='web';
            if( math.mod(i, 2) ==0)
             newCase.Type='Routine Maintenance';
            else
               newCase.Type='Repair';
            newCase.Subject='Routine Maintenance of Vehicle' +i;
            newCase.Vehicle__c=vc.Id;
            if(i<numofProd)
             newCase.Equipment__c=prodList.get(i).ID;
            else
                newCase.Equipment__c=prodList.get(0).ID;
           caseList.add(newCase);
        }
    upsert caseList;
     for(Integer i=0;i<numofProd;i++){
         Work_Part__c wp = new Work_Part__c();
          wp.Equipment__c   =prodlist.get(i).Id   ;
          wp.Maintenance_Request__c=caseList.get(i).id;
          wplist.add(wp) ;
          }
    upsert wplist;
        return caseList;
    }
    public static testmethod void testMaintenanceHelper(){
        Test.startTest();
        getData();
            for(Case cas: caseList1)
                 cas.Status ='Closed';
        update caseList1;
        Test.stopTest();
    }
}

@IsTest
private class WarehouseCalloutServiceTest {
    // implement your mock callout test here
    @isTest
    static void testWareHouseCallout(){
        Test.setMock(HttpCalloutMock.class, new WarehouseCalloutServiceMock());
       WarehouseCalloutService.runWarehouseEquipmentSync();
    }
}

@isTest
public class WarehouseCalloutServiceMock implements HTTPCalloutMock {
    // implement http mock callout
    public HTTPResponse respond (HttpRequest request){
        HttpResponse response = new HTTPResponse();
        response.setHeader('Content-type','application/json');
        response.setBody('[{"_id":"55d66226726b611100aaf741","replacement":false,"quantity":5,"name":"Generator 1000 kW","maintenanceperiod":365,"lifespan":120,"cost":5000,"sku":"100003"},{"_id":"55d66226726b611100aaf742","replacement":true,"quantity":183,"name":"Cooling Fan","maintenanceperiod":0,"lifespan":0,"cost":300,"sku":"100004"},{"_id":"55d66226726b611100aaf743","replacement":true,"quantity":143,"name":"Fuse 20A","maintenanceperiod":0,"lifespan":0,"cost":22,"sku":"100005"}]');
        response.setStatusCode(200);
        return response;
    }
}

@isTest
private class WarehouseSyncScheduleTest {
 public static String CRON_EXP = '0 0 0 15 3 ? 2022';
    static testmethod void testjob(){
         MaintenanceRequestTest.CreateData( 5,2,2,'Repair');
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new WarehouseCalloutServiceMock());
        String joBID= System.schedule('TestScheduleJob', CRON_EXP, new WarehouseSyncSchedule());
       // List<Case> caselist = [Select count(id) from case where case]
        Test.stopTest();
    }
}



public with sharing class WarehouseCalloutService implements Queueable, Database.AllowsCallouts {
    public List<Product2> equip = new List<Product2>();

    private static final String WAREHOUSE_URL = 'https://th-superbadge-apex.herokuapp.com/equipment';
    
    public void execute(QueueableContext context){
        Http h = new Http();
        HttpRequest httpReq = new HttpRequest();
        httpReq.setMethod('GET');
        httpReq.setHeader('Content-Type', 'application/json');
        httpReq.setEndpoint(WAREHOUSE_URL);
        httpResponse res = h.send(httpReq);
        List<Object> results = (List<Object>) JSON.deserializeUntyped(res.getBody());
        System.debug(results.size());
        
        for(Object fld : results){
            system.debug('list got updated.Size: '+equip.size());
            Map<String, Object> productMap = (Map<String, Object>) fld;
            Product2 pr = new Product2();
            //Map the fields in the response to the appropriate fields in the Equipment object
            pr.Replacement_Part__c = (Boolean)productMap.get('replacement');
            pr.Cost__c = (Integer)productMap.get('cost');
            pr.Current_Inventory__c = (Integer)productMap.get('quantity');
            pr.Lifespan_Months__c = (Integer)productMap.get('lifespan') ;
            pr.Maintenance_Cycle__c = (Integer)productMap.get('maintenanceperiod');
            pr.Warehouse_SKU__c = (String)productMap.get('sku');
            pr.ProductCode = (String)productMap.get('_id');
            pr.Name = (String)productMap.get('name');
            
            equip.add(pr);
            system.debug('list got updated.Size: '+equip.size());
            
        }
        if(!equip.isEmpty()){
            upsert equip Warehouse_SKU__c;
            system.debug('list got updated.Size: '+equip.size());
        }
            
    }
    
}

global with sharing class WarehouseSyncSchedule implements Schedulable{
    // implement scheduled code here
    global void execute(SchedulableContext sc){
         //String sch = '00 00 01 * * ?';//on 1 pm
         //System.schedule('WarehouseSyncScheduleTest', sch, new WarehouseSyncSchedule());
        System.enqueueJob(new WarehouseCalloutService());
        
    }
}








