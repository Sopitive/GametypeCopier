


Function Register-Watcher {
    param ($folder)
    $filter = "*.mglo" #all mglo files
    $watcher = New-Object IO.FileSystemWatcher $folder, $filter -Property @{ 
        IncludeSubdirectories = $false
        EnableRaisingEvents = $true
    } 

    


    $changeAction = [scriptblock]::Create('
        # This is the code which will be executed every time a file change is detected
        $path = $Event.SourceEventArgs.FullPath
        $name = $Event.SourceEventArgs.Name
        $changeType = $Event.SourceEventArgs.ChangeType
        $timeStamp = $Event.TimeGenerated
        Write-Host "The file $name was $changeType at $timeStamp"
        Get-ChildItem $pwd -Filter $name | 
        Foreach-Object {
            $game = $pwd | Split-Path
    $game = $game | Split-Path
    $game = Split-Path -Path $game -Leaf
    

    if ($game -eq "HREK") {
        $game = "HaloReach"
    }

    if ($game -eq "H2AMPEK") {
        $game = "Halo2A"
    }

    if ($game -eq "H4EK") {
        $game = "Halo4"
    }

    Write-Host "Modified $game Gametype"
    if (!(Test-Path "C:\Users\$env:UserName\AppData\LocalLow\MCC\Temporary\$game\HotReload")) {
        New-Item "C:\Users\$env:UserName\AppData\LocalLow\MCC\Temporary\$game\HotReload" -ItemType Directory
        Write-Host "Hot Reload folder for $game does not exist. Creating folder... done"
    }

    $outpath = "C:\Users\$env:UserName\AppData\LocalLow\MCC\Temporary\$game\HotReload"
            Write-Host "Copying file to $outpath"
            Copy-Item $pwd\$name -Destination $outpath\$name
            Copy-Item $pwd\$name -Destination $outpath\.mglo
        }
    ')


    Register-ObjectEvent $Watcher -EventName "Changed" -Action $changeAction
    while($true){ Start-Sleep -Milliseconds 100 }
}

 Register-Watcher $pwd

