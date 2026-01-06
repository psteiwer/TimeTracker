Class TimeTracker.Task Extends %Persistent
{

Property Day As %Date;

Property StartTime As %Time;

Property Task As %String;

Property Category As %String;

Property IsWork As %Boolean;

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
</Data>
<DataLocation>^TimeTracker.TaskD</DataLocation>
<DefaultData>TaskDefaultData</DefaultData>
<IdLocation>^TimeTracker.TaskD</IdLocation>
<IndexLocation>^TimeTracker.TaskI</IndexLocation>
<StreamLocation>^TimeTracker.TaskS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
