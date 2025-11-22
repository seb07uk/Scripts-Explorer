:: Created by Sebastian Januchowski
:: polsoft.its@fastservice.com

@echo off 

powershell -Command "& {Add-Type -AssemblyName System.Windows.Forms; [System.Windows.Forms.MessageBox]::Show('polsoft l.T.S.', 'This is an example', 'OK', [System.Windows.Forms.MessageBoxIcon]::Information);}"