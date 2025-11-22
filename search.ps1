Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing
$form = New-Object System.Windows.Forms.Form
$form.Text = "File Search"
$form.Size = New-Object System.Drawing.Size(330,175)
$form.StartPosition = "CenterScreen"
$resultBox = New-Object System.Windows.Forms.ListBox
$resultBox.Location = New-Object System.Drawing.Point(10,60)
$resultBox.Size = New-Object System.Drawing.Size(295,70)
$form.Controls.Add($resultBox)
$searchBox = New-Object System.Windows.Forms.TextBox
$searchBox.Location = New-Object System.Drawing.Point(10,20)
$searchBox.Size = New-Object System.Drawing.Size(295,20)
$form.Controls.Add($searchBox)
$folder = Join-Path -Path (Get-Location) -ChildPath "scripts"
$fileMap = @{}
function Update-Results {
    $resultBox.Items.Clear()
    $fileMap.Clear()
    $pattern = $searchBox.Text
    if (Test-Path $folder) {
        try {
            $files = Get-ChildItem -Path $folder -Recurse -File -ErrorAction SilentlyContinue |
                     Where-Object { $_.Name -like "*$pattern*" }
            foreach ($file in $files) {
                $resultBox.Items.Add($file.Name)
                $fileMap[$file.Name] = $file.FullName
            }
            if ($resultBox.Items.Count -eq 0 -and $pattern) {
                $resultBox.Items.Add("No results for '$pattern'.")
            }
        } catch {
            $resultBox.Items.Add("Error during search.")
        }
    } else {
        $resultBox.Items.Add("Folder 'scripts' does not exist.")
    }
}
$searchBox.Add_TextChanged({ Update-Results })
$resultBox.Add_DoubleClick({
    $selected = $resultBox.SelectedItem
    if ($selected -and $fileMap.ContainsKey($selected)) {
        Start-Process -FilePath $fileMap[$selected]
    }
})
$iconPath = Join-Path $PSScriptRoot "search.ico"
if (Test-Path $iconPath) {
    $form.Icon = [System.Drawing.Icon]::ExtractAssociatedIcon($iconPath)
}
$form.ShowDialog()