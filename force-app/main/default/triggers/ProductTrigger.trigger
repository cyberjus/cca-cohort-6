trigger ProductTrigger on Product2(after insert) {
  ProductIntegration.syncNewProducts(Trigger.newMap.keySet());

}
