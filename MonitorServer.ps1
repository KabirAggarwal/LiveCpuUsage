while ($true)
{

 $Date = Get-Date -DisplayHint Date -Format MM/dd/yyyy
 $Time = Get-date -DisplayHint Time -Format HH:MM:ss

 $SystemMemory= Get-WmiObject -Class win32_operatingsystem 

 $TotalMemory_GB=[math]::Round(((($SystemMemory.TotalvisibleMemorySize)/1024)/1024),2)

  
 $FreeMemory_GB=[math]::Round(((($SystemMemory.freephysicalmemory)/1024)/1024),2)

 $MemUsedPercent= [math]::Round(((($TotalMemory_GB-$FreeMemory_GB)/$TotalMemory_GB)*100),2)

 $computerCPU =(Get-WmiObject -Class win32_processor -ErrorAction Stop | Measure-Object -Property LoadPercentage  -Average | Select-Object Average).Average


$Date
$Time
$computerCPU
$TotalMemory_GB
$FreeMemory_GB
$MemUsedPercent


$endpoint = "https://api.powerbi.com/beta/e4e34038-ea1f-4882-b6e8-ccd776459ca0/datasets/8c0f661f-cc47-4840-ae5b-a837af9ec090/rows?key=00NCHdlAx9FsVUwDcO7liyojkoZCU87gRM350VjMdglMW3xSSOgfrcTvNju9gq54YA%2Bh3dH9m4tjpsW%2BJrCe%2Bg%3D%3D"
$payload = @{
"date" =$Date
"time" =$Time
"TotalMemory_GB" =$TotalMemory_GB
"AvailMemory_GB" =$FreeMemory_GB
"Used_Percentage" =$MemUsedPercent
"CPU" =$computerCPU
}
Invoke-RestMethod -Method Post -Uri "$endpoint" -Body (ConvertTo-Json @($payload))

}
