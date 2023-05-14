$OutputFile = "C:/Users/Linus/Desktop/SystemPerformance.csv"
$Duration = 60 # Duration in seconds for how long the script should run; modify as needed
$Interval = 0.1 # Interval in seconds between each measurement; modify as needed

$CounterList = @('\Processor(_Total)\% Processor Time', '\Memory\Available MBytes')
$Start = Get-Date
$End = $Start.AddSeconds($Duration)

# Initialize CSV file with headers
"Timestamp, CPU Usage (%), Available Memory (MB)" | Out-File -FilePath $OutputFile -Encoding utf8
$Script:stopLoop = $false
$KeyPressJob = Start-Job -ScriptBlock {
    $null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
    $Script:stopLoop = $true
}

while (-not $Script:stopLoop) {
    $Timestamp = Get-Date
    $CpuUsage = (Get-Counter -Counter $CounterList[0]).CounterSamples[0].CookedValue
    $MemoryAvailable = (Get-Counter -Counter $CounterList[1]).CounterSamples[0].CookedValue
    
    $OutputData = "$Timestamp, $CpuUsage, $MemoryAvailable"
    $OutputData | Out-File -FilePath $OutputFile -Encoding utf8 -Append
    Start-Sleep -Seconds $Interval
}
