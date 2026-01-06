Class TimeTracker.REST.impl Extends %CSP.REST
{

ClassMethod getTasks(pWhere As %DynamicObject) As %DynamicArray
{
    Set tSC = $$$OK
    Set tResponse = []
    Set tSQL="SELECT JSON_OBJECT('id':%ID,'day':Day,'starttime':StartTime,'task':Task,'category':Category,'iswork':IsWork) AS t FROM TimeTracker.Task"
    Set tValArray=""
    Set tWhere=""
    Set pWhere={}.%FromJSON(pWhere)
    If $ISOBJECT(pWhere) && $ISOBJECT(pWhere.filters) {
        Set tWhereIterator = pWhere.filters.%GetIterator()
        While tWhereIterator.%GetNext(.key,.val) {
            Set tFilterIterator = val.%GetIterator()
            Do tFilterIterator.%GetNext(.filterName,.filterValue)
            If ##class(%Dictionary.CompiledProperty).%ExistsId("TimeTracker.Task||"_filterName) {
                If filterValue="" {
                    Set tWhere = $select(tWhere="":" WHERE ",1:" AND ")_"(("_filterName_"= '' ) OR ("_filterName_" IS NULL))"
                } Else {
                    Set tWhere = $select(tWhere="":" WHERE ",1:" AND ")_filterName_"= ?"
                    Set tValArray($i(tValArray)) = filterValue
                }
            }
        }
    }
    Set tSQL = tSQL_tWhere
    Set tSQL=tSQL_" ORDER BY StartTime"
    Set tSQLRS=##class(%SQL.Statement).%ExecDirect(,.tSQL,tValArray...)
    While tSQLRS.%Next() {
        Set tRow = tSQLRS.%Get("t")
        Do tResponse.%Push({}.%FromJSON(tRow))
    }
    Quit tResponse
}

ClassMethod getTask(tId) As %DynamicObject
{
    Set tWhere = {"filters": [{"%ID": (tId)}]}
    Quit ..getTasks(tWhere).%Pop()
}

ClassMethod updateTask(tId As %String, pData As %DynamicObject) As %DynamicObject
{
    Set tTask = ##class(TimeTracker.Task).%OpenId(tId)
    If tTask="" {
        Set tSC = $$$ERROR($$$GeneralError,"Task not found")
        Quit tSC
    }
    Set tSC = $$$OK
    Set tUpdatableProps = $LB("Day","Task","Category")
    Set tPropIterator = pData.%GetIterator()
    While tPropIterator.%GetNext(.key,.val) {
        If $LISTFIND(tUpdatableProps,key) {
            Set $PROPERTY(tTask,key) = val
        }
    }
    Set tSC = tTask.%Save()
    Quit {"status": ($SYSTEM.Status.GetErrorText(tSC))}
}

ClassMethod addTask(pData As %DynamicObject) As %DynamicObject
{
    Set tSC = $$$OK
    Set tSC= ##class(TimeTracker.Task).AddTask(
        pData.%Get("day")
    )
    Quit {"status": ($SYSTEM.Status.GetErrorText(tSC))}
}

ClassMethod deleteTask(tId) As %DynamicObject
{
    Set tSC = ##class(TimeTracker.Task).%DeleteId(tId)
    Set tResponse = {"status": ($SYSTEM.Status.GetErrorText(tSC))}
    Quit tResponse
}

}
