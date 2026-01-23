Class TimeTracker.REST.impl Extends %CSP.REST
{

ClassMethod getTasks(pWhere As %DynamicObject) As %DynamicArray
{
    Set tSC = $$$OK
    Set tResponse = []
    Set tSQL="SELECT JSON_OBJECT('id':%ID,'day':%ODBCOUT(Day),'start':$EXTRACT(%External(StartTime),1,5),'duration':Duration,'task':Task,'category':Category,'isWork':IsWork) AS t FROM TimeTracker.Task"
    Set tValArray=""
    Set tWhere=""
    If $ISOBJECT(pWhere) && $ISOBJECT(pWhere.filters) {
        Set tWhereIterator = pWhere.filters.%GetIterator()
        While tWhereIterator.%GetNext(.key,.val) {
            Set tFilterIterator = val.%GetIterator()
            Do tFilterIterator.%GetNext(.filterName,.filterValue)
            Set filterName=$ZCONVERT($E(filterName,1),"U")_$E(filterName,2,*)
            If ##class(%Dictionary.CompiledProperty).%ExistsId("TimeTracker.Task||"_filterName) || (filterName="%ID") {
                If filterValue="" {
                    Set tWhere = tWhere_$select(tWhere="":" WHERE ",1:" AND ")_"(("_filterName_"= '' ) OR ("_filterName_" IS NULL))"
                } ElseIf $ISOBJECT(filterValue) && filterValue.%IsA("%DynamicObject") { 
                    Set tDynamicIterator=filterValue.%GetIterator()
                    While tDynamicIterator.%GetNext(.dynKey,.dynVal) {
                        Set tWhere = tWhere_$select(tWhere="":" WHERE ",1:" AND ")_filterName_"->"_dynKey_"= ?"
                        Set tValArray($i(tValArray)) = dynVal
                    }
                } ElseIf $ISOBJECT(filterValue) && filterValue.%IsA("%DynamicArray") { 
                    Set tInList=""
                    Set tDynamicIterator=filterValue.%GetIterator()
                    While tDynamicIterator.%GetNext(.dynKey,.dynVal) {
                        If filterName="Day" {
                            Set dynVal=$zdh(dynVal,3)
                        }
                        Set tInList=tInList_$lb(dynVal)
                    }
                    Set tWhere = tWhere_$select(tWhere="":" WHERE ",1:" AND ")_filterName_" %INLIST ?"
                    Set tValArray($i(tValArray)) = tInList
                } Else {
                    If filterName="Day" {
                        Set filterValue=$zdh(filterValue,3)
                    }
                    Set tWhere = tWhere_$select(tWhere="":" WHERE ",1:" AND ")_filterName_"= ?"
                    Set tValArray($i(tValArray)) = filterValue
                }
            }
        }
    }
    Set tSQL = tSQL_tWhere
    Set tSQL=tSQL_" ORDER BY Day,StartTime"
    Set tSQLRS=##class(%SQL.Statement).%ExecDirect(,tSQL,tValArray...)
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
    Set tSC = $$$OK
    Set pData={}.%FromJSON(pData)
    Set tTask = ##class(TimeTracker.Task).%OpenId(tId)
    If tTask="" {
        Set tSC = $$$ERROR($$$GeneralError,"Task not found")
        Quit tSC
    }
    Set tUpdatableProps = $LB("Task","Category","IsWork")
    Set tPropIterator = pData.%GetIterator()
    While tPropIterator.%GetNext(.key,.val) {
        Set key=$ZCONVERT($E(key,1),"U")_$E(key,2,*)
        If $LISTFIND(tUpdatableProps,key) {
            If key="Category" {
                Do $METHOD(tTask,"CategorySetObjectId",val)
            } Else {
                Set $PROPERTY(tTask,key) = val
            }
        }
    }
    Set tSC = tTask.%Save()
    Quit {"status": ($SYSTEM.Status.GetErrorText(tSC))}
}

ClassMethod addTask(pData As %DynamicObject) As %DynamicObject
{
    Set tRet={}
    Set pData={}.%FromJSON(pData)
    Set tTask=##class(TimeTracker.Task).AddTask(
        pData.%Get("date"),
        pData.%Get("start"),
        pData.%Get("duration"),
        pData.%Get("task"),
        pData.%Get("category"),
        pData.%Get("isWork")
    )
    If $ISOBJECT(tTask) {
        Set tRet=##class(TimeTracker.REST.impl).getTask(tTask.%Id()).%ToJSON()
    }
    Return tRet
}

ClassMethod deleteTask(tId) As %DynamicObject
{
    Set tStatusText="Task "_tId_" deleted successfully."
    Set tSC = ##class(TimeTracker.Task).%DeleteId(tId)
    If $$$ISERR(tSC) {
        Set tStatusText=$SYSTEM.Status.GetErrorText(tSC)
    }
    Set tResponse = {"status": (tStatusText)}
    Quit tResponse
}

ClassMethod getCategories() As %DynamicArray
{
    Set tSC = $$$OK
    Set tResponse = []
    Set tSQL="SELECT JSON_OBJECT('id':%ID,'name':Name) AS t FROM TimeTracker.Category"
    Set tValArray=""
    Set tSQLRS=##class(%SQL.Statement).%ExecDirect(,.tSQL)
    While tSQLRS.%Next() {
        Set tRow = tSQLRS.%Get("t")
        Do tResponse.%Push({}.%FromJSON(tRow))
    }
    Quit tResponse
}

}
