/// 
Class TimeTracker.Cubes.Tasks Extends %DeepSee.CubeDefinition [ DependsOn = TimeTracker.Task, ProcedureBlock ]
{

/// Cube definition from Architect.
XData Cube [ XMLNamespace = "http://www.intersystems.com/deepsee" ]
{
<cube xmlns="http://www.intersystems.com/deepsee" name="Tasks" displayName="Tasks" disabled="false" abstract="false" sourceClass="TimeTracker.Task" namedFactNums="true" countMeasureName="%COUNT" bucketSize="8" bitmapChunkInMemory="false" precompute="0" disableListingGroups="false" enableSqlRestrict="false">
  <dimension name="Day" disabled="false" hasAll="false" allCaption="All Day" allDisplayName="Day" sourceProperty="Day" type="time" calendar="gregorian" hidden="false" showHierarchies="default">
    <hierarchy name="H1" disabled="false" hidden="false">
      <level name="Year" disabled="false" timeFunction="Year" list="false" useDisplayValue="true" useAsFilter="true" hidden="false" factNumber="2">
      </level>
      <level name="Month" disabled="false" timeFunction="MonthYear" list="false" useDisplayValue="true" useAsFilter="true" hidden="false" factNumber="3">
      </level>
      <level name="Day" disabled="false" timeFunction="DayMonthYear" list="false" useDisplayValue="true" useAsFilter="true" hidden="false" factNumber="4">
      </level>
    </hierarchy>
  </dimension>
  <dimension name="IsWork" disabled="false" hasAll="false" allCaption="All IsWork" allDisplayName="IsWork" type="data" hidden="false" showHierarchies="default">
    <hierarchy name="H1" disabled="false" hidden="false">
      <level name="IsWork" disabled="false" sourceProperty="IsWork" list="false" useDisplayValue="true" useAsFilter="true" hidden="false" factNumber="5">
      </level>
    </hierarchy>
  </dimension>
  <dimension name="StartTime" disabled="false" hasAll="false" allCaption="All StartTime" allDisplayName="StartTime" type="data" hidden="false" showHierarchies="default">
    <hierarchy name="H1" disabled="false" hidden="false">
      <level name="StartTime" disabled="false" sourceProperty="StartTime" list="false" useDisplayValue="true" useAsFilter="true" hidden="false" factNumber="6">
      </level>
    </hierarchy>
  </dimension>
  <dimension name="Task" disabled="false" hasAll="false" allCaption="All Task" allDisplayName="Task" type="data" hidden="false" showHierarchies="default">
    <hierarchy name="H1" disabled="false" hidden="false">
      <level name="Task" disabled="false" sourceProperty="Task" list="false" useDisplayValue="true" useAsFilter="true" hidden="false" factNumber="7">
      </level>
    </hierarchy>
  </dimension>
  <dimension name="Category" disabled="false" hasAll="true" allCaption="All Category" allDisplayName="Category" type="data" calendar="gregorian" iKnowType="entity" hidden="false" showHierarchies="default">
    <hierarchy name="H1" disabled="false" hidden="false">
      <level name="Category" disabled="false" sourceProperty="Category" list="false" useDisplayValue="true" useAsFilter="true" hidden="false" factNumber="8">
        <property name="Name" disabled="false" sourceProperty="Category.Name" hidden="false" isName="true" isDescription="false" isReference="false" useDisplayValue="false">
        </property>
      </level>
    </hierarchy>
  </dimension>
  <measure name="Minutes" disabled="false" sourceExpression="15" aggregate="SUM" type="integer" hidden="false" searchable="false" factNumber="1">
  </measure>
  <measure name="Hours" disabled="false" sourceExpression=".25" aggregate="SUM" type="number" hidden="false" searchable="false" factNumber="2">
  </measure>
  <listing name="Listing" disabled="false" listingType="table" fieldList="%ID,Day,StartTime,Category-&gt;Name,Task,IsWork" selectMode="2">
  </listing>
</cube>
}

Parameter DOMAIN;

}
