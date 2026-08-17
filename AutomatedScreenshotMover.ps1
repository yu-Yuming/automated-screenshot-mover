$folderWatch = "C:\Nexon\Maple"
$floderMove = "TODO"

$watcher = New-Object System.IO.FileSystemWatcher
$watcher.Path = $folderWatch
$watcher.Filter = "*.jpg"
$watcher.IncludeSubdirectories = $false
$watcher.EnableRaisingEvents = $true

$action = {
    $sourceFile = $Event.SourceEventArgs.FullPath
    $fileName = $Event.SourceEventArgs.Name
    $targetFile = Join-Path $using:folderMove $fileName

    Start-Sleep - Milliseconds 500

    try {
        Move-Item -LiteralPath $sourceFile -Destination $targetFile -Force -ErrorAction Stop
    }
}

Register-ObjectEvent $watcher "Created" -Action $action

try {
    while ($true) {
        Start-Sleep 1
    }
}
finally {
    Get-EventSubscriber | Unregister-Event
    $watcher.Dispose()
}
