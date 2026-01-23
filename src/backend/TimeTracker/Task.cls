Class TimeTracker.Task Extends %Persistent
{

Parameter DSTIME = "auto";

Property Day As %Date;

Property StartTime As %Time;

Property Duration As %Integer;

Property Task As %String;

Property Category As TimeTracker.Category;

Property IsWork As %Boolean;

ClassMethod UpdateTask(pId, pObj) As %Status
{
    Set tSC=$$$OK

    Set tTask=##class(TimeTracker.Task).%OpenId(pId)
    Set:pObj.day tTask.Day=$zdh(pObj.day,3)
    Set:pObj.start tTask.StartTime=$zth(pObj.start,3)
    Set:pObj.duration tTask.Duration=pObj.duration
    Set:pObj.task tTask.Task=pObj.task
    Do:pObj.category tTask.CategorySetObjectId(pObj.category)
    Set:pObj.isWork tTask.IsWork=pObj.isWork
    Set tSC=tTask.%Save()

    Return tSC
}

ClassMethod AddTask(pDay, pStartTime, pDuration, pTask, pCategory, pIsWork) As TimeTracker.Task
{
    Set tRet=""

    Set tTask=##class(TimeTracker.Task).%New()
    Set tTask.Day=$zdh(pDay,3)
    Set tTask.StartTime=$zth(pStartTime,3)
    Set tTask.Duration=pDuration
    Set tTask.Task=pTask
    Do tTask.CategorySetObjectId(pCategory)
    Set tTask.IsWork=pIsWork
    Set tSC=tTask.%Save()
    
    If tSC {
        Set tRet=tTask
    }
    Return tRet
}

ClassMethod GetTasksSummary(pWhere As %DynamicObject) As %DynamicObject
{
    Set tSummary={}
    Set tTasks=##class(TimeTracker.REST.impl).getTasks(pWhere)
    Set tTasksIterator=tTasks.%GetIterator()
    While tTasksIterator.%GetNext(.key,.val) {
        Set tTime=$PROPERTY(tSummary,val.task)
        zw tTime
        Set $PROPERTY(tSummary,val.task)=$i(tTime,val.duration)
        zw $PROPERTY(tSummary,val.task)
    }
    Return tSummary
}

Storage Default
{
<Data name="TaskDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>Day</Value>
</Value>
<Value name="3">
<Value>StartTime</Value>
</Value>
<Value name="4">
<Value>Task</Value>
</Value>
<Value name="5">
<Value>Category</Value>
</Value>
<Value name="6">
<Value>IsWork</Value>
</Value>
<Value name="7">
<Value>Duration</Value>
</Value>
</Data>
<DataLocation>^TimeTracker.TaskD</DataLocation>
<DefaultData>TaskDefaultData</DefaultData>
<IdLocation>^TimeTracker.TaskD</IdLocation>
<IndexLocation>^TimeTracker.TaskI</IndexLocation>
<StreamLocation>^TimeTracker.TaskS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
