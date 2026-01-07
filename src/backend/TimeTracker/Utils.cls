Class src.backend.TimeTracker.Utils Extends %RegisteredObject
{

ClassMethod TextReport(pStartDate = {$h-5}, pEndDate = {$h}) As %Stream.TmpCharacter
{
    Set tReport=##class(%Stream.TmpCharacter).%New()
    Do tReport.WriteLine("// Week "_$zd(pStartDate,3)_" to "_$zd(pEndDate,3))
    Set tTotal=0
    For i=pStartDate:1:pEndDate {
        Set tWhere={"filters":[{"Day":($zd(i,3))}]}
        Set tTasks=##class(TimeTracker.Task).GetTasksSummary(tWhere)
        Do tReport.WriteLine("")
        Do tReport.WriteLine($zd(i,12))
        Set tTasksIterator=tTasks.%GetIterator()
        While tTasksIterator.%GetNext(.key,.val) {
            Set tTotal=tTotal+val
            Set tHrs=0
            If val>45 {
                Set tHrs=val\60
                Set val=val#60
            }
            Do tReport.WriteLine(key_" ("_$select(tHrs>1:tHrs_" hrs",tHrs>0:tHrs_" hr",1:"")_$select((tHrs>0)&&(val>0):" ",1:"")_$select(val>0:val_" mins",1:"")_")")
        }
    }

    Do tReport.WriteLine("")
    Set tTotalHrs=0
    If tTotal>45 {
        Set tTotalHrs=tTotal\60
        Set tTotal=tTotal#60
    }
    Do tReport.WriteLine("Weekly Total: "_$select(tTotalHrs>1:tTotalHrs_" hrs",tTotalHrs>0:tTotalHrs_" hr",1:"")_$select((tTotalHrs>0)&&(tTotal>0):" ",1:"")_$select(tTotal>0:tTotal_" mins",1:""))
    Return tReport
}

}
