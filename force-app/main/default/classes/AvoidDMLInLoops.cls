public with sharing class AvoidDMLInLoops {
  // Dedupe List of Leads and Add to Campaign
  /*public static void importLeads(Id campaignId, List<Lead> leads) {
    List<CampaignMember> campaignMembers = new List<CampaignMember>();

    for (Lead lead : leads) {
      // Find Existing Lead
      List<Lead> existing = [SELECT Id FROM Lead WHERE Email = :lead.Email];

      if (existing.isEmpty()) {
        insert lead;
      } else {
        lead.Id = existing.get(0).Id;
      }

      campaignMembers.add(
        new CampaignMember(
          CampaignId = campaignId,
          LeadId = lead.Id,
          Status = 'Responded'
        )
      );
    }

    upsert leads;
    insert campaignMembers;
  }*/

  public static void importLeads(Id campaignId, List<Lead> leads) {

    // Get Lead Emails
    Set<String> emails = new Set<String>();
    for (Lead lead : leads) {
        if (!String.isBlank(lead.Email)) emails.add(lead.Email);
    }

    // Map of Existing by Email Address
    Map<String, Lead> existingLeadMap = new Map<String, Lead>();
    for (Lead existingLead : [SELECT Id, Email FROM Lead WHERE Email in :emails]) {
        existingLeadMap.put(existingLead.Email, existingLead);
    }
    
    // Set the id of existing leads
    for (Lead lead : leads) {
      if (existingLeadMap.containsKey(lead.Email)) {
        lead.Id = existingLeadMap.get(lead.Email).Id;
      }
    }

    upsert leads;

     // Create Campaign Members
     List<CampaignMember> campaignMembers = new List<CampaignMember>();
     for (Lead lead : leads) {
       campaignMembers.add(
         new CampaignMember(
           CampaignId = campaignId,
           LeadId = lead.Id,
           Status = 'Responded'
         )
       );
     }
     insert campaignMembers;


  }

 
}
