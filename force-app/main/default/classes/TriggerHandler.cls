/*
 * This is a general-purpose Trigger Framework designed to handle various trigger contexts like
 * before insert, after insert, before update, etc.
 * This framework provides a structured way to handle these operations and is designed to be 
 * extensible, so developers can add more functionalities as needed.
 * 
 * IMPORTANT: This file is a foundational piece of code. It should NOT be edited directly. 
 * Instead, extend this class to add more specific trigger functionalities.
 * 
 * Once the framework on your local machine, save and deploy this file into your Salesforce org.
 * 
 * Source: https://github.com/kevinohara80/sfdc-trigger-framework/tree/master
 */
public virtual class TriggerHandler {

    // Keeps track of how many times the run() method was invoked for each handler
    private static Map<String, LoopCount> loopCountMap;

    // List of handler names that should not be executed
    private static Set<String> bypassedHandlers;
    
    // Represents the current context in which the trigger is executing (e.g., before insert, after update, etc.)
    @TestVisible
    private TriggerContext context;
    
    // Indicates if the trigger is currently executing
    @TestVisible
    private Boolean isTriggerExecuting;
    
    // Initialization of static variables
    static {
      loopCountMap = new Map<String, LoopCount>();
      bypassedHandlers = new Set<String>();
    }
    
    // Constructor initializes the trigger context
    public TriggerHandler() {
      this.setTriggerContext();
    }
    
    /***************************************
     * public instance methods
     ***************************************/
    
    // Main method that handles the trigger execution
    public void run() {
      
    
      // Check if the trigger should continue execution
      if(!validateRun()) {
          return;
      }
  
      // Increment the count of how many times this handler has run
      addToLoopCount();
  
      // Dispatch execution to the appropriate handler method based on the trigger context
      switch on this.context {
          when BEFORE_INSERT {
          this.beforeInsert();
          }
          when BEFORE_UPDATE {
          this.beforeUpdate();
          }
          when BEFORE_DELETE {
          this.beforeDelete();
          }
          when AFTER_INSERT {
          this.afterInsert();
          }
          when AFTER_UPDATE {
          this.afterUpdate();
          }
          when AFTER_DELETE {
          this.afterDelete();
          }
          when AFTER_UNDELETE {
          this.afterUndelete();
          }
      }
    }
    
    // Set the maximum number of times the handler can run
    public void setMaxLoopCount(Integer max) {
      String handlerName = getHandlerName();
      if(!TriggerHandler.loopCountMap.containsKey(handlerName)) {
        TriggerHandler.loopCountMap.put(handlerName, new LoopCount(max));
      } else {
        TriggerHandler.loopCountMap.get(handlerName).setMax(max);
      }
    }
    
    // Clear the maximum loop count for the handler
    public void clearMaxLoopCount() {
      this.setMaxLoopCount(-1);
    }
    
    /***************************************
     * public static methods
     ***************************************/
    
    // Bypass a particular handler from execution
    public static void bypass(String handlerName) {
        TriggerHandler.bypassedHandlers.add(handlerName);
    }

    // Allow a previously bypassed handler to execute
    public static void clearBypass(String handlerName) {
        TriggerHandler.bypassedHandlers.remove(handlerName);
    }

    // Check if a handler is bypassed
    public static Boolean isBypassed(String handlerName) {
        return TriggerHandler.bypassedHandlers.contains(handlerName);
    }

    // Clear all bypassed handlers
    public static void clearAllBypasses() {
        TriggerHandler.bypassedHandlers.clear();
    }
    
    /***************************************
     * private instancemethods
     ***************************************/
    
    // Set the trigger's execution context
    @TestVisible
    private void setTriggerContext() {
      this.setTriggerContext(null, false);
    }
    
    // Detailed method to determine and set the trigger's execution context
    @TestVisible
    private void setTriggerContext(String ctx, Boolean testMode) {
        if(!Trigger.isExecuting && !testMode) {
            this.isTriggerExecuting = false;
            return;
        } else {
            this.isTriggerExecuting = true;
        }
        
        if((Trigger.isExecuting && Trigger.isBefore && Trigger.isInsert) ||
            (ctx != null && ctx == 'before insert')) {
            this.context = TriggerContext.BEFORE_INSERT;
        } else if((Trigger.isExecuting && Trigger.isBefore && Trigger.isUpdate) ||
            (ctx != null && ctx == 'before update')){
            this.context = TriggerContext.BEFORE_UPDATE;
        } else if((Trigger.isExecuting && Trigger.isBefore && Trigger.isDelete) ||
            (ctx != null && ctx == 'before delete')) {
            this.context = TriggerContext.BEFORE_DELETE;
        } else if((Trigger.isExecuting && Trigger.isAfter && Trigger.isInsert) ||
            (ctx != null && ctx == 'after insert')) {
            this.context = TriggerContext.AFTER_INSERT;
        } else if((Trigger.isExecuting && Trigger.isAfter && Trigger.isUpdate) ||
            (ctx != null && ctx == 'after update')) {
            this.context = TriggerContext.AFTER_UPDATE;
        } else if((Trigger.isExecuting && Trigger.isAfter && Trigger.isDelete) ||
            (ctx != null && ctx == 'after delete')) {
            this.context = TriggerContext.AFTER_DELETE;
        } else if((Trigger.isExecuting && Trigger.isAfter && Trigger.isUndelete) ||
            (ctx != null && ctx == 'after undelete')) {
            this.context = TriggerContext.AFTER_UNDELETE;
        }
    }
    
    // Increment how many times the handler has been run
    @TestVisible
    private void addToLoopCount() {
      String handlerName = getHandlerName();
      if(TriggerHandler.loopCountMap.containsKey(handlerName)) {
        Boolean exceeded = TriggerHandler.loopCountMap.get(handlerName).increment();
        if(exceeded) {
          Integer max = TriggerHandler.loopCountMap.get(handlerName).max;
          throw new TriggerHandlerException('Maximum loop count of ' + String.valueOf(max) + ' reached in ' + handlerName);
        }
      }
    }
    
    // Verify that the trigger should execute
    @TestVisible
    private Boolean validateRun() {
      if(!this.isTriggerExecuting || this.context == null) {
        throw new TriggerHandlerException('Trigger handler called outside of Trigger execution');
      }
      return !TriggerHandler.bypassedHandlers.contains(getHandlerName());
    }
    
    // Get the name of the handler that's currently executing
    @TestVisible
    private String getHandlerName() {
      return String.valueOf(this).substring(0,String.valueOf(this).indexOf(':'));
    }
    
    /***************************************
     * context methods
     ***************************************/
    
    // These are virtual methods that can be overridden in child classes 
    // to provide specific functionalities for different trigger contexts.
    @TestVisible
    protected virtual void beforeInsert(){}
    @TestVisible
    protected virtual void beforeUpdate(){}
    @TestVisible
    protected virtual void beforeDelete(){}
    @TestVisible
    protected virtual void afterInsert(){}
    @TestVisible
    protected virtual void afterUpdate(){}
    @TestVisible
    protected virtual void afterDelete(){}
    @TestVisible
    protected virtual void afterUndelete(){}
    
    /***************************************
     * inner classes
     ***************************************/
    
    // LoopCount manages how many times a handler is allowed to run. 
    // This is to prevent infinite loops or excessive operations that could hit governor limits.
    @TestVisible
    private class LoopCount {
      private Integer max;
      private Integer count;
    
      public LoopCount() {
        this.max = 5;
        this.count = 0;
      }
    
      public LoopCount(Integer max) {
        this.max = max;
        this.count = 0;
      }
    
      public Boolean increment() {
        this.count++;
        return this.exceeded();
      }
    
      public Boolean exceeded() {
        return this.max >= 0 && this.count > this.max;
      }
    
      public Integer getMax() {
        return this.max;
      }
    
      public Integer getCount() {
        return this.count;
      }
    
      public void setMax(Integer max) {
        this.max = max;
      }
    }
    
    // This enum represents possible trigger contexts, making it easier to identify the current operation.
    @TestVisible
    private enum TriggerContext {
      BEFORE_INSERT, BEFORE_UPDATE, BEFORE_DELETE,
      AFTER_INSERT, AFTER_UPDATE, AFTER_DELETE,
      AFTER_UNDELETE
    }
    
    // Custom exception to handle specific errors related to the trigger handler.
    public class TriggerHandlerException extends Exception {}
    
    }