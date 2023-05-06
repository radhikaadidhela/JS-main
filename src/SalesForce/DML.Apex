Parker_Pen__c varPen=New Parker_Pen__c();
varPen.Name='Tom';
varPen.Price__c=1212;
insert varPen;

//Account varAcc=New Account();
List<Account> varAccList=New List<Account>();
varAccList = [SELECT id,Website FROM Account WHERE Name LIKE'%Amazon%'];
for(Account acc:varAccList){
    acc.Website='www.amazon.com';
}


update varAccList;


