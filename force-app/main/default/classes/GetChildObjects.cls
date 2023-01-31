public class GetChildObjects {
   
    @auraEnabled
    public static List<Map<String,String>> getChildSobjects(Id sObjectName)
    {
        List<Map<String,String>> childObjects = new List<Map<String,String>>();
        
        String linkedObjects = 'Account, Accreditation, ActivationTarget, ActivationTrgtIntOrgAccess, ApiAnomalyEventStore, AssessmentIndicatorDefinition, AssessmentTask, AssessmentTaskContentDocument, AssessmentTaskDefinition, AssessmentTaskIndDefinition, AssessmentTaskOrder, Asset, AssetRelationship, AssignedResource, Award, BoardCertification, BusinessLicense, BusinessMilestone, BusinessProfile, Campaign, CareBarrier, CareBarrierDeterminant, CareBarrierType, CareDeterminant, CareDeterminantType, CareDiagnosis, CareInterventionType, CareMetricTarget, CareObservation, CareObservationComponent, CarePgmProvHealthcareProvider, CarePreauth, CarePreauthItem, CareProgram, CareProgramCampaign, CareProgramEligibilityRule, CareProgramEnrollee, CareProgramEnrolleeProduct, CareProgramEnrollmentCard, CareProgramGoal, CareProgramProduct, CareProgramProvider, CareProgramTeamMember, CareProviderAdverseAction, CareProviderFacilitySpecialty, CareProviderSearchableField, CareRegisteredDevice, CareRequest, CareRequestDrug, CareRequestExtension, CareRequestItem, CareSpecialty, CareSpecialtyTaxonomy, CareTaxonomy, Case, CodeSet, CollaborationGroup, CommSubscription, CommSubscriptionChannelType, CommSubscriptionConsent, CommSubscriptionTiming, ConsumptionSchedule, Contact, ContactEncounter, ContactEncounterParticipant, ContentWorkspace, Contract, ConversationEntry, CoverageBenefit, CoverageBenefitItem, CredentialStuffingEventStore, CreditMemo, CreditMemoLine, Dashboard, DashboardComponent, DataStream, DelegatedAccount, DocumentChecklistItem, EmailMessage, EmailTemplate, EngagementChannelType, EnhancedLetterhead, EnrollmentEligibilityCriteria, Event, HealthcareFacility, HealthcareFacilityNetwork, HealthcarePayerNetwork, HealthcarePractitionerFacility, HealthcareProvider, HealthcareProviderNpi, HealthcareProviderSpecialty, HealthcareProviderTaxonomy, Identifier, Image, IndividualApplication, Invoice, InvoiceLine, Lead, ListEmail, Location, MarketSegment, MarketSegmentActivation, MemberPlan, MessagingSession, MktCalculatedInsight, OperatingHours, Opportunity, Order, OrderItem, Organization, OtherComponentTask, OutgoingEmail, PartyConsent, PersonEducation, PersonLanguage, PersonLifeEvent, PersonName, PlanBenefit, PlanBenefitItem, Product2, ProductFulfillmentLocation, ProductItem, ProductItemTransaction, ProductRequest, ProductRequestLineItem, ProductRequired, ProductTransfer, ProfileSkill, ProfileSkillEndorsement, ProfileSkillUser, ProviderSearchSyncLog, PurchaserPlan, PurchaserPlanAssn, ReceivedDocument, Report, ReportAnomalyEventStore, ResourceAbsence, ResourcePreference, ReturnOrder, ReturnOrderLineItem, ServiceAppointment, ServiceResource, ServiceResourceSkill, ServiceTerritory, ServiceTerritoryMember, ServiceTerritoryWorkType, SessionHijackingEventStore, Shift, Shipment, ShipmentItem, Site, SkillRequirement, SocialPost, Solution, Task, ThreatDetectionFeedback, Topic, User, Visit, VisitedParty, Visitor, VoiceCall, VolunteerProject, WorkBadgeDefinition, WorkOrder, WorkOrderLineItem, WorkType, WorkTypeGroup, WorkTypeGroupMember';
        Schema.DescribeSObjectResult R = sObjectName.getSObjectType().getDescribe();
		for (Schema.ChildRelationship cr: R.getChildRelationships()) {
    	if(cr.getRelationshipName() != null && ( linkedObjects.contains(String.valueOf(cr.getChildSObject())) || cr.getRelationshipName().endsWith('__r'))) {
       	 	System.debug(cr);
        	system.debug('====child object==='+cr.getChildSObject());
            Map<String,String> childMap = new Map<String,String>();
            childMap.put( 'value',String.ValueOf(cr.getRelationshipName()));
            childMap.put( 'label',String.ValueOf(cr.getRelationshipName()));
            childObjects.add(childMap);
            
           // childObjects.add('{"value": "'+String.ValueOf(cr.getRelationshipName())  +'", "label": "'+String.ValueOf(cr.getChildSObject())+' ('+String.ValueOf(cr.getRelationshipName()) +')"}');
        }
}
        return childObjects;	
    }

}