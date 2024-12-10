param (
    [Parameter(Mandatory = $true)]
    [string]$Instance,
    [Parameter(Mandatory = $true)]
    [int]$Port,
    [Parameter(Mandatory = $true)]
    [string]$DbName,
    [Parameter(Mandatory = $true)]
    [string]$UID,
    [Parameter(Mandatory = $true)]
    [string]$Password
)

# Caminho do diretório onde o script PowerShell está localizado
$diretorioScript = $PSScriptRoot

# Construir o caminho para o diretório "irmão" (no mesmo nível)
$diretorioSql = Join-Path -Path (Split-Path -Path $diretorioScript -Parent) -ChildPath "NotApplied"

# Verificando se o diretório "SqlScripts" existe
if (Test-Path $diretorioSql) {

    $logs = @()
    $ConnectionString = "Server=$Instance,$Port;Database=$DbName;User=$UID;Password=$Password;Encrypt=True;TrustServerCertificate=True;Connection Timeout=30;"
    #$plainPassword = [System.Net.NetworkCredential]::new("", $Password).Password
    $SqlFiles = Get-ChildItem -Path $diretorioSql -File -Filter *.sql

    for ($i = 0; $i -lt $SqlFiles.Count; $i++) {
        $SqlFile = $SqlFiles[$i]
        try {
            Invoke-Sqlcmd -ConnectionString $ConnectionString -InputFile $SqlFile.FullName -ErrorAction 'Stop'
            $LogMessage = ($SqlFile.Name + " Executed Successfully.")
        }
        catch {
            $LogMessage = "Error executing $($SqlFile.Name): $_"
            Write-Host "An error occurred: $_"
        }
        $row = [PSCustomObject]@{
            "File" = $SqlFile.Name
            "Date" = (Get-Date -UFormat "%d-%m-%Y")
            "Log"  = $LogMessage
        }
        $logs += $row  
    }
}
else {
    Write-Host "O diretório $diretorioSql não existe."
}

Write-Output ($logs | Format-Table -AutoSize -Wrap | Out-String)