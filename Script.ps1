Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing
$rootFolder = "$PSScriptRoot\scripts"

# Funkcja do załadowania drzewa folderów
function Get-FolderTree {
    param ($basePath)
    $treeView.Nodes.Clear()
    $rootNode = New-Object System.Windows.Forms.TreeNode
    $rootNode.Text = (Split-Path $basePath -Leaf)
    $rootNode.Tag = $basePath
    $treeView.Nodes.Add($rootNode)
    Get-ChildItem -Path $basePath -Directory | ForEach-Object {
        $childNode = New-Object System.Windows.Forms.TreeNode
        $childNode.Text = $_.Name
        $childNode.Tag = $_.FullName
        $rootNode.Nodes.Add($childNode)
    }
    $rootNode.Expand()
}
# Wywołanie funkcji z katalogiem skryptu
Get-FolderTree -basePath $rootFolder
# 🧱 Tworzenie głównego okna
$form = New-Object System.Windows.Forms.Form
$form.Text = "Script's Explorer"
$form.Size = New-Object System.Drawing.Size(994,710)
$form.StartPosition = "CenterScreen"
# 🧩 Panel górny – podgląd pliku
$topBox = New-Object System.Windows.Forms.TextBox
$topBox.Multiline = $true
$topBox.ReadOnly = $true
$topBox.ScrollBars = "Vertical"
$topBox.Size = New-Object System.Drawing.Size(959,100)
$topBox.Location = New-Object System.Drawing.Point(10,20)
$form.Controls.Add($topBox)
# 🧩 Panel lewy – pełna zawartość pliku
$leftBox = New-Object System.Windows.Forms.TextBox
$leftBox.Multiline = $true
$leftBox.ReadOnly = $true  # 🔒 Zablokowanie edycji
$leftBox.ScrollBars = "Vertical"
$leftBox.Size = New-Object System.Drawing.Size(680,500)
$leftBox.Location = New-Object System.Drawing.Point(10,120)
$form.Controls.Add($leftBox)
# 🧩 Panel prawy – drzewo folderów scripts
$treeView = New-Object System.Windows.Forms.TreeView
$treeView.Size = New-Object System.Drawing.Size(280,500)
$treeView.Location = New-Object System.Drawing.Point(690,120)
$form.Controls.Add($treeView)
# ▶️ Przycisk Run pod lewym panelem
$runButton = New-Object System.Windows.Forms.Button
$runButton.Text = "Run"
$runItem.Add_Click({ $runButton.PerformClick() })
$runButton.Size = New-Object System.Drawing.Size(100,30)
$runButton.Location = New-Object System.Drawing.Point(10,630)
$form.Controls.Add($runButton)
# 🖱️ Obsługa kliknięcia w przycisk Run
$runButton.Add_Click({
    $selectedNode = $treeView.SelectedNode
    if ($selectedNode -and (Test-Path $selectedNode.Tag) -and (Get-Item $selectedNode.Tag).PSIsContainer -eq $false) {
        try {
            Start-Process -FilePath $selectedNode.Tag
        } catch {
            [System.Windows.Forms.MessageBox]::Show("Failed to run file:`n$($_.Exception.Message)","Startup error",[System.Windows.Forms.MessageBoxButtons]::OK,[System.Windows.Forms.MessageBoxIcon]::Error)
        }
    } else {
        [System.Windows.Forms.MessageBox]::Show("Select a file in the folder tree to run it.","No file",[System.Windows.Forms.MessageBoxButtons]::OK,[System.Windows.Forms.MessageBoxIcon]::Warning)
    }
})
# ✏️ Przycisk Edit obok Run
$editButton = New-Object System.Windows.Forms.Button
$editButton.Text = "Edit"
$editButton.Size = New-Object System.Drawing.Size(100,30)
$editButton.Location = New-Object System.Drawing.Point(120,630)
$form.Controls.Add($editButton)
# 🖱️ Obsługa kliknięcia w przycisk Edit
$editButton.Add_Click({
    $selectedNode = $treeView.SelectedNode
    if ($selectedNode -and (Test-Path $selectedNode.Tag) -and (Get-Item $selectedNode.Tag).PSIsContainer -eq $false) {
        try {
            Start-Process -FilePath "notepad++.exe" -ArgumentList "`"$($selectedNode.Tag)`""
        } catch {
            [System.Windows.Forms.MessageBox]::Show("Could not open file in Notepad++:`n$($_.Exception.Message)","Edit error",[System.Windows.Forms.MessageBoxButtons]::OK,[System.Windows.Forms.MessageBoxIcon]::Error)
        }
    } else {
        [System.Windows.Forms.MessageBox]::Show("Select a file in the folder tree to edit it.","No file",[System.Windows.Forms.MessageBoxButtons]::OK,[System.Windows.Forms.MessageBoxIcon]::Warning)
    }
})
# 🆕 Przycisk New Script obok Edit
$newScriptButton = New-Object System.Windows.Forms.Button
$newScriptButton.Text = "nEw Script"
$newScriptButton.Size = New-Object System.Drawing.Size(100,30)
$newScriptButton.Location = New-Object System.Drawing.Point(230,630)
$form.Controls.Add($newScriptButton)
$newScriptButton.Add_Click({
    $scriptsFolder = "$PSScriptRoot\scripts"
    if (-not (Test-Path $scriptsFolder)) {
        New-Item -Path $scriptsFolder -ItemType Directory | Out-Null
    }
    $index = 1
    do {
        $newFile = Join-Path $scriptsFolder ("nEw Project\nEw_Script_$index.bat")
        $index++
    } while (Test-Path $newFile)
    try {
        Set-Content -Path $newFile -Value ":: Written in Script's Explorer by polsoft.ITS`n@echo off`r`nTitle nEw Script (.bat)" -Encoding ASCII
        Start-Process -FilePath "notepad++" -ArgumentList "`"$newFile`""
    } catch {
        [System.Windows.Forms.MessageBox]::Show("Failed to create or open file:`n$($_.Exception.Message)","Error",[System.Windows.Forms.MessageBoxButtons]::OK,[System.Windows.Forms.MessageBoxIcon]::Error)
    }
})
# 📷 Dodanie ikony folderu do ImageList
$folderIcon = [System.Drawing.SystemIcons]::WinLogo.ToBitmap()  # Można użyć innej ikony
$bottomView.SmallImageList.Images.Add("folder", $folderIcon)
# 📂 Załaduj foldery z katalogu scripts do ListView z ikoną
Get-ChildItem -Path $rootPath -Directory | ForEach-Object {
    $item = New-Object System.Windows.Forms.ListViewItem
    $item.Text = $_.Name
    $item.ImageKey = "folder"
    $bottomView.Items.Add($item)
}
# 📁 Funkcja ładowania drzewa folderów i plików
function Get-FolderTree {
    param($rootPath, $parentNode)
    # Dodajemy podfoldery
    Get-ChildItem -Path $rootPath -Directory -ErrorAction SilentlyContinue | ForEach-Object {
        $folderNode = New-Object System.Windows.Forms.TreeNode
        $folderNode.Text = $_.Name
        $folderNode.Tag = $_.FullName
        $parentNode.Nodes.Add($folderNode)
        Get-FolderTree -rootPath $_.FullName -parentNode $folderNode
    }
    # Dodajemy pliki w bieżącym folderze
    Get-ChildItem -Path $rootPath -File -ErrorAction SilentlyContinue | ForEach-Object {
        $fileNode = New-Object System.Windows.Forms.TreeNode
        $fileNode.Text = $_.Name
        $fileNode.Tag = $_.FullName
        $fileNode.ForeColor = [System.Drawing.Color]::DarkBlue
        $parentNode.Nodes.Add($fileNode)
    }
}
# 🌲 Inicjalizacja drzewa folderów
$rootPath = "$PSScriptRoot\scripts"
Get-ChildItem -Path $rootPath -Directory | ForEach-Object {
    $node = New-Object System.Windows.Forms.TreeNode
    $node.Text = $_.Name
    $node.Tag = $_.FullName
    $treeView.Nodes.Add($node)
    Get-FolderTree -rootPath $_.FullName -parentNode $node
}
# 📄 Obsługa kliknięcia w drzewie – ładowanie pliku
$treeView.Add_NodeMouseClick({
    $selectedPath = $_.Node.Tag
    $file = Get-ChildItem -Path $selectedPath -File -ErrorAction SilentlyContinue | Select-Object -First 1
    if ($file) {
        $topBox.Text = Get-Content -Path $file.FullName -TotalCount 10 -ErrorAction SilentlyContinue | Out-String
        $leftBox.Text = Get-Content -Path $file.FullName -ErrorAction SilentlyContinue | Out-String
    } else {
        $topBox.Text = ""
        $leftBox.Text = ""
    }
})
# 📋 Menu główne
$menuStrip = New-Object System.Windows.Forms.MenuStrip
# 📁 Menu "File"
$fileMenu = New-Object System.Windows.Forms.ToolStripMenuItem
$fileMenu.Text = "File"
$exitItem = New-Object System.Windows.Forms.ToolStripMenuItem
$exitItem.Text = "Close"
$exitItem.Add_Click({ $form.Close() })
$fileMenu.DropDownItems.Add($exitItem)
# 🔄 Menu "View"
$viewMenu = New-Object System.Windows.Forms.ToolStripMenuItem
$viewMenu.Text = "View"
$refreshItem = New-Object System.Windows.Forms.ToolStripMenuItem
$refreshItem.Text = "Refresh"
$refreshItem.Add_Click({
    $treeView.Nodes.Clear()
    Get-ChildItem -Path $rootPath -Directory | ForEach-Object {
        $node = New-Object System.Windows.Forms.TreeNode
        $node.Text = $_.Name
        $node.Tag = $_.FullName
        $treeView.Nodes.Add($node)
        Load-FolderTree -rootPath $_.FullName -parentNode $node
    }
    $bottomView.Items.Clear()
    Get-ChildItem -Path $rootPath -Directory | ForEach-Object {
        $item = New-Object System.Windows.Forms.ListViewItem
        $item.Text = $_.Name
        $item.ImageKey = "folder"
        $bottomView.Items.Add($item)
    }
    $topBox.Text = ""
    $leftBox.Text = ""
})
$viewMenu.DropDownItems.Add($refreshItem)
# 📚 Menu "Resources"
$resourcesMenu = New-Object System.Windows.Forms.ToolStripMenuItem
$resourcesMenu.Text = "Resources"
# 🔍 Menu "Tools"
$toolsMenu = New-Object System.Windows.Forms.ToolStripMenuItem
$toolsMenu.Text = "Tools"
$searchItem = New-Object System.Windows.Forms.ToolStripMenuItem
$searchItem.Text = "Search"
$searchItem.ShortcutKeys = [System.Windows.Forms.Keys]::Control -bor [System.Windows.Forms.Keys]::F
$searchItem.Add_Click({
    $scriptPath = Join-Path $PSScriptRoot "search.ps1"
    if (Test-Path $scriptPath) {
        try {
            Start-Process powershell -ArgumentList "-NoProfile -ExecutionPolicy Bypass -File `"$scriptPath`""
        } catch {
            [System.Windows.Forms.MessageBox]::Show("Failed to start search.ps1:`n$($_.Exception.Message)","Error",[System.Windows.Forms.MessageBoxButtons]::OK,[System.Windows.Forms.MessageBoxIcon]::Error)
        }
    } else {
        [System.Windows.Forms.MessageBox]::Show("File search.ps1 not found in app folder.","No file",[System.Windows.Forms.MessageBoxButtons]::OK,[System.Windows.Forms.MessageBoxIcon]::Warning)
    }
})
# 🛠️ Opcja Bat To Exe Converter
$batToExeItem = New-Object System.Windows.Forms.ToolStripMenuItem
$batToExeItem.Text = "Bat To Exe Converter"
$batToExeItem.ShortcutKeys = [System.Windows.Forms.Keys]::Control -bor [System.Windows.Forms.Keys]::Shift -bor [System.Windows.Forms.Keys]::B
$batToExeItem.Add_Click({
    $exePath = Join-Path $PSScriptRoot "battoexe.exe"
    if (Test-Path $exePath) {
        try {
            Start-Process -FilePath $exePath
        } catch {
            [System.Windows.Forms.MessageBox]::Show("Failed to start battoexe.exe:`n$($_.Exception.Message)","Error",[System.Windows.Forms.MessageBoxButtons]::OK,[System.Windows.Forms.MessageBoxIcon]::Error)
        }
    } else {
        [System.Windows.Forms.MessageBox]::Show("Battoexe.exe not found in app directory.","No file",[System.Windows.Forms.MessageBoxButtons]::OK,[System.Windows.Forms.MessageBoxIcon]::Warning)
    }
})
$MakeEXE = New-Object System.Windows.Forms.ToolStripMenuItem
$MakeEXE.Text = "Make EXE"
$MakeEXE.ShortcutKeys = [System.Windows.Forms.Keys]::Control -bor [System.Windows.Forms.Keys]::Shift -bor [System.Windows.Forms.Keys]::M
$MakeEXE.Add_Click({
    $exePath = Join-Path $PSScriptRoot "makeexe.exe"
    if (Test-Path $exePath) {
        try {
            Start-Process -FilePath $exePath
        } catch {
            [System.Windows.Forms.MessageBox]::Show("Failed to start makeexe.exe:`n$($_.Exception.Message)","Error",[System.Windows.Forms.MessageBoxButtons]::OK,[System.Windows.Forms.MessageBoxIcon]::Error)
        }
    } else {
        [System.Windows.Forms.MessageBox]::Show("MakeEXE.exe not found in app directory.","No file",[System.Windows.Forms.MessageBoxButtons]::OK,[System.Windows.Forms.MessageBoxIcon]::Warning)
    }
})
$Ps1ToExe = New-Object System.Windows.Forms.ToolStripMenuItem
$Ps1ToExe.Text = "Ps1 To Exe"
$Ps1ToExe.ShortcutKeys = [System.Windows.Forms.Keys]::Control -bor [System.Windows.Forms.Keys]::Shift -bor [System.Windows.Forms.Keys]::P
$Ps1ToExe.Add_Click({
    $exePath = Join-Path $PSScriptRoot "Ps1ToExe.exe"
    if (Test-Path $exePath) {
        try {
            Start-Process -FilePath $exePath
        } catch {
            [System.Windows.Forms.MessageBox]::Show("Failed to start Ps1ToExe.exe:`n$($_.Exception.Message)","Error",[System.Windows.Forms.MessageBoxButtons]::OK,[System.Windows.Forms.MessageBoxIcon]::Error)
        }
    } else {
        [System.Windows.Forms.MessageBox]::Show("Ps1ToExe.exe not found in app directory.","No file",[System.Windows.Forms.MessageBoxButtons]::OK,[System.Windows.Forms.MessageBoxIcon]::Warning)
    }
})
$SignTool = New-Object System.Windows.Forms.ToolStripMenuItem
$SignTool.Text = "SignTool"
$SignTool.ShortcutKeys = [System.Windows.Forms.Keys]::Control -bor [System.Windows.Forms.Keys]::Shift -bor [System.Windows.Forms.Keys]::T
$SignTool.Add_Click({
    $exePath = Join-Path $PSScriptRoot "SignTool.exe"
    if (Test-Path $exePath) {
        try {
            Start-Process -FilePath $exePath
        } catch {
            [System.Windows.Forms.MessageBox]::Show("Failed to start SignTool.exe:`n$($_.Exception.Message)","Error",[System.Windows.Forms.MessageBoxButtons]::OK,[System.Windows.Forms.MessageBoxIcon]::Error)
        }
    } else {
        [System.Windows.Forms.MessageBox]::Show("SignTool.exe not found in app directory.","No file",[System.Windows.Forms.MessageBoxButtons]::OK,[System.Windows.Forms.MessageBoxIcon]::Warning)
    }
})
$VbsToExe = New-Object System.Windows.Forms.ToolStripMenuItem
$VbsToExe.Text = "Vbs To Exe"
$VbsToExe.ShortcutKeys = [System.Windows.Forms.Keys]::Control -bor [System.Windows.Forms.Keys]::Shift -bor [System.Windows.Forms.Keys]::V
$VbsToExe.Add_Click({
    $exePath = Join-Path $PSScriptRoot "VbsToExe.exe"
    if (Test-Path $exePath) {
        try {
            Start-Process -FilePath $exePath
        } catch {
            [System.Windows.Forms.MessageBox]::Show("Failed to start VbsToExe.exe:`n$($_.Exception.Message)","Error",[System.Windows.Forms.MessageBoxButtons]::OK,[System.Windows.Forms.MessageBoxIcon]::Error)
        }
    } else {
        [System.Windows.Forms.MessageBox]::Show("VbsToExe.exe not found in app directory.","No file",[System.Windows.Forms.MessageBoxButtons]::OK,[System.Windows.Forms.MessageBoxIcon]::Warning)
    }
})
$RegConvert = New-Object System.Windows.Forms.ToolStripMenuItem
$RegConvert.Text = "Reg Converter"
$RegConvert.ShortcutKeys = [System.Windows.Forms.Keys]::Control -bor [System.Windows.Forms.Keys]::Shift -bor [System.Windows.Forms.Keys]::J
$RegConvert.Add_Click({
    $exePath = Join-Path $PSScriptRoot "RegConvert.exe"
    if (Test-Path $exePath) {
        try {
            Start-Process -FilePath $exePath
        } catch {
            [System.Windows.Forms.MessageBox]::Show("Failed to start RegConvert.exe:`n$($_.Exception.Message)","Error",[System.Windows.Forms.MessageBoxButtons]::OK,[System.Windows.Forms.MessageBoxIcon]::Error)
        }
    } else {
        [System.Windows.Forms.MessageBox]::Show("RegConvert.exe not found in app directory.","No file",[System.Windows.Forms.MessageBoxButtons]::OK,[System.Windows.Forms.MessageBoxIcon]::Warning)
    }
})
$1JAR = New-Object System.Windows.Forms.ToolStripMenuItem
$1JAR.Text = "1JAR"
$1JAR.ShortcutKeys = [System.Windows.Forms.Keys]::Control -bor [System.Windows.Forms.Keys]::Shift -bor [System.Windows.Forms.Keys]::C
$1JAR.Add_Click({
    $jarPath = Join-Path $PSScriptRoot "1JAR.jar"
    if (Test-Path $jarPath) {
        try {
            Start-Process -FilePath $jarPath
        } catch {
            [System.Windows.Forms.MessageBox]::Show("Failed to start 1JAR.jar:`n$($_.Exception.Message)","Error",[System.Windows.Forms.MessageBoxButtons]::OK,[System.Windows.Forms.MessageBoxIcon]::Error)
        }
    } else {
        [System.Windows.Forms.MessageBox]::Show("1JAR.jar not found in app directory.","No file",[System.Windows.Forms.MessageBoxButtons]::OK,[System.Windows.Forms.MessageBoxIcon]::Warning)
    }
})
# 🧩 Pozycja "MiTeC EXE Explorer"
$mitecItem = New-Object System.Windows.Forms.ToolStripMenuItem
$mitecItem.Text = "MiTeC EXE Explorer"
$mitecItem.ShortcutKeys = [System.Windows.Forms.Keys]::Control -bor [System.Windows.Forms.Keys]::E
$mitecItem.Add_Click({
    $exePath = Join-Path $PSScriptRoot "EXEExplorer.exe"
    if (Test-Path $exePath) {
        try {
            Start-Process -FilePath $exePath
        } catch {
            [System.Windows.Forms.MessageBox]::Show("Failed to start EXEExplorer.exe:`n$($_.Exception.Message)","Error",[System.Windows.Forms.MessageBoxButtons]::OK,[System.Windows.Forms.MessageBoxIcon]::Error)
        }
    } else {
        [System.Windows.Forms.MessageBox]::Show("EXEExplorer.exe not found in app directory.","No file",[System.Windows.Forms.MessageBoxButtons]::OK,[System.Windows.Forms.MessageBoxIcon]::Warning)
    }
})
$ResNET = New-Object System.Windows.Forms.ToolStripMenuItem
$ResNET.Text = "Resource .NET"
$ResNET.ShortcutKeys = [System.Windows.Forms.Keys]::Control -bor [System.Windows.Forms.Keys]::N
$ResNET.Add_Click({
    $exePath = Join-Path $PSScriptRoot "ResNET.exe"
    if (Test-Path $exePath) {
        try {
            Start-Process -FilePath $exePath
        } catch {
            [System.Windows.Forms.MessageBox]::Show("Failed to start program:`n$($_.Exception.Message)","Error",[System.Windows.Forms.MessageBoxButtons]::OK,[System.Windows.Forms.MessageBoxIcon]::Error)
        }
    } else {
        [System.Windows.Forms.MessageBox]::Show("Program not found in app directory.","No file",[System.Windows.Forms.MessageBoxButtons]::OK,[System.Windows.Forms.MessageBoxIcon]::Warning)
    }
})
$ResHacker = New-Object System.Windows.Forms.ToolStripMenuItem
$ResHacker.Text = "Resource Hacker"
$ResHacker.ShortcutKeys = [System.Windows.Forms.Keys]::Control -bor [System.Windows.Forms.Keys]::H
$ResHacker.Add_Click({
    $exePath = Join-Path $PSScriptRoot "ResHacker.exe"
    if (Test-Path $exePath) {
        try {
            Start-Process -FilePath $exePath
        } catch {
            [System.Windows.Forms.MessageBox]::Show("Failed to start program:`n$($_.Exception.Message)","Error",[System.Windows.Forms.MessageBoxButtons]::OK,[System.Windows.Forms.MessageBoxIcon]::Error)
        }
    } else {
        [System.Windows.Forms.MessageBox]::Show("Program not found in app directory.","No file",[System.Windows.Forms.MessageBoxButtons]::OK,[System.Windows.Forms.MessageBoxIcon]::Warning)
    }
})
$RisohEdit = New-Object System.Windows.Forms.ToolStripMenuItem
$RisohEdit.Text = "RisohEditor"
$RisohEdit.ShortcutKeys = [System.Windows.Forms.Keys]::Control -bor [System.Windows.Forms.Keys]::R
$RisohEdit.Add_Click({
    $exePath = Join-Path $PSScriptRoot "RisohEditor.exe"
    if (Test-Path $exePath) {
        try {
            Start-Process -FilePath $exePath
        } catch {
            [System.Windows.Forms.MessageBox]::Show("Failed to start program:`n$($_.Exception.Message)","Error",[System.Windows.Forms.MessageBoxButtons]::OK,[System.Windows.Forms.MessageBoxIcon]::Error)
        }
    } else {
        [System.Windows.Forms.MessageBox]::Show("Program not found in app directory.","No file",[System.Windows.Forms.MessageBoxButtons]::OK,[System.Windows.Forms.MessageBoxIcon]::Warning)
    }
})
$XNResEdit = New-Object System.Windows.Forms.ToolStripMenuItem
$XNResEdit.Text = "XN Resource Editor"
$XNResEdit.ShortcutKeys = [System.Windows.Forms.Keys]::Control -bor [System.Windows.Forms.Keys]::X
$XNResEdit.Add_Click({
    $exePath = Join-Path $PSScriptRoot "XNResEdit.exe"
    if (Test-Path $exePath) {
        try {
            Start-Process -FilePath $exePath
        } catch {
            [System.Windows.Forms.MessageBox]::Show("Failed to start program:`n$($_.Exception.Message)","Error",[System.Windows.Forms.MessageBoxButtons]::OK,[System.Windows.Forms.MessageBoxIcon]::Error)
        }
    } else {
        [System.Windows.Forms.MessageBox]::Show("Program not found in app directory.","No file",[System.Windows.Forms.MessageBoxButtons]::OK,[System.Windows.Forms.MessageBoxIcon]::Warning)
    }
})
$restuner = New-Object System.Windows.Forms.ToolStripMenuItem
$restuner.Text = "Resource Tuner"
$restuner.ShortcutKeys = [System.Windows.Forms.Keys]::Control -bor [System.Windows.Forms.Keys]::t
$restuner.Add_Click({
    $exePath = Join-Path $PSScriptRoot "restuner.exe"
    if (Test-Path $exePath) {
        try {
            Start-Process -FilePath $exePath
        } catch {
            [System.Windows.Forms.MessageBox]::Show("Failed to start program:`n$($_.Exception.Message)","Error",[System.Windows.Forms.MessageBoxButtons]::OK,[System.Windows.Forms.MessageBoxIcon]::Error)
        }
    } else {
        [System.Windows.Forms.MessageBox]::Show("Program not found in app directory.","No file",[System.Windows.Forms.MessageBoxButtons]::OK,[System.Windows.Forms.MessageBoxIcon]::Warning)
    }
})
$resourcesMenu.DropDownItems.Add($restuner)
$resourcesMenu.DropDownItems.Add($XNResEdit)
$resourcesMenu.DropDownItems.Add($RisohEdit)
$resourcesMenu.DropDownItems.Add($ResHacker)
$resourcesMenu.DropDownItems.Add($ResNET)
$resourcesMenu.DropDownItems.Add($mitecItem)
$toolsMenu.DropDownItems.Add($1JAR)
$toolsMenu.DropDownItems.Add($RegConvert)
$toolsMenu.DropDownItems.Add($VbsToExe)
$toolsMenu.DropDownItems.Add($SignTool)
$toolsMenu.DropDownItems.Add($Ps1ToExe)
$toolsMenu.DropDownItems.Add($MakeEXE)
$toolsMenu.DropDownItems.Add($batToExeItem)
$toolsMenu.DropDownItems.Add($searchItem)
# ❓ Menu "Help"
$helpMenu = New-Object System.Windows.Forms.ToolStripMenuItem
$helpMenu.Text = "Help"

$aboutItem = New-Object System.Windows.Forms.ToolStripMenuItem
$aboutItem.Text = "About"
$aboutItem.Add_Click({
    $aboutText = @"
                polsoft.ITS London
				
              Script's  Explorer  v1.0
			  
Copyright 2025 Sebastian Januchowski
"@
    [System.Windows.Forms.MessageBox]::Show($aboutText, "About", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Information)
})

$helpMenu.DropDownItems.Add($aboutItem)
# 📌 Dodanie menu do formularza
$menuStrip.Items.AddRange(@($fileMenu, $viewMenu, $toolsMenu, $resourcesMenu, $helpMenu))
$form.MainMenuStrip = $menuStrip
$form.Controls.Add($menuStrip)
$form.StartPosition = "CenterScreen"
# 🖼️ Ustawienie ikony formularza
$iconPath = Join-Path $PSScriptRoot "app.ico"
if (Test-Path $iconPath) {
    $form.Icon = [System.Drawing.Icon]::ExtractAssociatedIcon($iconPath)
}
# ▶️ Uruchomienie formularza
[void]$form.ShowDialog()