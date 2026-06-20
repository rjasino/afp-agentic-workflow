param(
    [switch]$Install
)

$tools = @("node", "npm", "php", "python", "uv", "composer")
$passCount = 0
$failCount = 0

Write-Output "========================================"
Write-Output "  Tool Check Script"
Write-Output "========================================"

foreach ($tool in $tools) {
    Write-Output "----------------------------------------"
    Write-Output "Checking $tool..."

    $version = $null
    $available = $false

    if ($tool -eq "npm") {
        $result = & "node" -e "try { require('child_process').execSync('npm --version', { stdio: 'pipe' }).toString().trim(); console.log('OK') } catch(e) { console.log('FAIL') }" 2>$null
        if ($result -eq "OK") {
            $version = & "npm" --version 2>$null
        }
    } else {
        $version = & $tool --version 2>$null
    }

    if ($LASTEXITCODE -eq 0 -and $version) {
        Write-Output "[PASS] $tool is available. Version: $($version.Trim())"
        $passCount++
        $available = $true
    }

    if (-not $available) {
        Write-Output "  $tool is not available."
        $failCount++

        if ($tool -eq "npm") {
            Write-Output "  Attempting to set execution policy..."
            Set-ExecutionPolicy RemoteSigned -Scope CurrentUser -Force
            $version = & "npm" --version 2>$null
            if ($LASTEXITCODE -eq 0 -and $version) {
                Write-Output "[PASS] npm is available. Version: $($version.Trim())"
                $failCount--
                $passCount++
                $available = $true
            }
        }

        if (-not $available -and $Install) {
            Write-Output "  Installing $tool..."
            switch ($tool) {
                "node" {
                    winget install OpenJS.NodeJS -e 2>$null
                }
                "npm" {
                    winget install OpenJS.NodeJS -e 2>$null
                }
                "php" {
                    winget install PHP.PHP -e 2>$null
                }
                "python" {
                    winget install Python.Python.3.12 -e 2>$null
                }
                "uv" {
                    winget install astral.uv -e 2>$null
                }
                "composer" {
                    winget install Composer.Composer -e 2>$null
                }
            }
            $version = & $tool --version 2>$null
            if ($LASTEXITCODE -eq 0 -and $version) {
                Write-Output "[PASS] $tool installed. Version: $($version.Trim())"
                $failCount--
                $passCount++
            }
        }
    }
}

Write-Output "========================================"
Write-Output "  Check complete. Passed: $passCount, Failed: $failCount"
Write-Output "========================================"
