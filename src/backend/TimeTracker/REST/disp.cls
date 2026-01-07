Class TimeTracker.REST.disp Extends %CSP.REST
{

Parameter HandleCorsRequest = 0;

XData UrlMap [ XMLNamespace = "http://www.intersystems.com/urlmap" ]
{
<Routes>
  <Route Url="/tasks" Method="get" Call="getTasks" />
  <Route Url="/tasks" Method="post" Call="getTasks" />
  <Route Url="/task" Method="post" Call="addTask" />
  <Route Url="/task/:id" Method="get" Call="getTask" />
  <Route Url="/task/:id" Method="put" Call="updateTask" />
  <Route Url="/task/:id" Method="delete" Call="deleteTask" />

  <Route Url="/categories" Method="get" Call="getCategories"/>
  <Route Url="/category" Method="post" Call="addCategory"/>
  <Route Url="/category/:id" Method="put" Call="updateCategory"/>
  <Route Url="/category/:id" Method="delete" Call="deleteCategory"/>
</Routes>
}

ClassMethod getTasks() As %Status
{
    Try {
        Do ##class(%REST.Impl).%SetContentType("application/json")
        If '##class(%REST.Impl).%CheckAccepts("application/json") Do ##class(%REST.Impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts)) Quit
        Set response=##class(TimeTracker.REST.impl).getTasks({}.%FromJSON({}.%FromJSON(%request.Content).body))
        Do ##class(%REST.Impl).%WriteResponse(response)
    } Catch (ex) {
        Do ##class(%REST.Impl).%SetStatusCode("400")
        return {"errormessage": "Client error"}
    }
    Quit $$$OK
}

ClassMethod updateTask(tId As %String) As %Status
{
    Try {
        Do ##class(%REST.Impl).%SetContentType("application/json")
        If '##class(%REST.Impl).%CheckAccepts("application/json") Do ##class(%REST.Impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts)) Quit
        Set response=##class(TimeTracker.REST.impl).updateTask(tId,%request.Content)
        Do ##class(%REST.Impl).%WriteResponse(response)
    } Catch (ex) {
        Do ##class(%REST.Impl).%SetStatusCode("400")
        return {"errormessage": "Client error"}
    }
    Quit $$$OK
}

ClassMethod addTask() As %Status
{
    Try {
        Do ##class(%REST.Impl).%SetContentType("application/json")
        If '##class(%REST.Impl).%CheckAccepts("application/json") Do ##class(%REST.Impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts)) Quit
        Set response=##class(TimeTracker.REST.impl).addTask(%request.Content)
        Do ##class(%REST.Impl).%WriteResponse(response)
    } Catch (ex) {
        Do ##class(%REST.Impl).%SetStatusCode("400")
        return {"errormessage": "Client error"}
    }
    Quit $$$OK
}

ClassMethod getTask(tId As %String) As %Status
{
    Try {
        Do ##class(%REST.Impl).%SetContentType("application/json")
        If '##class(%REST.Impl).%CheckAccepts("application/json") Do ##class(%REST.Impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts)) Quit
        Set response=##class(TimeTracker.REST.impl).getTask(tId)
        Do ##class(%REST.Impl).%WriteResponse(response)
    } Catch (ex) {
        Do ##class(%REST.Impl).%SetStatusCode("400")
        return {"errormessage": "Client error"}
    }
    Quit $$$OK
}

ClassMethod deleteTask(tId As %String) As %Status
{
    Try {
        Do ##class(%REST.Impl).%SetContentType("application/json")
        If '##class(%REST.Impl).%CheckAccepts("application/json") Do ##class(%REST.Impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts)) Quit
        Set response=##class(TimeTracker.REST.impl).deleteTask(tId)
        Do ##class(%REST.Impl).%WriteResponse(response)
    } Catch (ex) {
        Do ##class(%REST.Impl).%SetStatusCode("400")
        return {"errormessage": "Client error"}
    }
    Quit $$$OK
}

ClassMethod getCategories() As %Status
{
    Try {
        Do ##class(%REST.Impl).%SetContentType("application/json")
        If '##class(%REST.Impl).%CheckAccepts("application/json") Do ##class(%REST.Impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts)) Quit
        Set response=##class(TimeTracker.REST.impl).getCategories()
        Do ##class(%REST.Impl).%WriteResponse(response)
    } Catch (ex) {
        Do ##class(%REST.Impl).%SetStatusCode("400")
        return {"errormessage": "Client error"}
    }
    Quit $$$OK
}

}
