Class TimeTracker.Category Extends %Persistent
{

Property Name As %String;

ClassMethod AddCategory(pName) As TimeTracker.Category
{
    Set tCategory=##class(TimeTracker.Category).%New()
    Set tCategory.Name=pName
    Set tSC=tCategory.%Save()
    
    If tSC {
        Return tCategory
    } Else {
        Return ""
    }
}

Storage Default
{
<Data name="CategoryDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>Name</Value>
</Value>
</Data>
<DataLocation>^TimeTracker.CategoryD</DataLocation>
<DefaultData>CategoryDefaultData</DefaultData>
<IdLocation>^TimeTracker.CategoryD</IdLocation>
<IndexLocation>^TimeTracker.CategoryI</IndexLocation>
<StreamLocation>^TimeTracker.CategoryS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
