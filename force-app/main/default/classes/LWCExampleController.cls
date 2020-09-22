public inherited sharing class LWCExampleController {

    @AuraEnabled
    public static list<Commande__c> readCSVFile(Id idContentDocument){
        list<Commande__c> lstcommToInsert = new list<Commande__c>();
        if(idContentDocument != null) {
            
            // getting File Data based on document id 
            ContentVersion objVersion = [SELECT Id, VersionData FROM ContentVersion WHERE ContentDocumentId =:idContentDocument];
            // split the file data
            list<String> lstCSVLines = objVersion.VersionData.toString().split('\n');

            for(Integer i = 1; i < lstCSVLines.size(); i++){
                Commande__c objcomm = new Commande__c();
                list<String> csvRowData = lstCSVLines[i].split(',');
                System.debug('csvRowData====> '+csvRowData);
                //objAcc.Name = csvRowData[0]; // accName
                //objAcc.Industry = csvRowData[1];
                //objAcc.Rating = csvRowData[2];
               // objAcc.Type = csvRowData[3];
               // objAcc.Website = csvRowData[4];
               objcomm.Name	= csvRowData[22] ;  
               objcomm.Type__c	= csvRowData[2] ;  
               objcomm.Date__c =  date.parse(csvRowData[3]);   
                //accObj.Start__c =  date.parse(csvRowData[4]) ;  
                // accObj.End__c = csvRowData[5] ;  
                objcomm.Labels__c = csvRowData[6] ;  
                //accObj.quantity__c =  Integer.valueOf(csvRowData[7]) ;  
                //accObj.Item_code__c = csvRowData[8] ;  
                //accObj.Ref_commande__c = csvRowData[22] ;  
                //accObj.Ref2__c = csvRowData[23] ;   
                lstcommToInsert.add(objcomm);
            }

            try{    
                if(!lstcommToInsert.isEmpty()) {
                    insert lstcommToInsert;
                }
            }
            catch (Exception ex) {
                throw new AuraHandledException(ex.getMessage());
            } 
        }
        return lstcommToInsert;    
    }
}
