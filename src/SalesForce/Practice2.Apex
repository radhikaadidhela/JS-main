
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
system.debug('The Current set'+VarProdCodeSet)

//size
system.debug('The Current set '+VarProdCodeSet.size());