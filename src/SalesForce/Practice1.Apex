//Variable declaration
integer a;
integer b;
integer sum;
integer multiply;

a=10;
b=40;

sum=a+b;
multiply=a*b;
system.debug('Multiplication ='+multiply);
system.debug('Sum ='+sum);

integer varC;
integer varC=18;
integer varD;
integer varD=2;
integer varSubstract;
integer varDivision;
varSubstract=varC-varD;
varDivision=varC/varD;
system.debug('Substraction of '+varC+ ' and '+varD+' = '+varSubstract);
system.debug('Division of '+varC+ ' and '+varD+ ' = '+varDivision);

integer varAge;
varAge=15;
if(varAge>=18){
    system.debug('Congrats you can vote!');
}else{
    system.debug('Sorry you cannot vote');
}

integer VarMarks;
Double VarPrice=123.4567456;
VarMarks=98;
if(VarMarks<40){
    system.debug('Sorry you are failed');    
}else if(VarMarks>74){
    system.debug('Grade A');
}else if((VarMarks>=40)&&(VarMarks<=74)){
    system.debug('Grade B');
}

system.debug('MATH ROUND OF THE NUMBER '+MATH.round(VarPrice));
system.debug('MATH ROUND OF THE NUMBER '+MATH.round(VarPriceDeci));


integer VarNum;
VarNum=0;
while(VarNum<20){
    system.debug('I Love my Country');
    VarNum++;
}

integer VarNumber;
for(VarNumber=1;VarNumber<=20;VarNumber++){
   system.debug('I Love my Country'); 
    
    system.debug('I can\'t give up in Salesforce coding!');
}

integer VarNumber1;
for(VarNumber1=50;VarNumber1<=69;VarNumber1++){
   system.debug('I Love my Country!-'+VarNumber1); 
    
   
}

list<string> varName= new list<string>();
system.debug('hjghjg'+varName);
//Employee salary collection
list<integer> VarSalaryList= new list<integer>();
VarSalaryList.add(2000);
VarSalaryList.add(3000);
VarSalaryList.add(4000);
system.debug('Emp Salry'+VarSalaryList);
integer VarSal = VarSalaryList.get(1);
system.debug('Getting value at index 1: '+VarSal);
VarSalary.set(0,5000);
system.debug('Getting value at index 1: '+VarSalaryList );
VarSalary.clear();
system.debug('Getting value: '+VarSalaryList );
VarSalaryList.add(2000);
VarSalaryList.add(3000);
VarSalaryList.add(4000);
VarSalaryList.remove(1);
system.debug('value after remove: '+VarSalaryList );
integer VarListLength=VarSalaryList.size();
system.debug('value of length : '+VarListLength );

for(integer varSa:VarSalaryList){
    system.debug('value of sal : '+varSa);
}
list<string> VarNamelist =new list<string>();
VarNamelist.add('Radhika');
VarNamelist.add('Mahipal');
for(string VarName:VarNamelist){
    system.debug('Values in the String: '+VarName);
}
